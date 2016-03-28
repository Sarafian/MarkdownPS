if($psISE)
{
    $modules=Get-ChildItem "$PSScriptRoot\..\Modules\" |Select-Object -ExpandProperty Name
    foreach($module in $modules)
    {
        Import-Module $module -Force -Verbose
    }
}
else
{
    & "$PSScriptRoot\Add-ModuleToPSModulePath.ps1"
}

