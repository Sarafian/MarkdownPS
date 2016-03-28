Write-Verbose "Add modules directory to PSModulePath"
$modulePath= Resolve-Path "$PSScriptRoot\..\Modules"
$env:PSModulePath+=";$modulePath"
$env:PSModulePath -split ';'