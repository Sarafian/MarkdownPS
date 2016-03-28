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
