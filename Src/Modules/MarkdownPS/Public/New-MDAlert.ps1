<#
    .SYNOPSIS
        This commandlet output Github Flavoured Markdown alerts based on blockquote in markdown syntax

    .DESCRIPTION
        This cmdlet outputs a quote in markdown syntax which are Github Flavoured Markdown syntax, by adding `> [!STYLE]` as the first line, followed by the input lines each prefixed with `> ` on consecutive lines. 
        Refer "https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts" for more details.

    .PARAMETER  Lines
        An array of lines to quote in markdown

    .PARAMETER  Style
        The Style of choice, options are one of (Tips, Warning, Note, Important, Caution), default style is Note

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        New-MDAlert -Lines "Line 1"

        > [!NOTE]
        > Line 1

    .EXAMPLE
        New-MDAlert -Lines "Line 1" -Style Tip

        > [!NOTE]
        > Line 1

        # Style accepts one of 4 value (Note, Tip, Important and Warning)        

    .EXAMPLE
        New-MDAlert -Lines @("Line 1","Line 2") -Style Important

        > [!IMPORTANT]
        > Line 1
        > Line 2

    .EXAMPLE
        @("Line 1","Line 2") | New-MDAlert -Style Caution

        > [!CAUTION]
        > Line 1
        > Line 2

    .LINK
    Refer "https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts" for more details.

    .INPUTS
        An array of lines and choice of Style

    .OUTPUTS
        First line > [!STYLE] followed by each input line with a '> ' in the front 

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        New-MDAlert
        https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts
#>
function New-MDAlert {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [string[]]$Lines,
        [ValidateSet('Note', 'Tip', 'Important', 'Warning', 'CAUTION')]
        [string]$Style = 'Note',
        [ValidateNotNullOrEmpty()]
        [switch]$NoNewLine = $false
    )
    
    Begin {
        $output = ''
        $newLine = [System.Environment]::NewLine
        $admonition = '> [!{0}]' -f $Style.ToUpper()
        $output += $admonition + $newLine
        $processCallCounter = 0
    }
    
    Process {
        $processCallCounter++
        if ($processCallCounter -gt 1) { 
            $output += '>' + $newLine
        }
        $output += New-MDQuote -Lines $Lines -Level 1 -NoNewLine
    }
    
    End {
        if (-not $NoNewLine) {
            $output += $newLine
        }
        $output
    }
}