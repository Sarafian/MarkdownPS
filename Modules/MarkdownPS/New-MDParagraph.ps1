function New-MDParagraph {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [string[]]$Lines=$null
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
        $output
    }
}