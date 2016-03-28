Param (
    [Parameter(
        Mandatory = $true
    )]
    [ValidateNotNullOrEmpty()]
    [string]$NuGetApiKey
)

& "$PSScriptRoot\..\Pester\Test-All.ps1"
if($LASTEXITCODE -ne 0)
{
    Write-Error "Stopping"
    exit -1
}
& "$PSScriptRoot\PreparePSD1AndNuSpec.ps1"
Publish-Module -Name MarkdownPS -NuGetApiKey $NuGetApiKey

