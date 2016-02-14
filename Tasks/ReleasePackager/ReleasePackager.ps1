param (
    [string]$mainNuspec,
    [string]$versionByBuild
)

Write-Host "Entering script $($MyInvocation.MyCommand.Name)"
Write-Host "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{
	
	Write-Host ("    {0} = {1}" -f $key,$PSBoundParameters[$key])
}
Write-Host "Importing modules"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

# Static references
$nugetOriginalUrl = "https://nuget.org/nuget.exe"

# Helpers functions
function DownloadFile($source,$destination)
{
    $client = New-Object System.Net.WebClient
    $client.DownloadFile($source,$destination)
}

function FindNuget($searchLoc)
{
    $findNuget = gci -Path $searchLoc -Filter "nuget.exe" -Recurse | sort LastWriteTime | select -Last 1
    if($findNuget -eq $null)
    {
       Write-Host "Not found!" -ForegroundColor Red
       return $null       
    } 

    return $findNuget.FullName
 }

# Step 1. Prepare the tools Nuget.exe

Write-Host "Check if I can find default Nuget.exe" -NoNewline
$nuGetPath = Get-ToolPath -Name 'NuGet.exe'
if(-not $nugetPath)
{
   Write-Host "Not found!" -ForegroundColor Red
   Write-Host "Check if I can find in working directory $PSScriptRoot " -NoNewline
   $nugetPath = FindNuget -searchLoc $PSScriptRoot

   if(-not $nuGetPath)
   {
        Write-Host "Try to download from internet.." -NoNewline
        DownloadFile -source $nugetOriginalUrl -destination $PSScriptRoot\nuget.exe
        $nugetPath = FindNuget -searchLoc $PSScriptRoot
        if(-not $nuGetPath)
        {
           throw("Can not find Nuget.exe")
        }
   }
} 
   
Write-Host "Found! Using Nuget binary path: $nugetPath" -ForegroundColor Green

# Step 2. Combine *.nuspec file. Follow name convention Main.nuspec , [*].Main.nuspec example File1.Main.nuspec, File2.Main.nuspec

# Step 3. Execute Nuget packager

# Step 4. Upload Relase package to galler

Write-Host 'Leaving script $MyInvocation.MyCommand.Name'