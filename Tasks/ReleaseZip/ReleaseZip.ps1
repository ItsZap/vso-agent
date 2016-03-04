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
Write-Host "Importing modules"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

# TODO

function ZipFiles($zipFilename, $source)
{
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    Add-Type -AssemblyName System.IO.Compression

    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
    [System.IO.Compression.ZipFile]::CreateFromDirectory($source,$zipFilename,$compressionLevel,$false)
}

# Step 1 Prepare staging directory
$pkgDef = gc .\packaging.json | ConvertFrom-Json


foreach($i in $pkgContent.content)
{
  write-host $i.source
  write-host $i.target
}

# Step 2 run Find-Files and pass the filepath to zipper
# Step 3 done