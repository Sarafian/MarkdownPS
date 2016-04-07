<#
    .SYNOPSIS
        This commandlet output a table in markdown syntax

    .DESCRIPTION
        This commandlet output quote in markdown syntax by adding a two rows for the header and then one line per entry in the array.

    .PARAMETER  Object
        Any object

    .PARAMETER NoNewLine
        Controls if a new line is added at the end of the output

    .PARAMETER Columns
        The columns that compose the table. Columns must be an ordered hashtable [ordered]@{} where the keys are the column names and as optional value (left,center,right).

    .EXAMPLE
        Get-Command New-MDTable |Select-Object Name,CommandType | New-MDTable

        Name        | CommandType
        ----------- | -----------
        New-MDTable | Function   

    .EXAMPLE
        Get-Command New-MDTable | New-MDTable -Columns ([ordered]@{Name=$null;CommandType=$null})

        | Name        | CommandType |
        | ----------- | ----------- |
        | New-MDTable | Function    |

    .EXAMPLE
        Get-Command New-MDTable | New-MDTable -Columns ([ordered]@{CommandType=$null;Name=$null})

        | CommandType | Name        |
        | ----------- | ----------- |
        | Function    | New-MDTable |

    .EXAMPLE
        Get-Command New-MDTable | New-MDTable -Columns (@{CommandType=$null;Name=$null})

        | Name        | CommandType |
        | ----------- | ----------- |
        | New-MDTable | Function    |

    .EXAMPLE
        Get-Command New-MDTable | New-MDTable -Columns ([ordered]@{Name="left";CommandType="center";Version="right"})
        | Name        | CommandType | Version     |
        | ----------- |:-----------:| -----------:|
        | New-MDTable | Function    |             |

    .INPUTS
        Any table

    .OUTPUTS
        A table representation in markdown

    .NOTES
        Use the -NoNewLine parameter when you don't want the next markdown content to be separated.
#>
function New-MDTable {
[CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [PSObject[]]$Object,
        [Parameter(
            Mandatory = $false
        )]
        $Columns=$null,
        [Parameter(
            ValueFromPipeline = $false
        )]
        [ValidateNotNullOrEmpty()]
        [switch]$NoNewLine=$false
    )

    Begin {
        $items = @()
        $maxColumnLength=0
        $output=""
    }

    Process {
        ForEach($item in $Object) 
        {
            $items += $item
        }
        if(-not $Columns)
        {
            $Columns=@{}
            ForEach($item in $Object) 
            {
                $item.PSObject.Properties | %{
                    if(-not $Columns.Contains($_.Name)){
                        $Columns[$_.Name]=$null
                    }
                }
            }
        }
        ForEach($item in $Object) {
            $item.PSObject.Properties | %{
                if($Columns.Contains($_.Name) -and $_.Value -ne $null){
                    $maxColumnLength=[Math]::Max($maxColumnLength, $_.Value.Length)
                }
            }
        }
    }

    End {
        $lines=@()
        $header = @()
        ForEach($key in $Columns.Keys) {
            $header += ('{0,-' + $maxColumnLength + '}') -f $key
        }
        $lines+='| '+($header -join ' | ')+' |'

        $separator = @()
        ForEach($key in $Columns.Keys) {
            switch($Columns[$key]) {
                "left" {
                    $separator += ' '+'-' * $maxColumnLength+' '
                }
                "right" {
                    $separator += ' '+'-' * $maxColumnLength+':'
                }  
                "center" {
                    $separator += ':'+'-' * $maxColumnLength+':'
                }
                default {
                    $separator += ' '+'-' * $maxColumnLength+' '
                }  
            }
        }
        $lines+='|'+($separator -join '|')+'|'

        ForEach($item in $items) {
            $values = @()
            ForEach($key in $Columns.Keys) {
                $values += ('{0,-' + $maxColumnLength + '}') -f $item.($key)
            }
            $lines+='| '+ ($values -join ' | ') + ' |'
        }
        $output+=$lines -join  [System.Environment]::NewLine



        if(-not $NoNewLine)
        {
            $output+=[System.Environment]::NewLine
        }
        $output
    }
}
