Function New-MDInlineCode {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Text
    )

    Begin {
        $output=@()
    }

    Process {
        $output+="``$Text``"
    }

    End {
        $output
    }
}
