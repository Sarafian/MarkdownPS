<#
    .SYNOPSIS
        This commandlet output list in markdown syntax

    .DESCRIPTION
        This commandlet output list in markdown syntax. Depending if the list is unordered or ordere, the '- ' or '1. ' is added in front of each line

    .PARAMETER  Lines
        An array of lines to make a list in markdown

    .PARAMETER  Level
        The level of list

    .PARAMETER  Style
        The type of list. Ordered or Unordered

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        New-MDList -Lines "Line 1" -Style Unordered
        "Line 1" | New-MDList -Style Unordered

        - Line 1

    .EXAMPLE
        New-MDList -Lines @("Line 1","Line 2") -Style Unordered
        @("Line 1","Line 2") | New-MDList -Style Unordered

        - Line 1
        - Line 2

    .EXAMPLE
        New-MDList -Lines "Line 1" -Style Ordered
        "Line 1" | New-MDList -Style Ordered

        1. Line 1

    .EXAMPLE
        New-MDList -Lines @("Line 1","Line 2") -Style Ordered
        @("Line 1","Line 2") | New-MDList -Style Ordered

        1. Line 1
        2. Line 2



    .INPUTS
        An array of lines

    .OUTPUTS
        Each line with a '- ' or '1. ' in the front depending on the type of the list.

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        New-MDParagraph
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
function New-MDList {
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
            Mandatory = $true
        )]
        [ValidateSet("Unordered","Ordered")]
        [string]$Style,
        [Parameter(
            ValueFromPipeline = $false
        )]
        [ValidateNotNullOrEmpty()]
        [switch]$NoNewLine=$false
    )

    Begin {
        $output=""
        $counter=1
        $prefix=""
        for($i=2; $i -le $Level; $i++)
        {
            switch ($Style) 
            { 
                "Unordered" {
                    $prefix+="  "
                } 
                "Ordered" {
                    $prefix+="   "
                } 
            }
        }
    }

    Process {
        switch ($Style) 
        { 
            "Unordered" {
                $Lines|ForEach-Object {$output+="$prefix- "+$_+[System.Environment]::NewLine}
            } 
            "Ordered" {
                $Lines|ForEach-Object {
                    $output+="$prefix$counter. "+$_+[System.Environment]::NewLine
                    $counter++
                }
            }
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
