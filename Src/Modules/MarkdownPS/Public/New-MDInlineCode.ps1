<#
    .SYNOPSIS
        This commandlet output inline code in markdown syntax

    .DESCRIPTION
        This commandlet output inline code in markdown syntax by wrapping the text in `

    .PARAMETER  Text
        Any text

    .EXAMPLE
        New-MDInlineCode -Text "Inline Code"
        "Inline Code" | New-MDInlineCode

        `Inline Code`

    .INPUTS
        Any text

    .OUTPUTS
        The input wrapped in `

    .LINK
        New-MDQuote
        New-MDCharacterStyle
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>

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
