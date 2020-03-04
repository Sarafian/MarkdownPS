<#
    .SYNOPSIS
        This commandlet output paragraph in markdown syntax

    .DESCRIPTION
        This commandlet output paragraph in markdown syntax

    .PARAMETER  Lines
        An array of lines to paragraph in markdown

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        New-MDParagraph
        
        An empty line

    .EXAMPLE
        New-MDParagraph -Lines "Line 1"
        "Line 1" | New-MDParagraph

        Line 1

    .EXAMPLE
        New-MDParagraph -Lines @("Line 1","Line 2")
        @("Line 1","Line 2") | New-MDParagraph

        Line 1
        Line 2

    .INPUTS
        An array of lines

    .OUTPUTS
        Each line

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        New-MDHeader
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
function New-MDParagraph {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [string[]]$Lines=$null,
        [Parameter(
            ValueFromPipeline = $false
        )]
        [ValidateNotNullOrEmpty()]
        [switch]$NoNewLine=$false
    )

    Begin {
        $output=""
    }

    Process {
        if($Lines)
        {
            $Lines|ForEach-Object {$output+=$_+[System.Environment]::NewLine}
        }
        else
        {
            $output+=[System.Environment]::NewLine
        }
    }

    End {
        if(-not $NoNewLine)
        {
            $output+=[System.Environment]::NewLine
        }
        $output
    }
}