$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
$VerbosePreference="SilentlyContinue"
$newLine=[System.Environment]::NewLine

function Get-RandomValue
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

Describe "New-MDTable" {
    It "-Object is null" {
        Invoke-Command -ScriptBlock {TRY{New-MDTable -Object $null} CATCH{Return $_.FullyQualifiedErrorId}} | Should Be "ParameterArgumentValidationErrorNullNotAllowed,New-MDTable"
    }
}
Describe "New-MDTable without columns" {
    $object=Get-Command New-MDTable |Select-Object Name,CommandType
    It "-NoNewLine not specified" {
        $expected=4
        ((New-MDTable -Object $object) -split [System.Environment]::NewLine ).Length| Should Be $expected
        (($object | New-MDTable) -split [System.Environment]::NewLine ).Length| Should Be $expected
        ((@($object,$object) | New-MDTable)  -split [System.Environment]::NewLine ).Length | Should Be ($expected+1)
    }
    It "-NoNewLine specified" {
        $expected=3
        ((New-MDTable -Object $object -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
        (($object | New-MDTable -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
        ((@($object,$object) | New-MDTable -NoNewLine)  -split [System.Environment]::NewLine ).Length | Should Be ($expected+1)
    }
}
Describe "New-MDTable with columns" {
    $object=Get-Command New-MDTable 
    $columns=@{
        Name=$null
        CommandType="left"
        Version="center"
        Source="right"
    }
    It "-NoNewLine not specified" {
        $expected=4
        ((New-MDTable -Object $object -Columns $columns) -split [System.Environment]::NewLine ).Length| Should Be $expected
        (($object | New-MDTable -Columns $columns) -split [System.Environment]::NewLine ).Length| Should Be $expected
        ((@($object,$object) | New-MDTable -Columns $columns)  -split [System.Environment]::NewLine ).Length | Should Be ($expected+1)
    }
    It "-NoNewLine specified" {
        $expected=3
        ((New-MDTable -Object $object -Columns $columns -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
        (($object | New-MDTable -Columns $columns -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
        ((@($object,$object) | New-MDTable -Columns $columns -NoNewLine)  -split [System.Environment]::NewLine ).Length | Should Be ($expected+1)
    }
}

Describe "New-MDTable with ordered hashtable and without columns" {
    BeforeEach {
        $properties=@(
            Get-RandomValue -String
            Get-RandomValue -String
            Get-RandomValue -String
            Get-RandomValue -String
            Get-RandomValue -String
        )
        $object=[PSCustomObject]@{
            $properties[0] = "This is property $($properties[0])"
            $properties[1] = "This is property $($properties[1])"
            $properties[2] = "This is property $($properties[2])"
            $properties[3] = "This is property $($properties[3])"
            $properties[4] = "This is property $($properties[4])"
        }
    }
    It "-NoNewLine not specified" {
        $expected=4
        ((New-MDTable -Object $object) -split [System.Environment]::NewLine).Length | Should Be $expected
        (($object | New-MDTable) -split [System.Environment]::NewLine).Length | Should Be $expected
        ((@($object, $object) | New-MDTable) -split [System.Environment]::NewLine).Length | Should Be ($expected+1)
    }
    It "-NoNewLine not specified" {
        $expected=3
        ((New-MDTable -Object $object -NoNewLine) -split [System.Environment]::NewLine).Length | Should Be $expected
        (($object | New-MDTable -NoNewLine) -split [System.Environment]::NewLine).Length | Should Be $expected
        ((@($object, $object) | New-MDTable -NoNewLine) -split [System.Environment]::NewLine).Length | Should Be ($expected+1)
    }
    It "Test column header sequence" {
    
        $rows=(New-MDTable -Object $object) -split [System.Environment]::NewLine 
        $elements=$rows[0] -split '\|'
        $elements.Count | Should Be 7
        $elements[0].Length | Should Be 0
        $elements[1] | Should  Match $properties[0]
        $elements[2] | Should  Match $properties[1]
        $elements[3] | Should  Match $properties[2]
        $elements[4] | Should  Match $properties[3]
        $elements[5] | Should  Match $properties[4]
        $elements[6].Length | Should Be 0
    }
    It "Test column header with overwritten sequence" {
        $columns=[ordered]@{
            $properties[3]=$null
            $properties[2]="left"
            $properties[1]="center"
            $properties[0]="right"
        }
    

        $rows=(New-MDTable -Object $object -Columns $columns) -split [System.Environment]::NewLine 
        $elements=$rows[0] -split '\|'
        $elements.Count | Should Be 6
        $elements[0].Length | Should Be 0
        $elements[1] | Should  Match $properties[3]
        $elements[2] | Should  Match $properties[2]
        $elements[3] | Should  Match $properties[1]
        $elements[4] | Should  Match $properties[0]
        $elements[6].Length | Should Be 0
    }
}

Describe "New-MDTable with ordered columns" {
    $object=Get-Command New-MDTable 
    $columns=[ordered]@{
        Name=$null
        CommandType="left"
        Version="center"
        Source="right"
    }
    It "Test column header sequence" {
        $rows=(New-MDTable -Object $object -Columns $columns) -split [System.Environment]::NewLine 
        $elements=$rows[0] -split '\|'
        $elements.Count | Should Be 6
        $elements[0].Length | Should Be 0
        $elements[1] | Should  Match "Name"
        $elements[2] | Should  Match "CommandType"
        $elements[3] | Should  Match "Version"
        $elements[4] | Should  Match "Source"
        $elements[5].Length | Should Be 0
    }
    It "Test column alignment " {
        $rows=(New-MDTable -Object $object -Columns $columns) -split [System.Environment]::NewLine 
        $elements=$rows[1] -split '\|'
        
        $elements.Count | Should Be 6
        $elements[0].Length | Should Be 0
        $elements[1] | Should  Match " -* "
        $elements[2] | Should  Match " -* "
        $elements[3] | Should  Match ":-*:"
        $elements[4] | Should  Match " -*:"
        $elements[5].Length | Should Be 0
    }
}