<#
    .SYNOPSIS
        This commandlet output markdown alerts based on blockquote in markdown syntax

    .DESCRIPTION
        This cmdlet outputs a quote in markdown syntax by adding `> [!STYLE]` as the first line, followed by the input lines each prefixed with `> ` on consecutive lines.

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
        New-MDAlert -Lines @("Line 1","Line 2") -Style Important

        > [!IMPORTANT]
        > Line 1
        > 
        > Line 2

    .EXAMPLE
        @("Line 1","Line 2") | New-MDAlert -Style Caution

        >> [!CAUTION]
        >> Line 1
        >>
        >> Line 2

    .INPUTS
        An array of lines

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
        $Admonition = '[!{0}]' -f $Style.ToUpper()
        $output += New-MDQuote -Lines $Admonition -Level 1 -NoNewLine
    }
    
    Process {
        $lines | ForEach-Object {
            $output += New-MDQuote -Lines $_ -Level 1 -NoNewLine
        }
    }
    
    End {
        if (-not $NoNewLine) {
            $output += [System.Environment]::NewLine
        }
        $output
    }
}