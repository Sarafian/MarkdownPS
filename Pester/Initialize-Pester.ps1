#Check if Pester module is available
if(-not (Get-Command New-Fixture -ErrorAction SilentlyContinue)) {
    $modulePath= Resolve-Path "$PSScriptRoot\Modules"
    Write-Verbose "Add Pester modules directory to PSModulePath"
    $env:PSModulePath+=";$modulePath"
    $env:PSModulePath -split ';'
}