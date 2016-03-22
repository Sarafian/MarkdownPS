$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "New-MDCharacterStyle" {
    It "-Style Bold" {
        $text="Bold characters"
        New-MDCharacterStyle -Text $text -Style Bold | Should Be "**$text**"
        $text | New-MDCharacterStyle -Style Bold | Should Be "**$text**"
    }
    It "-Style Italic" {
        $text="Italic characters"
        New-MDCharacterStyle -Text $text -Style Italic | Should Be "*$text*"
        $text | New-MDCharacterStyle -Style Italic | Should Be "*$text*"
    }
    It "-Style StrikeThrough" {
        $text="Strikethrough characters"
        New-MDCharacterStyle -Text $text -Style StrikeThrough | Should Be "~~$text~~"
        $text | New-MDCharacterStyle -Style StrikeThrough | Should Be "~~$text~~"
    }
    It "-Style out of range" {
        {New-MDCharacterStyle -Text "H" -Style "Invalid"} | Should Throw "The argument ""Invalid"" does not belong to the set ""Bold,Italic,StrikeThrough"" specified by the ValidateSet attribute."
    }
    It "-Text null or empty" {
        {New-MDCharacterStyle -Text $null -Style Bold} | Should Throw "The argument is null or empty."
        {New-MDCharacterStyle -Text "" -Style Bold} | Should Throw "The argument is null or empty."
    }

}
