$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$newLine=[System.Environment]::NewLine
Describe "New-MDCode" {
    It "-Lines is null" {
        {New-MDCode -Lines $null} | Should Throw "because it is null."
    }
    It "-Lines is empty" {
        {New-MDCode -Lines @()} | Should Throw "because it is an empty array."
    }
}
Describe "New-MDCode" {
    $prefix="``````"
    It "-Lines count is 1 & -Style is not specified" {
        $expected=$prefix+$newLine+"    Line 1"+$newLine+$prefix+$newLine
        New-MDCode -Lines "Line 1" | Should Be $expected
        New-MDCode -Lines @("Line 1")  | Should Be $expected
        "Line 1" | New-MDCode | Should Be $expected
        @("Line 1") | New-MDCode | Should Be $expected
    }
    It "-Lines count is 2 & -Style not specified" {
        $expected=$prefix+$newLine+"    Line 1"+$newLine+"    Line 2"+$newLine+$prefix+$newLine
        New-MDCode -Lines @("Line 1","Line 2") | Should Be $expected
        @("Line 1","Line 2") | New-MDCode | Should Be $expected
    }
    It "-Lines count is 1 & -Style specified" {
        $style="xml"
        $expected="$prefix"+$style+$newLine+"    Line 1"+$newLine+$prefix+$newLine
        New-MDCode -Lines "Line 1" -Style $style | Should Be $expected
        New-MDCode -Lines @("Line 1") -Style $style | Should Be $expected
        "Line 1" | New-MDCode -Style $style | Should Be $expected
        @("Line 1") | New-MDCode -Style $style | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided" {
        $style="javascript"
        $expected=$prefix+$style+$newLine+"    Line 1"+$newLine+"    Line 2"+$newLine+$prefix+$newLine
        New-MDCode -Lines @("Line 1","Line 2") -Style $style | Should Be $expected
        @("Line 1","Line 2") | New-MDCode -Style $style | Should Be $expected
    }
}