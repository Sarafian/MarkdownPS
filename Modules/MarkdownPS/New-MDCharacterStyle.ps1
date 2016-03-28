function New-MDCharacterStyle {
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
            Mandatory = $true
        )]
        [ValidateSet("Bold","Italic","StrikeThrough")]
        [string]$Style
    )

    Begin {
    }

    Process {
        switch ($Style) 
        { 
            "Bold" {$surround="**"} 
            "Italic" {$surround="*"} 
            "StrikeThrough" {$surround="~~"} 
        }
    }

    End {
        "$surround$Text$surround"
    }

}
