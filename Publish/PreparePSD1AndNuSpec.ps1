$major=0
$minor=0
$patch=1

$date=Get-Date
<#Semantic version doesn't work yet when Install-Package
$prerelease="alpha"
$build=[string](1200 * ($date.Year -2015)+$date.Month*100+$date.Day)+"-"+$date.ToString("HHmmss")
$semVersion="$major.$minor.$patch-$prerelease-$build"
#>

$build=[string](1200 * ($date.Year -2015)+$date.Month*100+$date.Day)+$date.ToString("HHmmss")
$semVersion="$major.$minor.$build.$patch"

$author="Alex Sarafian"
$company=""
$copyright="(c) $($date.Year) $company. All rights reserved."
$description="A module to help render Markdown from powershell"

$nuspecTemplate='<?xml version="1.0"?>
<package >
  <metadata>
    <id>$name</id>
    <version>$semVersion</version>
    <authors>$author</authors>
    <owners>$company</owners>
    <requireLicenseAcceptance>false</requireLicenseAcceptance>
    <description>$description</description>
    <!--<releaseNotes>Summary of changes made in this release of the package.</releaseNotes>-->
    <copyright>$copyright</copyright>
    <tags></tags>
    <dependencies>
    </dependencies>
  </metadata>
</package>
'

$stackName="PrepareAutomation"
Push-Location $PSScriptRoot -stackname $stackName

$modules=Get-ChildItem ..\Modules\


foreach($module in $modules)
{
    Write-Host "Processing $module"
    $name=$module.Name

    $psm1Name=$name+".psm1"
    $psd1Name=$name+".psd1"
    $nuspecName=$name+".nuspec"
    $psd1Path=Join-Path $module.FullName $psd1Name
    $nuspecPath=Join-Path $module.FullName $nuspecName

    $guid=[guid]::NewGuid()|Select-Object -ExpandProperty Guid
    New-ModuleManifest -RootModule $psm1Name -CompanyName "SDL Plc" -Description $description -Guid $guid -ModuleVersion $semVersion -Path $psd1Path -RequiredModules @{ModuleName="PSMarkdown";ModuleVersion="1.1"}
    $nuspec=$ExecutionContext.InvokeCommand.ExpandString($nuspecTemplate)
    $nuspec|Out-File $nuspecPath -Force
}
Pop-Location -stackname $stackName
