$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
$VerbosePreference="SilentlyContinue"
$newLine=[System.Environment]::NewLine
Describe "New-MDTable" {
    It "-Object is null" {
        {New-MDTable -Object $null} | Should Throw "because it is null."
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
        CommandType="left-aligned"
        Version="center-aligned"
        Source="right-aligned"
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