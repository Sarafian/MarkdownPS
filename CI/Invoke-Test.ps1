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

# https://pester-docs.netlify.app/docs/commands/New-PesterConfiguration
$pesterConfiguration=New-PesterConfiguration
$pesterConfiguration.Run.Path=$srcPath
$pesterConfiguration.Run.PassThru=$true
$pesterConfiguration.Run.Path=$srcPath
$pesterConfiguration.Filter.Tag=$Tag
$pesterConfiguration.Filter.ExcludeTag=$ExcludeTag

$pesterConfiguration.TestResult.Enabled=$true
$pesterConfiguration.TestResult.OutputFormat="NUnitXml"
$pesterConfiguration.TestResult.OutputPath=$outputFile

$pesterConfiguration.Output.Verbosity="Detailed"
#$pesterConfiguration.Output.Verbosity="Diagnostic"

if($CodeCoverage)
{
    $pesterConfiguration.CodeCoverage.Enabled=$true
#    $pesterConfiguration.CodeCoverage.OutputFormat="JaCoCo"
    $pesterConfiguration.CodeCoverage.OutputPath=$outputFile.Replace(".xml",".codecoverage.xml")
}

$pesterResult=Invoke-Pester -Configuration $pesterConfiguration
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
        if ($pesterResult.FailedCount -gt 0) { 
            throw "$($pesterResult.FailedCount) tests failed."
       }        
    }
    'Console' {

    }
}