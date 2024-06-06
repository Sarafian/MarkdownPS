BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    $MDQuoteFile = Join-Path -Path (Split-Path $PSCommandPath -Parent) -ChildPath 'New-MDQuote.ps1'
    . $MDQuoteFile
    $newLine = [System.Environment]::NewLine
}
Describe -Tag @('MarkdownPS', 'Cmdlet', 'Public') 'New-MDAlert' {
    It '-Lines is null' {
        { New-MDAlert -Lines $null } | Should -Throw '*because it is null.*'
    }
    It '-Lines is empty' {
        { New-MDAlert -Lines @() } | Should -Throw '*because it is an empty array.*'
    }
    It '-Style out of range' {
        { New-MDAlert -Lines 'Line 1' -Style Unknown } | Should -Throw -ErrorId 'ParameterArgumentValidationError,New-MDAlert'
    }
}
Describe -Tag @('MarkdownPS', 'Cmdlet', 'Public', 'New-MDAlert') 'New-MDAlert' {
    It '-Lines count is 1 & -Style not specified' {
        $expected = '> [!NOTE]' + $newLine + '> Line 1' + $newLine + $newLine
        New-MDAlert -Lines 'Line 1' | Should -Be $expected
        New-MDAlert -Lines @('Line 1') | Should -Be $expected
        'Line 1' | New-MDAlert | Should -Be $expected
        @('Line 1') | New-MDAlert | Should -Be $expected
    }
    It '-Lines count is 2 & -Style not specified' {
        $expected = '> [!NOTE]' + $newLine + '> Line 1' + $newLine + '> Line 2' + $newLine + $newLine
        # New-MDAlert -Lines @('Line 1', 'Line 2') | Should -Be $expected
        @('Line 1', 'Line 2') | New-MDAlert | Should -Be $expected
    }
    It '-Lines count is 1 & -Style provided' {
        $expected = '> [!TIP]' + $newLine + '> Line 1' + $newLine + $newLine
        New-MDAlert -Lines 'Line 1' -Style Tip | Should -Be $expected
        New-MDAlert -Lines @('Line 1') -Style Tip | Should -Be $expected
        'Line 1' | New-MDAlert -Style Tip | Should -Be $expected
        @('Line 1') | New-MDAlert -Style Tip | Should -Be $expected
    }
    It '-Lines count is 2 & -Level provided' {
        $expected = '> [!TIP]' + $newLine + '> Line 1' + $newLine + '> Line 2' + $newLine + $newLine
        New-MDAlert -Lines @('Line 1', 'Line 2') -Style Tip | Should -Be $expected
        @('Line 1', 'Line 2') | New-MDAlert -Style Tip | Should -Be $expected
    }
}