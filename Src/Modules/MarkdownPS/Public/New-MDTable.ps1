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

    .PARAMETER Shrink
        Shrinks each row to just actually fill the data

    .EXAMPLE
        Get-Command New-MDTable |Select-Object Name,CommandType | New-MDTable

        | Name        | CommandType |
        | ----------- | ----------- |
        | New-MDTable | Function    |

    .EXAMPLE
        Get-Command New-MDTable |Select-Object Name,CommandType | New-MDTable -Shrink

        | Name | CommandType |
        | ---- | ----------- |
        | New-MDTable | Function |

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
        [switch]$NoNewLine=$false,
        [switch]$Shrink=$false

    )

    Begin {
        $items = @()
        $maxLengthByColumn = @{}
        $output = ""
    }

    Process {
        ForEach($item in $Object) 
        {
            $items += $item
        }
        if(-not $Columns)
        {
            $Columns=[ordered]@{}
            ForEach($item in $Object) 
            {
                $item.PSObject.Properties | ForEach-Object {
                    if(-not $Columns.Contains($_.Name))
                    {
                        $Columns[$_.Name] = $null
                    }
                }
            }
        }
        
        if(-not $Shrink)
        {
            ForEach($key in $Columns.Keys) 
            {
                if(-not $maxLengthByColumn.ContainsKey($key))
                {
                    $maxLengthByColumn[$key] = $key.Length
                }
            }
            ForEach($item in $Object) {
                $item.PSObject.Properties | ForEach-Object {
                    $name = $_.Name
                    $value = $_.Value
                    if($Columns.Contains($name) -and $null -ne $value)
                    {
                        $valueLength = $value.ToString().Length
                        $maxLengthByColumn[$name] = [Math]::Max($maxLengthByColumn[$name], $valueLength)
                    }
                }
            }
        }
    }

    End {
        $lines=@()
        $header = @()
        ForEach($key in $Columns.Keys) 
        {
            if(-not $Shrink)
            {
                $header += ('{0,-' + $maxLengthByColumn[$key] + '}') -f $key
            }
            else {
                $header += $key
            }
        }
        $lines += '| '+($header -join ' | ')+' |'

        $separator = @()
        ForEach($key in $Columns.Keys) 
        {
            if(-not $Shrink)
            {
                $dashes = '-' * $maxLengthByColumn[$key]
            }
            else {
                $dashes = '-' * $key.Length
            }
            switch($Columns[$key]) 
            {
                "left" {
                    $separator += ':'+ $dashes +' '
                }
                "right" {
                    $separator += ' '+ $dashes +':'
                }  
                "center" {
                    $separator += ':'+ $dashes +':'
                }
                default {
                    $separator += ' '+ $dashes +' '
                }  
            }
        }
        $lines += '|'+($separator -join '|')+'|'

        ForEach($item in $items) {
            $values = @()
            ForEach($key in $Columns.Keys) 
            {
                if(-not $Shrink)
                {
                    $values += ('{0,-' + $maxLengthByColumn[$key] + '}') -f $item.($key)
                }
                else {
                    $values += $item.($key)
                }
            }
            $lines += '| '+ ($values -join ' | ') + ' |'
        }
        $output+=$lines -join  [System.Environment]::NewLine

        if(-not $NoNewLine)
        {
            $output += [System.Environment]::NewLine
        }
        $output
    }
}
