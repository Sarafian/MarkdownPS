$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$newLine=[System.Environment]::NewLine
Describe "New-MDQuote" {
    It "-Lines is null" {
        {New-MDQuote -Lines $null} | Should Throw "because it is null."
    }
    It "-Lines is empty" {
        {New-MDQuote -Lines @()} | Should Throw "because it is an empty array."
    }
    It "-Level out of range" {
        {New-MDQuote -Lines "Line 1" -Level 0 } | Should Throw "The 0 argument is less than the minimum allowed range of 1"
    }
    It "-Style out of range" {
        {New-MDQuote -Lines "Line 1" -Level 4 -Style Unordered} | Should Throw "The 4 argument is greater than the maximum allowed range of 3"
    }
}
Describe "New-MDQuote" {
    It "-Lines count is 1 & -Level not specified" {
        $expected="> Line 1"+$newLine+$newLine
        New-MDQuote -Lines "Line 1" | Should Be $expected
        New-MDQuote -Lines @("Line 1")  | Should Be $expected
        "Line 1" | New-MDQuote | Should Be $expected
        @("Line 1") | New-MDQuote | Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified" {
        $expected="> Line 1"+$newLine+">"+$newLine+"> Line 2"+$newLine+$newLine
        New-MDQuote -Lines @("Line 1","Line 2") | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided" {
        $expected="> Line 1"+$newLine+$newLine
        $level=1
        New-MDQuote -Lines "Line 1" -Level $level | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level | Should Be $expected

        $expected=">> Line 1"+$newLine+$newLine
        $level=2
        New-MDQuote -Lines "Line 1" -Level $level | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level | Should Be $expected

        $expected=">>> Line 1"+$newLine+$newLine
        $level=3
        New-MDQuote -Lines "Line 1" -Level $level | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided" {
        $expected="> Line 1"+$newLine+">"+$newLine+"> Line 2"+$newLine+$newLine
        $level=1
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level | Should Be $expected

        $expected=">> Line 1"+$newLine+">>"+$newLine+">> Line 2"+$newLine+$newLine
        $level=2
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level | Should Be $expected

        $expected=">>> Line 1"+$newLine+">>>"+$newLine+">>> Line 2"+$newLine+$newLine
        $level=3
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level | Should Be $expected
    }
}

Describe "New-MDQuote -NoNewLine specified" {
    It "-Lines count is 1 & -Level not specified" {
        $expected="> Line 1"+$newLine
        New-MDQuote -Lines "Line 1" -NoNewLine | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -NoNewLine | Should Be $expected
        "Line 1" | New-MDQuote -NoNewLine | Should Be $expected
        @("Line 1") | New-MDQuote -NoNewLine | Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified" {
        $expected="> Line 1"+$newLine+">"+$newLine+"> Line 2"+$newLine
        New-MDQuote -Lines @("Line 1","Line 2") -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote -NoNewLine | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided" {
        $expected="> Line 1"+$newLine
        $level=1
        New-MDQuote -Lines "Line 1" -Level $level -NoNewLine | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level -NoNewLine | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level -NoNewLine | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected

        $expected=">> Line 1"+$newLine
        $level=2
        New-MDQuote -Lines "Line 1" -Level $level -NoNewLine | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level -NoNewLine | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level -NoNewLine | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected

        $expected=">>> Line 1"+$newLine
        $level=3
        New-MDQuote -Lines "Line 1" -Level $level -NoNewLine | Should Be $expected
        New-MDQuote -Lines @("Line 1")  -Level $level -NoNewLine | Should Be $expected
        "Line 1" | New-MDQuote  -Level $level -NoNewLine | Should Be $expected
        @("Line 1") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided" {
        $expected="> Line 1"+$newLine+">"+$newLine+"> Line 2"+$newLine
        $level=1
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected

        $expected=">> Line 1"+$newLine+">>"+$newLine+">> Line 2"+$newLine
        $level=2
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected

        $expected=">>> Line 1"+$newLine+">>>"+$newLine+">>> Line 2"+$newLine
        $level=3
        New-MDQuote -Lines @("Line 1","Line 2") -Level $level -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDQuote  -Level $level -NoNewLine | Should Be $expected
    }
}