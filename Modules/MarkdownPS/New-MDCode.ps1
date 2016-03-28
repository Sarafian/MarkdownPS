function New-MDCode {
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
        [string]$Style=$null
    )

    Begin {
        $output="``````$Style"+[System.Environment]::NewLine
        $prefix="    "
        for($i=1; $i -le $Level; $i++)
        {
            $prefix+=">"
        }
    }

    Process {
        $Lines|ForEach-Object {
            $output+="$prefix"+$_+[System.Environment]::NewLine
        }
    }

    End {
        $output+"``````"+[System.Environment]::NewLine
    }
}
