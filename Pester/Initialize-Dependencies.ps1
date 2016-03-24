# When ConvertTo-Markdown commandlet is not available
# Download and import
try
{
    if(-not (Get-Command ConvertTo-Markdown -ErrorAction SilentlyContinue)) {
        Write-Warning "ConvertTo-Markdown commandlet not found"

        $url='https://raw.githubusercontent.com/ishu3101/PSMarkdown/master/ConvertTo-Markdown.ps1'
        $output = Join-Path $env:TEMP "ConvertTo-Markdown.ps1"
        Write-Verbose "Downloading $url to $output"

        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $output)

        Write-Verbose "Importing $output"

        . $output
    }
}
catch
{
    Write-Error $_
    exit -1
}


