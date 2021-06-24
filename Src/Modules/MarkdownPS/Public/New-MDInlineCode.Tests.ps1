BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe -Tag @("MarkdownPS","Cmdlet","Public","New-MDInlineCode") "New-MDInlineCode" {
    It "-Text provided" {
        $expected="``Inline``"
        New-MDInlineCode -Text "Inline" | Should -Be $expected
        "Inline"|New-MDInlineCode | Should -Be $expected
        @("Inline","Inline")|New-MDInlineCode | Should -Be @($expected,$expected)
    }
    It "-Text null or empty" {
        {New-MDInlineCode -Text $null } | Should -Throw "*The argument is null or empty.*"
        {New-MDInlineCode -Text ""} | Should -Throw "*The argument is null or empty.*"
    }
}
