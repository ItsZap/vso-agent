param (
    [string]$searchPattern,
    [string]$versionByBuild
)

Write-Verbose 'Entering script $MyInvocation.MyCommand.Name'
Write-Verbose "Parameter Values"
foreach($key in $PSBoundParameters.Keys)
{
	
	Write-Verbose ("{0} = {1}" -f $key,$PSBoundParameters[$key])
}
Write-Verbose "Importing modules"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Internal"
Import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"

# Prepare working tools
$nuGetPath = Get-ToolPath -Name 'NuGet.exe';
if(-not $nugetPath)
{
	Write-Verbose ("Unable to locate {0}" -f 'nuget.exe')
}


Write-Verbose 'Leaving script $MyInvocation.MyCommand.Name'