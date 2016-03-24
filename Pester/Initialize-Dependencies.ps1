# When ConvertTo-Markdown commandlet is not available
# Download and import
if(-not (Get-Command ConvertTo-Markdown -ErrorAction SilentlyContinue)) {
    $url='https://raw.githubusercontent.com/ishu3101/PSMarkdown/master/ConvertTo-Markdown.ps1'
    $output = Join-Path $env:TEMP "ConvertTo-Markdown.ps1"

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $output)

    . $output
}

