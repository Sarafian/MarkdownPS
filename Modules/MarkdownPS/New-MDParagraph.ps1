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