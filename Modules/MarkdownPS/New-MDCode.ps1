<#
    .SYNOPSIS
        This commandlet output code block in markdown syntax

    .DESCRIPTION
        This commandlet output code blocke in markdown syntax by wrapping around ```

    .PARAMETER  Lines
        An array of lines to code block in markdown

    .PARAMETER  Style
        The style of code. e.g. powershell or xml or javascript

    .EXAMPLE
        New-MDCode -Lines "Line 1"
        "Line 1" | New-MDCode

        ```
            Line 1
        ```

    .EXAMPLE
        New-MDCode -Lines @("Line 1","Line 2")
        @("Line 1","Line 2") | New-MDCode

        ```
            Line 1
            Line 2
        ```

    .EXAMPLE
        New-MDCode -Lines @("Line 1","Line 2") -Style "powershell"
        @("Line 1","Line 2") | New-MDCode -Style "powershell"

        ```powershell
            Line 1
            Line 2
        ```


    .INPUTS
        An array of lines

    .OUTPUTS
        Input wrapped in ```


    .LINK
        New-MDQuote
        https://help.github.com/articles/basic-writing-and-formatting-syntax/
#>
function New-MDCode {
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
        [string]$Style=$null
    )

    Begin {
        $output="``````$Style"+[System.Environment]::NewLine
        $prefix="    "
        for($i=1; $i -le $Level; $i++)
        {
            $prefix+=">"
        }
    }

    Process {
        $Lines|ForEach-Object {
            $output+="$prefix"+$_+[System.Environment]::NewLine
        }
    }

    End {
        $output+"``````"+[System.Environment]::NewLine
    }
}
