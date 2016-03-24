function New-MDTable {
[CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        $Object,
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
        $output+=($Object |ConvertTo-Markdown) -join [System.Environment]::NewLine
    }

    End {
        if(-not $NoNewLine)
        {
            $output+=[System.Environment]::NewLine
        }
        $output
    }
}
