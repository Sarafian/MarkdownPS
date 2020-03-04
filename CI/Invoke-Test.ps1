param(
    [Parameter(Mandatory=$true,ParameterSetName="AppVeyor")]
    [switch]$AppVeyor,
    [Parameter(Mandatory=$false,ParameterSetName="AppVeyor")]
    [Parameter(Mandatory=$false,ParameterSetName="Console")]
    [string[]]$Tag=$null,
    [Parameter(Mandatory=$false,ParameterSetName="AppVeyor")]
    [Parameter(Mandatory=$false,ParameterSetName="Console")]
    [string[]]$ExcludeTag=$null,
    [Parameter(Mandatory=$false,ParameterSetName="AppVeyor")]
    [Parameter(Mandatory=$false,ParameterSetName="Console")]
    [switch]$CodeCoverage=$false
)
$srcPath=Resolve-Path -Path "$PSScriptRoot\..\Src"
$outputFile=[System.IO.Path]::GetTempFileName()+".xml"
$splat=@{
    Script=$srcPath
    PassThru=$true
    OutputFormat="NUnitXml"
    OutputFile=$outputFile
    ExcludeTag=$ExcludeTag
    Tag=$Tag
}
if($CodeCoverage)
{
    $codeCoveragePath=$outputFile.Replace(".xml",".codecoverage.xml")
    $splat+=@{
        CodeCoverage=Get-ChildItem -Path $srcPath -Exclude @("*.Tests.ps1","*.NotReady.ps1","Src\Tests\**") -Filter "*.ps1" -Recurse|Select-Object -ExpandProperty FullName
        CodeCoverageOutputFile=$codeCoveragePath        
    }
}

$pesterResult=Invoke-Pester @splat
if($CodeCoverage)
{
    $pesterResult|Select-Object @{
        Name="CommandsAnalyzed"
        Expression={$_.CodeCoverage.NumberOfCommandsAnalyzed}
    },@{
        Name="FilesAnalyzed"
        Expression={$_.CodeCoverage.NumberOfFilesAnalyzed}
    },@{
        Name="CommandsExecuted"
        Expression={$_.CodeCoverage.NumberOfCommandsExecuted}
    },@{
        Name="CommandsMissed"
        Expression={$_.CodeCoverage.NumberOfCommandsMissed}
    }
}

switch($PSCmdlet.ParameterSetName) {
    'AppVeyor' {
        (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $outputFile)
    }
    'Console' {

    }
}
if ($pesterResult.FailedCount -gt 0) { 
     throw "$($pesterResult.FailedCount) tests failed."
}