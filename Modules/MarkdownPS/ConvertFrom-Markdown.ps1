<#
.Synopsis
    Converts a Markdown table to a PowerShell object.
.Description
    The ConvertFrom-Markdown function converts a Markdown formatted table to a Powershell Object
.EXAMPLE
    Get-Service | Select-Object Name, DisplayName, Status | ConvertTo-Markdown | ConvertFrom-Markdown

    This command gets the name, displayname and status of all the services on the system then converts it to a Markdown table format before converting it back to a Powershell object.
.EXAMPLE
    Get-Process | Unique | Select-Object Name, Path, Company | ConvertTo-Markdown | ConvertFrom-Markdown

    This command gets the name, path and company of all the processes that are running on the computer with duplicates eliminated then converts it to a Markdown table format and then to Powershell object.
.EXAMPLE
    ConvertTo-Markdown (Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object Name, DisplayName, Status) | ConvertFrom-Markdown

    This command displays the name, displayname and status of only the services that are currently running in Markdown table format before converting it back to a Powershell object.
.EXAMPLE
    $mddata = ConvertTo-Markdown (Get-Alias | Select Name, DisplayName)
    ConvertFrom-Markdown $mddata

    The first command displays the name and displayname of all the aliases for the current session in Markdown table format.

    The second command converts the aliases in Markdown table format to a Powershell object.
.EXAMPLE
    $date = Get-Date | ConvertTo-Markdown
    ConvertFrom-Markdown $date

    These commands converts a date object to Markdown table format and then to Powershell object.
#>
Function ConvertFrom-Markdown {
    [CmdletBinding()]
    [OutputType([PSObject])]
    Param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        $InputObject
    )

    Begin {
        $items = @()
    }

    Process {
        $mddata = $InputObject
        $data = $mddata | Where-Object {$_ -notmatch "--" }
        $items += $data
    }

    End {
       $object = $items -replace ' +', '' | ConvertFrom-Csv -Delimiter '|'
       $object 
    }
}