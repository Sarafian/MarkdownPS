Param (
    [Parameter(
        Mandatory = $true
    )]
    [ValidateNotNullOrEmpty()]
    [string]$NuGetUri,
    [Parameter(
        Mandatory = $false
    )]
    [string]$ApiKey=$null
)
$stackName="PublishAutomation"
Push-Location $PSScriptRoot -stackname $stackName

$modules=Get-ChildItem ..\Modules\
foreach($module in $modules)
{
    $name=$module.Name

    $nuspecName=$name+".nuspec"
    $nuspecPath=Join-Path $module.FullName $nuspecName

    [xml]$nuspec=Get-Content $nuspecPath
    $id=$nuspec.package.metadata.id
    $version=$nuspec.package.metadata.version

    $outputPath=(Get-ItemProperty $env:TEMP).FullName
    $expectedNuGetPath=Join-Path $outputPath "$id.$version.nupkg"

    if(Test-Path $expectedNuGetPath)
    {
        Remove-Item $expectedNuGetPath -Force
    }
    & .\Nuget.exe pack $nuspecPath -OutputDirectory $outputPath
    $nugetArgs=@(
        "push",
        $expectedNuGetPath,
        "Source",
        $nugetUri
    )
    if(-not $ApiKey)
    {
        $nugetArgs+=@(
            "ApiKey",
            $ApiKey
        )
    }
    & .\Nuget.exe $nugetArgs
}
Pop-Location -StackName $stackName