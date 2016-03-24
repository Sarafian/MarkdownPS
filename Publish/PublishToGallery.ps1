Param (
    [Parameter(
        Mandatory = $true
    )]
    [ValidateNotNullOrEmpty()]
    [string]$NuGetApiKey
)

$pesterResult=& "$PSScriptRoot\..\Pester\Test-MarkdownPS.ps1"
if($pesterResult.FailedCount -gt 0)
{
    Write-Error "Test-MarkdownPS.ps1 tests failed"
    exit -1
}
& "$PSScriptRoot\PreparePSD1AndNuSpec.ps1"
Publish-Module -Name MarkdownPS -NuGetApiKey $NuGetApiKey

