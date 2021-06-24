BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $newLine=[System.Environment]::NewLine
}

Describe -Tag @("MarkdownPS","Cmdlet","Public","New-MDParagraph") "New-MDParagraph" {
    It "-Lines is null" {
        New-MDParagraph | Should -Be ($newLine+$newLine)
    }
    It "-Lines count is 1" {
        $expected="Line 1"+$newLine+$newLine
        New-MDParagraph -Lines "Line 1" | Should -Be $expected
        "Line 1"|New-MDParagraph | Should -Be $expected
    }
    It "-Lines count is 2" {
        $expected=("Line 1"+$newLine+"Line 2"+$newLine+$newLine)
        New-MDParagraph -Lines @("Line 1","Line 2") | Should -Be $expected
        @("Line 1","Line 2") | New-MDParagraph | Should -Be $expected
    }
}

Describe -Tag @("MarkdownPS","Cmdlet","Public") "New-MDParagraph -NoNewLine specified" {
    It "-Lines is null" {
        New-MDParagraph -NoNewLine | Should -Be $newLine
    }
    It "-Lines count is 1" {
        $expected="Line 1"+$newLine
        New-MDParagraph -Lines "Line 1" -NoNewLine | Should -Be $expected
        "Line 1"|New-MDParagraph -NoNewLine | Should -Be $expected
    }
    It "-Lines count is 2" {
        $expected=("Line 1"+$newLine+"Line 2"+$newLine)
        New-MDParagraph -Lines @("Line 1","Line 2") -NoNewLine | Should -Be $expected
        @("Line 1","Line 2") | New-MDParagraph -NoNewLine | Should -Be $expected
    }
}
