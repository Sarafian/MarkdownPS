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

& "$PSScriptRoot\Initialize-Pester.ps1"

$modulesToTest=@(
    "MarkdownPS"
)

$failedCount=0
$modulesToTest | ForEach-Object {
    $testPath=Resolve-Path "$PSScriptRoot\..\Modules\$_"
    
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
    
        $pesterResult = Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -OutputFormat $OutputFormat -OutputFile $outputFile -PassThru
    }
    else {
        $pesterResult =  Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -PassThru
    }

    if($pesterResult.FailedCount -gt 0)
    {
        $failedCount+=$pesterResult.FailedCount
        Write-Error "$_ failed"
    }
}
exit $failedCount

