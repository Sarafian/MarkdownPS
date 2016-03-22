function New-MDImage {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
            
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Link,
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Title=$null,
        [Parameter(
            Mandatory = $false
        )]
        [string]$AltText=$null
    )

    Begin {
        $output=""
    }

    Process {
        $output+="![$AltText]($Link"
        if($Title)
        {
            $output+=" ""$Title"""
        }

        $output+=")"
    }

    End {
        $output
    }

}
