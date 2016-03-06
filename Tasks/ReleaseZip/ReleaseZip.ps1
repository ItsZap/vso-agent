param (
    [string]$pkgDefinition,
    [string]$versionByBuild
)

# Celebration
gc $PSScriptRoot\logo.txt
Write-Host "Entering script $($MyInvocation.MyCommand.Name)"
Write-Host "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{	
	Write-Host ("    {0} = {1}" -f $key,$PSBoundParameters[$key])
}
Write-Host "Importing modules.."
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

# PREP
$pkgFiledef = gci $pkgDefinition 
$workingDir = $env:SYSTEM_DEFAULTWORKINGDIRECTORY 

function ZipFiles($zipFilename, $source)
{
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    Add-Type -AssemblyName System.IO.Compression

    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
    [System.IO.Compression.ZipFile]::CreateFromDirectory($source,$zipFilename,$compressionLevel,$false)
}

# Step 0. Check if environment setting is available
$useBuildVersion = Convert-String $versionByBuild Boolean
$newVersion = ""
if($useBuildVersion -and $env:BUILD_BUILDNUMBER)
{
    Write-Verbose "Reading version number from build"    

    $versionRegex = "\d+\.\d+\.\d+(?:\.\d+)?"
    $versionInfo = [regex]::matches($env:BUILD_BUILDNUMBER,$versionRegex)
    switch($versionInfo.Count)
    {
       0 {
           Write-Warning "Could not find version number in BUILD_BUILDNUMBER."
           $newVersion = $env:BUILD_BUILDNUMBER
       }
       1 {
           $newVersion = $versionInfo[0]
       }
       default {
          Write-Warning "Found multiple version info in BUILD_BUILDNUMBER"
          Write-Warning "Assuming first instance is version."   
          $newVersion = $versionInfo[0]       
       }
    }    
       
    Write-Verbose "Version: $newVersion"
} elseif($useBuildVersion)
{
    Write-Warning "BUILD_BUILDNUMBER environment variable is missing. Output filename will not be changed!"
}

if($newVersion -ne "")
{
   $newVersion = "_$newVersion" -replace "\.","_"
}

# Step 1 Prepare staging directory
Write-Host "Trying to read packaging rule $pkgDefinition"
$pkgDef = gc $pkgDefinition | ConvertFrom-Json

$baseFolder = Join-Path $env:BUILD_STAGINGDIRECTORY "ReleaseZip"
$baseZipfolder = $baseFolder

if($pkgDef.targetroot -and $pkgDef.targetroot -ne "")
{
   $baseZipfolder = Join-Path $baseFolder $pkgDef.targetroot
}

if((Test-Path $baseFolder))
{
   Remove-Item -Path $baseFolder -Recurse -Force
}
New-Item $baseZipfolder -ItemType Directory -Force
gci $baseFolder

foreach($i in $pkgDef.content)
{  
   $targetDir = Join-Path $baseZipfolder $i.target.Trim("/")

   Write-Host "Prepare directory $targetDir ..."
   if(-not (Test-Path $targetDir))
   {
      New-Item $targetDir -ItemType Directory -Force | out-null
   }

   Write-Host "   Search file pattern $($i.source) ..."
   $findFiles = Find-Files  (Join-Path $env:SYSTEM_DEFAULTWORKINGDIRECTORY $i.source)
   foreach($file in $findFiles)
   {
      Copy-Item -Path $file  -Destination $targetDir -Force
   }
}

$targetZipFile = "{0}\{1}{2}.zip" -f $env:BUILD_STAGINGDIRECTORY,$pkgFiledef.BaseName,$newVersion

if(Test-Path $targetZipFile)
{
   Remove-item "$targetZipFile" -Force
}

ZipFiles -zipFilename "$targetZipFile" -source $baseFolder

Write-Host "Cleanup"
Remove-Item $baseFolder -Recurse -Force

Write-Host "The zip file is available in $targetZipFile"
Write-Host "Use Publish Artifact task to upload the zip file"
Write-Host "Leaving script $($MyInvocation.MyCommand.Name)"