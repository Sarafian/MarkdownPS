& "$PSScriptRoot\..\ISEScripts\Reset-Module.ps1"

$exportedNames=Get-Command -Module MarkDownPS | Select-Object -ExcludeProperty Name

. "$PSScriptRoot\Version.ps1"
$semVersion=Get-Version

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

    $guid="c1e7cbac-9e47-4906-8281-5f16471d7ccd"
    $hash=@{
        "Author"=$author;
        "Copyright"=$cop;
        "RootModule"=$psm1Name;
        "Description"=$description;
        "Guid"=$guid;
        "ModuleVersion"=$semVersion;
        "Path"=$psd1Path;
        "RequiredModules"=@{ModuleName="PSMarkdown";ModuleVersion="1.1"};
        "Tags"=@('Markdown', 'Tools');
        "LicenseUri"='https://github.com/Sarafian/MarkdownPS/blob/master/LICENSE';
        "ProjectUri"= 'https://github.com/Sarafian/MarkdownPS/';
        "IconUri" ='https://github.com/dcurtis/markdown-mark/blob/master/png/66x40-solid.png';
        "ReleaseNotes"= 'Initial Release on Powershell Gallery';
        "CmdletsToExport" = $exportedNames;
        "FunctionsToExport" = $exportedNames;
        "PowerShellHostVersion"="4.0"
    }
    New-ModuleManifest  @hash 
    $nuspec=$ExecutionContext.InvokeCommand.ExpandString($nuspecTemplate)
    $nuspec|Out-File $nuspecPath -Force
}
Pop-Location -stackname $stackName


