<#
    .SYNOPSIS
        This commandlet output image in markdown syntax

    .DESCRIPTION
        This commandlet output image in markdown syntax like this ![alt text](link "title")

    .PARAMETER  Source
        Text that represents the image source

    .PARAMETER  Title
        The title of the image

    .PARAMETER  AltText
        The alternative text of the image

    .PARAMETER  Link
        Add a link to the image

    .PARAMETER  Subject
        The <SUBJECT> in https://img.shields.io/badge/<SUBJECT>-<STATUS>-<COLOR>.svg

    .PARAMETER  Style
        The <STYLE> in https://img.shields.io/badge/<SUBJECT>-<STATUS>-<COLOR>.svg

    .PARAMETER  Color
        The <Color> in https://img.shields.io/badge/<SUBJECT>-<STATUS>-<COLOR>.svg
        One of the brightgreen, green, yellowgreen, yellow, orange, red, lightgrey, blue

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

    .EXAMPLE
        New-MDImage -Subject "SUBJECT" -Status "STATUS" -Color "green"

        ![](https://img.shields.io/badge/SUBJECT-STATUS-green.svg)

    .INPUTS
        Any text representing link or parameters to drive shields.io badges

    .OUTPUTS
        The image construct in markdown

    .LINK
        New-MDLink
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
        https://img.shields.io/badge/<SUBJECT>-<STATUS>-<COLOR>.svg
        http://shields.io/
#>
function New-MDImage {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $false,
            Position = 0,
            ValueFromPipeline = $true,
            ParameterSetName="Source"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Source,
        [Parameter(
            Mandatory = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Title=$null,
        [Parameter(
            Mandatory = $false
        )]
        [string]$AltText=$null,
        [Parameter(
            Mandatory = $false,
            ParameterSetName="Shields.io"
        )]
        [string]$Subject=$null,
        [Parameter(
            Mandatory = $false,
            ParameterSetName="Shields.io"
        )]
        [string]$Status=$null,
        [Parameter(
            Mandatory = $false,
            ParameterSetName="Shields.io"
        )]
        [ValidateSet("brightgreen","green","yellowgreen","yellow","orange","red","lightgrey","blue")]
        [string]$Color=$null,
        [Parameter(
            Mandatory = $false,
            ParameterSetName="Shields.io"
        )]
        [ValidateSet("plastic","flat","flat-square","social")]
        [string]$Style=$null,
        [Parameter(
            Mandatory = $false
        )]
        [string]$Link=$null
    )

    Begin {
        $output=""
    }

    Process {
        if(-not $Source -and $Color)
        {
            $Subject=$Subject.Replace("-","--").Replace("_","__")
            $Subject=[System.Uri]::EscapeDataString($Subject)

            $Status=$Status.Replace("-","--").Replace("_","__")
            $Status=[System.Uri]::EscapeDataString($Status)
            
            #When running from powershell [System.Uri]::EscapeDataString is not escaping ()
            if(-not $ise)
            {
                $Subject=$Subject.Replace("(","%28").Replace(")","%29")
                $Status=$Status.Replace("(","%28").Replace(")","%29")
            }
            
            $shieldIo="$Subject-$Status-$Color"

            $Source="https://img.shields.io/badge/$shieldIo.svg"
            if($Style)
            {
                $Source+="?style=$Style"
            }

        }
        
        $output+="![$AltText]($Source"
        if($Title)
        {
            $output+=" ""$Title"""
        }

        $output+=")"
        if($Link)
        {
            $output=New-MDLink -Text $output -Link $Link
        }
    }

    End {
        $output
    }

}
