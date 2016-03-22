$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "New-MDInlineCode" {
    It "-Text provided" {
        $expected="``Inline``"
        New-MDInlineCode -Text "Inline" | Should Be $expected
        "Inline"|New-MDInlineCode | Should Be $expected
        @("Inline","Inline")|New-MDInlineCode | Should Be @($expected,$expected)
    }
    It "-Text null or empty" {
        {New-MDInlineCode -Text $null } | Should Throw "The argument is null or empty."
        {New-MDInlineCode -Text ""} | Should Throw "The argument is null or empty."
    }
}
