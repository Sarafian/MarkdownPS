$showcasePath=Resolve-Path -Path "$PSScriptRoot\..\Showcase"
$showcaseMDPath=Join-Path -Path $showcasePath -ChildPath "Showcase.md"
$showcaseScriptPath=Join-Path -Path $showcasePath -ChildPath "Showcase.ps1"

$markdown=& $showcaseScriptPath
$markdown|Out-File -FilePath $showcaseMDPath -Force
