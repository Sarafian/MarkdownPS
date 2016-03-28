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

    <# This is an alternative to mocking the ConvertTo-Markdown. 
    if($_ -eq "WithDependency")
    {
        $VerbosePreference="Continue"
        $ps1Path=Resolve-Path "$PSScriptRoot\..\Modules\DemoPester\Test-DemoPester.ps1"
        Write-Verbose "Importing $ps1Path"
        . $ps1Path

        if(-not (Get-Command ConvertTo-Markdown -ErrorAction SilentlyContinue)) {
            Write-Warning "ConvertTo-Markdown commandlet not found"

            $wc = New-Object System.Net.WebClient

            $url='https://raw.githubusercontent.com/ishu3101/PSMarkdown/master/ConvertTo-Markdown.ps1'
            $ps1Path = Join-Path $env:TEMP "ConvertTo-Markdown.ps1"
            Write-Verbose "Downloading $url to $ps1Path"
            $wc.DownloadFile($url, $ps1Path)

            Write-Verbose "Importing $ps1Path"
            . $ps1Path
            Get-Command ConvertTo-Markdown
        }
        $VerbosePreference="SilentlyContinue"
    }
    #>
    
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

