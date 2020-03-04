<#
    .SYNOPSIS
        This commandlet output link in markdown syntax

    .DESCRIPTION
        This commandlet output link in markdown syntax like this [text](link "title")

    .PARAMETER  Text
        Text of the link

    .PARAMETER  Link
        The link

    .PARAMETER  Title
        The title of the link

    .EXAMPLE
        New-MDLink -Text "Example" -Link "http://example.com"
        "example.png" | New-MDLink -Link "http://example.com"

        [Example](http://example.com)

    .EXAMPLE
        New-MDLink -Text "Example" -Link "http://example.com" -Title "This is an example link"
        "example.png" | New-MDLink -Link "http://example.com" -Title "This is an example link"

        [Example](http://example.com "This is an example link")

    .INPUTS
        Any text

    .OUTPUTS
        The link construct in markdown

    .LINK
        New-MDImage
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
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
