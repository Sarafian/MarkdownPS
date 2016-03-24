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

$testPath=Resolve-Path "$PSScriptRoot\..\Modules\MarkdownPS"

if($OutputFormat) {
    $parms["OutputFormat"]="$OutputFormat"

    $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".").Replace(".ps1", "")
    if($OutputPath -and ($OutputPath -ne ""))
    {
        $outputFile="$OutputPath\$sut.xml"
    }
    else
    {
        $outputFile="$PSScriptRoot\$sut.xml"
    }
    
    Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -OutputFormat $OutputFormat -OutputFile $outputFile -PassThru
}
else {
    Invoke-Pester -CodeCoverage "*.ps1" -Path $testPath -PassThru
}

