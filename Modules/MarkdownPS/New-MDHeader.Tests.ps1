$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

$newLine=[System.Environment]::NewLine
Describe "New-MDHeader" {
    It "-Level not provided" {
        $expected="# This is an H1" + $newLine
        (New-MDHeader -Text "This is an H1") | Should Be $expected
        "This is an H1"|New-MDHeader | Should Be $expected
        @("This is an H1","This is an H1")|New-MDHeader | Should Be ($expected+$expected)
    }
    It "-Level provided" {
        New-MDHeader -Text "This is an H1" -Level 1 | Should Be ("# This is an H1"+$newLine)
        New-MDHeader -Text "This is an H2" -Level 2 | Should Be ("## This is an H2"+$newLine)
        New-MDHeader -Text "This is an H3" -Level 3 | Should Be ("### This is an H3"+$newLine)
        New-MDHeader -Text "This is an H4" -Level 4 | Should Be ("#### This is an H4"+$newLine)
        New-MDHeader -Text "This is an H5" -Level 5 | Should Be ("##### This is an H5"+$newLine)
        New-MDHeader -Text "This is an H6" -Level 6 | Should Be ("###### This is an H6"+$newLine)
        "This is an H2"|New-MDHeader -Level 2| Should Be ("## This is an H2"+$newLine)
        @("This is an H1","This is an H2")|New-MDHeader -Level 3| Should Be ("### This is an H1"+$newLine+"### This is an H2"+$newLine)
    }
    It "-NoNewLine defined" {
        $expected="# This is an H1"
        New-MDHeader -Text "This is an H1" -NoNewLine | Should Be $expected
        "This is an H1"|New-MDHeader -NoNewLine | Should Be $expected
        @("This is an H1","This is an H1")|New-MDHeader -NoNewLine | Should Be ($expected+$newLine+$expected)
    }
    It "-Text null or empty" {
        {New-MDHeader -Text $null } | Should Throw "The argument is null or empty."
        {New-MDHeader -Text ""} | Should Throw "The argument is null or empty."
    }
    It "-Level out of range" {
        {New-MDHeader -Text "H" -Level 0} | Should Throw "The 0 argument is less than the minimum allowed range of 1"
        {New-MDHeader -Text "H" -Level 7} | Should Throw "The 7 argument is greater than the maximum allowed range of 6"
    }
}
