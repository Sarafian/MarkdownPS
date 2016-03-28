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
