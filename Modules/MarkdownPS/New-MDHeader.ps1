<#
    .SYNOPSIS
        This commandlet output header in markdown syntax

    .DESCRIPTION
        This commandlet output header in markdown syntax by adding a '# '

    .PARAMETER  Text
        Any text

    .PARAMETER  Level
        The level of header

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        New-MDHeader -Text "This is an H1"
        "This is an H1" | New-MDHeader -Text
        
        # This is an H1

    .EXAMPLE
        New-MDHeader -Text "This is an H2" -Level 2
        "This is an H2" | New-MDHeader -Text -Level 2
        
        ## This is an H2

    .INPUTS
        An array of lines

    .OUTPUTS
        Each line with a '# ' in the front

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        New-MDParagraph
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
Function New-MDHeader {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Text,
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNull()]
        [ValidateRange(1,6)]
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
            $prefix+="#"
        }
    }

    Process {
        if($output -ne "")
        {
            $output+=[System.Environment]::NewLine
        }
        $output+="$prefix $Text"
    }

    End {
        if(-not $NoNewLine)
        {
            $output+=[System.Environment]::NewLine
        }
        $output
    }
}
