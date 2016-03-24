Param (
    [Parameter(
        Mandatory = $false            
    )]
    [ValidateSet("LegacyNUnitXml","NUnitXml")]
    [string]$OutputFormat=$null,
    [Parameter(
        Mandatory = $false
    )]
    [string]$OutputPath=$null
)

& "$PSScriptRoot\Initialize-Dependencies.ps1" 
& "$PSScriptRoot\Initialize-Pester.ps1"

$env:PSModulePath -split ';'


$testPath=Resolve-Path "$PSScriptRoot\..\Modules\MarkdownPS"

if($OutputFormat) {
    $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".").Replace(".ps1", "")
    if($OutputPath -and ($OutputPath -ne ""))
    {
        $outputFile="$OutputPath\$sut.xml"
    }
    else
    {
        $outputFile="$PSScriptRoot\$sut.xml"
    }
    
    $pesterResult=Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -OutputFormat $OutputFormat -OutputFile $outputFile -PassThru
}
else {
    $pesterResult=Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -PassThru
}

$pesterResult
if($pesterResult.FailedCount -gt 0)
{
    Write-Error "Test-MarkdownPS.ps1 failed"
    exit $pesterResult.FailedCount
}
exit 0

