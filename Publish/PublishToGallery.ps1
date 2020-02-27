Param (
    [Parameter(
        Mandatory = $false
    )]
    [ValidateNotNullOrEmpty()]
    [string]$NuGetApiKey=$null
)

& "$PSScriptRoot\..\Pester\Test-All.ps1"
if($LASTEXITCODE -ne 0)
{
    Write-Error "Stopping"
    exit -1
}
& "$PSScriptRoot\PreparePSD1.ps1"

if($NuGetApiKey)
{
    Publish-Module -Path "$PSScriptRoot\..\Modules\MarkdownPS" -NuGetApiKey $NuGetApiKey
}
else {
    Publish-Module -Path "$PSScriptRoot\..\Modules\MarkdownPS" -NuGetApiKey "test" -WhatIf
}


