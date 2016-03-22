function New-MDLink {
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
        [ValidateNotNullOrEmpty()]
        [string]$Link,
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Title=$null

    )

    Begin {
        $output=""
    }

    Process {
        $output+="[$Text]($Link"
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
