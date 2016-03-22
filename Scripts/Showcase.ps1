# Try to render some markdown as described here
# https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html

# Verify here
# https://jbt.github.io/markdown-editor/

& "$PSScriptRoot\..\ISEScripts\Reset-Module.ps1"

$markdown=""

$markdown+=New-MDHeader "This is an H1"
$markdown+=New-MDParagraph
$markdown+=New-MDHeader "This is an H2" -Level 2
$markdown+=New-MDParagraph
$markdown+="This is an H6"|New-MDHeader  -Level 6
$markdown+=New-MDParagraph

$lines=@(
    "Paragraphs are separated by empty lines. Within a paragraph it's possible to have a line break,"
    "simply press <return> for a new line."
)
$markdown+=$lines|New-MDParagraph
$markdown+=New-MDParagraph

$lines=@(
    "For example,"
    "like this."
)
$markdown+=New-MDParagraph -Lines $lines
$markdown+=New-MDParagraph

#region 
#TODO Somehow the new line is removed
$markdown+=New-MDCharacterStyle -Text "Italic characters" -Style Italic
$markdown+=New-MDParagraph

$markdown+=New-MDCharacterStyle -Text "bold characters" -Style Bold
$markdown+=New-MDParagraph

$markdown+=New-MDCharacterStyle -Text "strikethrough text" -Style StrikeThrough
$markdown+=New-MDParagraph
#endregion

$markdown+=New-MDParagraph
$lines=@(
    "Item 1"
    "Item 2"
    "Item 3"
)
$markdown+=New-MDList -Lines $lines -Style Unordered
$lines=@(
    "Item 3a"
    "Item 3b"
    "Item 3c"
)
$markdown+=$lines|New-MDList -Level 2 -Style Unordered

$markdown+=New-MDParagraph
$lines=@(
    "Step 1"
    "Step 2"
    "Step 3"
)
$markdown+=New-MDList -Lines $lines -Style Ordered
$lines=@(
    "Step 3.1"
    "Step 3.2"
    "Step 3.3"
)
$markdown+=$lines|New-MDList -Level 2 -Style Ordered

$markdown+=New-MDParagraph
$lines=@(
    "Step 1"
    "Step 2"
    "Step 3"
)
$markdown+=New-MDList -Lines $lines -Style Unordered
$lines=@(
    "Item 3a"
    "Item 3b"
    "Item 3c"
)
$markdown+=$lines|New-MDList -Level 2 -Style Ordered

$markdown+=New-MDParagraph -Lines "Introducing my quote:"
$markdown+=New-MDParagraph
$lines=@(
    "Neque porro quisquam est qui"
    "dolorem ipsum quia dolor sit amet, "
    "consectetur, adipisci velit..."
)
$markdown+=New-MDQuote -Lines $lines

#region 
#TODO Somehow the new line is removed

$markdown+="This is "+(New-MDLink -Text "an example" -Link "http://www.example.com/")+" inline link."
$markdown+=New-MDParagraph

$markdown+=(New-MDLink -Text "This link" -Link "http://www.example.com/" -Title "Title")+" has a title attribute."
$markdown+=New-MDParagraph

$markdown+=New-MDImage -Link "http://www.iana.org/_img/2013.1/iana-logo-header.svg" -AltText "Alt text"
$markdown+=New-MDParagraph
$markdown+=New-MDImage -Link "http://www.iana.org/_img/2013.1/iana-logo-header.svg" -AltText "Alt text" -Title "Optional title attribute"
$markdown+=New-MDParagraph
#endregion

$markdown
$markdown|clip

