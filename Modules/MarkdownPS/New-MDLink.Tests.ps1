$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "New-MDLink" {
    It "-Title not specified" {
        $link="http://example.com"
        $expected="[Link]($link)"
        New-MDLink -Text "Link" -Link $link | Should Be $expected
        "Link" | New-MDLink -Link $link | Should Be $expected
        #@("Link","Link") | New-MDLink -Link $link | Should Be @($expected,$expected)
    }
    It "-Title specified" {
        $link="http://example.com"
        $expected="[Link]($link ""Title"")"
        New-MDLink -Text "Link" -Link $link -Title "Title"| Should Be $expected
        "Link" | New-MDLink -Link $link  -Title "Title"| Should Be $expected
        #@("Link","Link") | New-MDLink -Link $link  -Title "Title"| Should Be @($expected,$expected)
    }
    It "-Text null or empty" {
        {New-MDLink -Text $null } | Should Throw "The argument is null or empty."
        {New-MDLink -Text "" } | Should Throw "The argument is null or empty."
    }
    It "-Link null or empty" {
        {New-MDLink -Text "Link" -Link $null } | Should Throw "The argument is null or empty."
        {New-MDLink -Text "Link" -Link "" } | Should Throw "The argument is null or empty."
    }

}
