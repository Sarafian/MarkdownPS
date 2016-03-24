$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$newLine=[System.Environment]::NewLine
Describe "New-MDList" {
    It "-Lines is null" {
        {New-MDList -Lines $null} | Should Throw "because it is null."
    }
    It "-Lines is empty" {
        {New-MDList -Lines @()} | Should Throw "because it is an empty array."
    }
    It "-Level out of range" {
        {New-MDList -Lines "Line 1" -Level 0 -Style Ordered} | Should Throw "The 0 argument is less than the minimum allowed range of 1"
        {New-MDList -Lines "Line 1" -Level 4 -Style Unordered} | Should Throw "The 4 argument is greater than the maximum allowed range of 3"
    }
    It "-Style out of range" {
        {New-MDList -Lines "Line 1" -Style "Invalid"} | Should Throw "The argument ""Invalid"" does not belong to the set ""Unordered,Ordered"" specified by the ValidateSet attribute."
    }
    It "-Style out of range" {
        {New-MDList -Lines "Line 1" -Level 4 -Style Unordered} | Should Throw "The 4 argument is greater than the maximum allowed range of 3"
    }
}
Describe "New-MDList -Style Unordered" {
    $style="Unordered"
    It "-Lines count is 1 & -Level not specified" {
        $expected="- Line 1"+$newLine+$newLine
        New-MDList -Lines "Line 1" -Style $style | Should Be $expected
        New-MDList -Lines @("Line 1")  -Style $style | Should Be $expected
        "Line 1" | New-MDList  -Style $style| Should Be $expected
        @("Line 1") | New-MDList  -Style $style| Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified" {
        $expected="- Line 1"+$newLine+"- Line 2"+$newLine+$newLine
        New-MDList -Lines @("Line 1","Line 2") -Style $style | Should Be $expected
        @("Line 1","Line 2") | New-MDList -Style $style | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided" {
        $expected="- Line 1"+$newLine+$newLine
        $level=1
        New-MDList -Lines "Line 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="  - Line 1"+$newLine+$newLine
        $level=2
        New-MDList -Lines "Line 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="    - Line 1"+$newLine+$newLine
        $level=3
        New-MDList -Lines "Line 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided" {
        $expected="- Line 1"+$newLine+"- Line 2"+$newLine+$newLine
        $level=1
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="  - Line 1"+$newLine+"  - Line 2"+$newLine+$newLine
        $level=2
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="    - Line 1"+$newLine+"    - Line 2"+$newLine+$newLine
        $level=3
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style | Should Be $expected
    }
}
Describe "New-MDList -Style Unordered & -NoNewLine specified" {
    $style="Unordered"
    It "-Lines count is 1 & -Level not specified " {
        $expected="- Line 1"+$newLine
        New-MDList -Lines "Line 1" -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Line 1")  -Style $style -NoNewLine | Should Be $expected
        "Line 1" | New-MDList  -Style $style -NoNewLine| Should Be $expected
        @("Line 1") | New-MDList  -Style $style -NoNewLine| Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified " {
        $expected="- Line 1"+$newLine+"- Line 2"+$newLine
        New-MDList -Lines @("Line 1","Line 2") -Style $style -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDList -Style $style -NoNewLine | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided " {
        $expected="- Line 1"+$newLine
        $level=1
        New-MDList -Lines "Line 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="  - Line 1"+$newLine
        $level=2
        New-MDList -Lines "Line 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="    - Line 1"+$newLine
        $level=3
        New-MDList -Lines "Line 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Line 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Line 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided " {
        $expected="- Line 1"+$newLine+"- Line 2"+$newLine
        $level=1
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="  - Line 1"+$newLine+"  - Line 2"+$newLine
        $level=2
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="    - Line 1"+$newLine+"    - Line 2"+$newLine
        $level=3
        New-MDList -Lines @("Line 1","Line 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Line 1","Line 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
    }
}
Describe "New-MDList -Style Ordered" {
    $style="Ordered"
    It "-Lines count is 1 & -Level not specified" {
        $expected="1. Step 1"+$newLine+$newLine
        New-MDList -Lines "Step 1" -Style $style | Should Be $expected
        New-MDList -Lines @("Step 1")  -Style $style | Should Be $expected
        "Step 1" | New-MDList  -Style $style| Should Be $expected
        @("Step 1") | New-MDList  -Style $style| Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified" {
        $expected="1. Step 1"+$newLine+"2. Step 2"+$newLine+$newLine
        New-MDList -Lines @("Step 1","Step 2") -Style $style | Should Be $expected
        @("Step 1","Step 2") | New-MDList -Style $style | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided" {
        $expected="1. Step 1"+$newLine+$newLine
        $level=1
        New-MDList -Lines "Step 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="   1. Step 1"+$newLine+$newLine
        $level=2
        New-MDList -Lines "Step 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="      1. Step 1"+$newLine+$newLine
        $level=3
        New-MDList -Lines "Step 1" -Level $level -Style $style | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided" {
        $expected="1. Step 1"+$newLine+"2. Step 2"+$newLine+$newLine
        $level=1
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="   1. Step 1"+$newLine+"   2. Step 2"+$newLine+$newLine
        $level=2
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style | Should Be $expected

        $expected="      1. Step 1"+$newLine+"      2. Step 2"+$newLine+$newLine
        $level=3
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style | Should Be $expected
    }
}
Describe "New-MDList -Style Ordered & -NoNewLine specified" {
    $style="Ordered"
    It "-Lines count is 1 & -Level not specified" {
        $expected="1. Step 1"+$newLine
        New-MDList -Lines "Step 1" -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Step 1")  -Style $style -NoNewLine | Should Be $expected
        "Step 1" | New-MDList  -Style $style -NoNewLine | Should Be $expected
        @("Step 1") | New-MDList  -Style $style -NoNewLine | Should Be $expected
    }
    It "-Lines count is 2 & -Level not specified " {
        $expected="1. Step 1"+$newLine+"2. Step 2"+$newLine
        New-MDList -Lines @("Step 1","Step 2") -Style $style -NoNewLine | Should Be $expected
        @("Step 1","Step 2") | New-MDList -Style $style -NoNewLine | Should Be $expected
    }
    It "-Lines count is 1 & -Level provided " {
        $expected="1. Step 1"+$newLine
        $level=1
        New-MDList -Lines "Step 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="   1. Step 1"+$newLine
        $level=2
        New-MDList -Lines "Step 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="      1. Step 1"+$newLine
        $level=3
        New-MDList -Lines "Step 1" -Level $level -Style $style -NoNewLine | Should Be $expected
        New-MDList -Lines @("Step 1")  -Level $level -Style $style -NoNewLine | Should Be $expected
        "Step 1" | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
    }
    It "-Lines count is 2 & -Level provided " {
        $expected="1. Step 1"+$newLine+"2. Step 2"+$newLine
        $level=1
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="   1. Step 1"+$newLine+"   2. Step 2"+$newLine
        $level=2
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected

        $expected="      1. Step 1"+$newLine+"      2. Step 2"+$newLine
        $level=3
        New-MDList -Lines @("Step 1","Step 2") -Level $level -Style $style -NoNewLine | Should Be $expected
        @("Step 1","Step 2") | New-MDList  -Level $level -Style $style -NoNewLine | Should Be $expected
    }
}
