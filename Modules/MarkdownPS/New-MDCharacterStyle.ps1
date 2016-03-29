<#
    .SYNOPSIS
        This commandlet output bold, italic or strikethrough in markdown syntax

    .DESCRIPTION
        This commandlet output bold, italic or strikethrough in markdown syntax by wrapping the text in **, * or ~~ respectively.

    .PARAMETER  Text
        Any text

    .PARAMETER  Style
        One of the Bold, Italic or StrikeThrough

    .EXAMPLE
        New-MDCharacterStyle -Text "Bold" -Style "Bold"
        "Bold" | New-MDCharacterStyle -Style "Bold"

        **Bold**

    .EXAMPLE
        New-MDCharacterStyle -Text "Italic" -Style "Italic"
        "Italic" | New-MDCharacterStyle -Style "Italic"

        *Italic*

    .EXAMPLE
        New-MDCharacterStyle -Text "StrikeThrough" -Style "StrikeThrough"
        "StrikeThrough" | New-MDCharacterStyle -Style "StrikeThrough"

        ~~StrikeThrough~~

    .INPUTS
        Any text

    .OUTPUTS
        The input wrapped in **, * or ~~ respectively for bold, italic or strikethrough

    .LINK
        New-MDInlineCode
#>
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
