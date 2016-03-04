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