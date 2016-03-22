$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$newLine=[System.Environment]::NewLine
Describe "New-MDParagraph" {
    It "-Lines is null" {
        New-MDParagraph | Should Be $newLine
    }
    It "-Lines count is 1" {
        $expected="Line 1"+$newLine
        New-MDParagraph -Lines "Line 1" | Should Be $expected
        "Line 1"|New-MDParagraph | Should Be $expected
    }
    It "-Lines count is 2" {
        $expected=("Line 1"+$newLine+"Line 2"+$newLine)
        New-MDParagraph -Lines @("Line 1","Line 2") | Should Be $expected
        @("Line 1","Line 2") | New-MDParagraph | Should Be $expected
    }
}
