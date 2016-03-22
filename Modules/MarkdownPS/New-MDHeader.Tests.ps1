$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "New-MDHeader" {
    It "-Level not provided" {
        New-MDHeader -Text "This is an H1" | Should Be "# This is an H1"
        "This is an H1"|New-MDHeader | Should Be "# This is an H1"
        @("This is an H1","This is an H1")|New-MDHeader | Should Be @("# This is an H1","# This is an H1")
    }
    It "-Level provided" {
        New-MDHeader -Text "This is an H1" -Level 1 | Should Be "# This is an H1"
        New-MDHeader -Text "This is an H2" -Level 2 | Should Be "## This is an H2"
        New-MDHeader -Text "This is an H3" -Level 3 | Should Be "### This is an H3"
        New-MDHeader -Text "This is an H4" -Level 4 | Should Be "#### This is an H4"
        New-MDHeader -Text "This is an H5" -Level 5 | Should Be "##### This is an H5"
        New-MDHeader -Text "This is an H6" -Level 6 | Should Be "###### This is an H6"
        "This is an H2"|New-MDHeader -Level 2| Should Be "## This is an H2"
        @("This is an H1","This is an H2")|New-MDHeader -Level 3| Should Be @("### This is an H1","### This is an H2")
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
