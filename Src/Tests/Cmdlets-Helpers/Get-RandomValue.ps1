function global:Get-RandomValue
{
    param(
        [Parameter(Mandatory = $true, ParameterSetName = "String")]
        [switch]$String,
        [Parameter(Mandatory = $true, ParameterSetName = "Int")]
        [switch]$Int
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        'String'
        {
            "Random-" + ( -join ((65..90) + (97..122) | Get-Random -Count 5 | % { [char]$_ }))
        }
        'Int'
        {
            10000 + (Get-Random -Maximum 100)
        }
    }
}