<#
    .SYNOPSIS
        This commandlet output quote in markdown syntax

    .DESCRIPTION
        This commandlet output quote in markdown syntax by adding a '> ' in front of each line

    .PARAMETER  Lines
        An array of lines to quote in markdown

    .PARAMETER  Level
        The level of quote

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        New-MDQuote -Lines "Line 1"

        > Line 1

    .EXAMPLE
        New-MDQuote -Lines @("Line 1","Line 2")

        > Line 1
        > 
        > Line 2

    .EXAMPLE
        @("Line 1","Line 2") | New-MDQuote -Level 2

        >> Line 1
        >>
        >> Line 2

    .INPUTS
        An array of lines

    .OUTPUTS
        Each line with a '> ' in the front

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        New-MDCode
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
function New-MDQuote {
[CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [string[]]$Lines,
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNull()]
        [ValidateRange(1,3)]
        [int]$Level=1,
        [Parameter(
            ValueFromPipeline = $false
        )]
        [ValidateNotNullOrEmpty()]
        [switch]$NoNewLine=$false
    )

    Begin {
        $output=""
        $prefix=""
        for($i=1; $i -le $Level; $i++)
        {
            $prefix+=">"
        }
    }

    Process {
        $Lines|ForEach-Object {
            if($output -ne "")
            {
                $output+="$prefix"+[System.Environment]::NewLine
            }
            $output+="$prefix "+$_+[System.Environment]::NewLine
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
