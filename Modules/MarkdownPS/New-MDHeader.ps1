<#
.Synopsis
   Creates a new header line.
.Description
   The New-MDHeader function creates a new header line for markdown
.EXAMPLE
   New-MDHeader -Text "H"

   This command outputs # H 
.EXAMPLE
   "H"|New-MDHeader

   This command outputs # H 
.EXAMPLE
   New-MDHeader -Text "H" -Level 2

   This command outputs ## H 
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
        $output=@()
        $prefix=""
        for($i=1; $i -le $Level; $i++)
        {
            $prefix+="#"
        }
    }

    Process {
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
