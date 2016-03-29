<#
    .SYNOPSIS
        This commandlet output image in markdown syntax

    .DESCRIPTION
        This commandlet output image in markdown syntax like this ![alt text](link "title")

    .PARAMETER  Link
        Text that represents a link

    .PARAMETER  Title
        The title of the image

    .PARAMETER  AltText
        The alternative text of the image

    .EXAMPLE
        New-MDImage -Link "example.png"
        "example.png" | New-MDImage

        ![](example.png)

    .EXAMPLE
        New-MDImage -Link "example.png" -Title "Example"
        "example.png" | New-MDImage -Title "Example"

        ![](example.png "Example")

    .EXAMPLE
        New-MDImage -Link "example.png" -Title "Example" -AltText "Failed to load"
        "example.png" | New-MDImage -Title "Example" -AltText "Failed to load"

        ![Failed to load](example.png "Example")

    .INPUTS
        Any text representing link

    .OUTPUTS
        The image construct in markdown

    .LINK
        New-MDLink
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
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
