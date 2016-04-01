<#
    .SYNOPSIS
        This commandlet output a table in markdown syntax

    .DESCRIPTION
        This commandlet output quote in markdown syntax by adding a two rows for the header and then one line per entry in the array.

    .PARAMETER  Object
        Any object

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .EXAMPLE
        Get-Command New-MDTable |Select-Object Name,CommandType | New-MDTable

        Name        | CommandType
        ----------- | -----------
        New-MDTable | Function   

    .INPUTS
        Any table

    .OUTPUTS
        A table representation in markdown

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.

    .LINK
        ConvertTo-Markdown
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
function New-MDTable {
[CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [PSObject[]]$Object,
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
        if($output -eq "")
        {
            $output+=($Object |ConvertTo-Markdown) -join [System.Environment]::NewLine
        }
        else
        {
            Throw "Piping array of objects is not supported"
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
