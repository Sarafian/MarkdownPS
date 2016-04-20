$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\New-MDLink.ps1"
. "$here\$sut"

Describe "New-MDImage" {
    Context "Parameter set Source" {
        It "-Title not specified & -AltTitle not specified" {
            $source="http://example.com"
            $expected="![]($source)"
            New-MDImage -Source $source | Should Be $expected
            $source | New-MDImage | Should Be $expected
        }
        It "-Title specified & -AltTitle not specified" {
            $source="http://example.com"
            $title="Image"
            $expected="![]($source ""$title"")"
            New-MDImage -Source $source -Title $title | Should Be $expected
            $source | New-MDImage -Title $title | Should Be $expected
        }
        It "-Title specified & -AltText specified" {
            $source="http://example.com"
            $title="Image"
            $altText="Alt"
            $expected="![$altText]($source ""$title"")"
            New-MDImage -Source $source -Title $title -AltText $altText | Should Be $expected
            $source | New-MDImage -Title $title -AltText $altText | Should Be $expected
        }
        It "-Link specified" {
            $source="http://example.com"
            $link=$source
            $expected="[![]($source)]($link)"
            New-MDImage -Source $source -Link $link | Should Be $expected
            $source | New-MDImage -Link $link | Should Be $expected
        }
        It "-Source null or empty" {
            {New-MDImage -Source $null } | Should Throw "The argument is null or empty."
            {New-MDImage -Source "" } | Should Throw "The argument is null or empty."
        }
    }
    Context "Parameter set Shields.io" {
        It "-Subject not specified & -Status not specified" {
            $color="green"
            $expected="![](https://img.shields.io/badge/--$color.svg)"
            New-MDImage -Color $color | Should Be $expected
        }
        It "-Subject specified & -Status not specified" {
            $subject="Subject"
            $color="green"
            $expected="![](https://img.shields.io/badge/$Subject--$color.svg)"
            New-MDImage -Subject $subject -Color $color | Should Be $expected
        }
        It "-Subject not specified & -Status specified" {
            $status="Status"
            $color="green"
            $expected="![](https://img.shields.io/badge/-$status-$color.svg)"
            New-MDImage -Status $status -Color $color | Should Be $expected
        }
        It "-Subject specified & -Status specified" {
            $subject="Subject"
            $status="Status"
            $color="green"
            $expected="![](https://img.shields.io/badge/$subject-$status-$color.svg)"
            New-MDImage -Subject $subject -Status $status -Color $color | Should Be $expected
        }
        It "With special chars" {
            $subject="dash-underscore_parenthesis()space ."
            $status="dash-underscore_parenthesis()space ."
            $color="green"
            $expected="![](https://img.shields.io/badge/dash--underscore__parenthesis%28%29space%20.-dash--underscore__parenthesis%28%29space%20.-$color.svg)"
            New-MDImage -Subject $subject -Status $status -Color $color | Should Be $expected
        }
        It "-Link specified" {
            $subject="Subject"
            $status="Status"
            $color="green"
            $link="http://example.com"
            $expected="[![](https://img.shields.io/badge/$subject-$status-$color.svg)]($link)"
            New-MDImage -Subject $subject -Status $status -Color $color -Link $link| Should Be $expected
        }

    }
}
