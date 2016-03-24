#Check if Pester module is available
if(-not (Get-Command ConvertTo-Markdown -ErrorAction SilentlyContinue)) {
    Write-Verbose "Installing dependency PSMarkdown"
    Install-Module PSMarkdown -Scope CurrentUser -Force
}