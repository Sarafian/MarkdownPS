$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "New-MDImage" {
    It "-Title not specified & -AltTitle not specified" {
        $link="http://example.com"
        $expected="![]($link)"
        New-MDImage -Link $link | Should Be $expected
        $link | New-MDImage | Should Be $expected
    }
    It "-Title specified & -AltTitle not specified" {
        $link="http://example.com"
        $title="Image"
        $expected="![]($link ""$title"")"
        New-MDImage -Link $link -Title $title | Should Be $expected
        $link | New-MDImage -Title $title | Should Be $expected
    }
    It "-Title specified & -AltText specified" {
        $link="http://example.com"
        $title="Image"
        $altText="Alt"
        $expected="![$altText]($link ""$title"")"
        New-MDImage -Link $link -Title $title -AltText $altText | Should Be $expected
        $link | New-MDImage -Title $title -AltText $altText | Should Be $expected
    }
    It "-Link null or empty" {
        {New-MDImage -Link $null } | Should Throw "The argument is null or empty."
        {New-MDImage -Link "" } | Should Throw "The argument is null or empty."
    }

}
