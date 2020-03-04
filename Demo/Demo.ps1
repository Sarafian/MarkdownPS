# Try to render some markdown as described here
# https://help.github.com/articles/basic-writing-and-formatting-syntax/

# Verify here
# https://jbt.github.io/markdown-editor/

Import-Module "$PSScriptRoot\..\Src\Modules\Import-MarkdownPS.ps1"

$markdown=""

#region headers

$markdown+=New-MDHeader "Headings"
$markdown+=New-MDHeader "The second largest heading" -Level 2
$markdown+="The smallest heading"|New-MDHeader  -Level 6

#endregion

#region paragraphs
$markdown+=New-MDHeader "Paragraphs"
$lines=@(
    "Paragraphs are separated by empty lines. Within a paragraph it's possible to have a line break,"
    "simply press <return> for a new line."
)
$markdown+=New-MDParagraph -Lines $lines

$lines=@(
    "For example,"
    "like this."
)

$markdown+=New-MDParagraph -Lines $lines

#endregion

#region CharacterStyle
$markdown+=New-MDHeader "Character styles"
$markdown+=New-MDCharacterStyle -Text "Italic characters" -Style Italic
$markdown+=New-MDParagraph
$markdown+=New-MDCharacterStyle -Text "bold characters" -Style Bold
$markdown+=New-MDParagraph
$markdown+=New-MDCharacterStyle -Text "strikethrough text" -Style StrikeThrough
$markdown+=New-MDParagraph
$markdown+="All Styles" | New-MDCharacterStyle -Style Bold| New-MDCharacterStyle -Style Italic | New-MDCharacterStyle -Style StrikeThrough
$markdown+=New-MDParagraph
#endregion

#region Lists
$markdown+=New-MDHeader "Lists"
$markdown+=New-MDHeader "Unordered" -Level 2
$markdown+=New-MDParagraph
$lines=@(
    "George Washington",
    "John Adams",
    "Thomas Jefferson"
)
$markdown+=New-MDList -Lines $lines -Style Unordered

$markdown+=New-MDHeader "Ordered" -Level 2
$lines=@(
    "James Madison",
    "James Monroe",
    "John Quincy Adams"
)
$markdown+=New-MDList -Lines $lines -Style Ordered

$markdown+=New-MDHeader "Mixed" -Level 2
$markdown+=New-MDList -Lines "Make my changes" -Style Ordered -NoNewLine
$markdown+=New-MDList -Lines @("Fix bug","Improve formatting") -Level 2 -Style Ordered -NoNewLine
$markdown+=New-MDList -Lines "Make the headings bigger" -Level 3 -Style Unordered -NoNewLine
$markdown+=New-MDList -Lines "Push my commits to GitHub" -Style Ordered -NoNewLine
$markdown+=New-MDList -Lines "Open a pull request" -Style Ordered -NoNewLine
$markdown+=New-MDList -Lines @("Describe my changes","Mention all the members of my team") -Level 2 -Style Ordered -NoNewLine
$markdown+=New-MDList -Lines "Ask for feedback" -Level 3 -Style Unordered

#endregion

#region Quote
$markdown+=New-MDHeader "Quote"
$markdown+=New-MDParagraph -Lines "In the words of Abraham Lincoln:"
$lines=@(
    "Pardon my French"
)
$markdown+=New-MDQuote -Lines $lines

$markdown+=New-MDParagraph -Lines "Multi line quote"
$lines=@(
    "Line 1"
    "Line 2"
)
$markdown+=New-MDQuote -Lines $lines
#endregion

#region 
$markdown+=New-MDHeader "Links"
$markdown+="This is "+(New-MDLink -Text "an example" -Link "http://www.example.com/")+" inline link."
$markdown+=New-MDParagraph

$markdown+=(New-MDLink -Text "This link" -Link "http://www.example.com/" -Title "Title")+" has a title attribute."
$markdown+=New-MDParagraph

$markdown+=New-MDHeader "Images"
$markdown+=New-MDImage -Source "http://www.iana.org/_img/2013.1/iana-logo-header.svg" -AltText "Alt text"
$markdown+=New-MDParagraph
$markdown+=New-MDImage -Source "http://www.iana.org/_img/2013.1/iana-logo-header.svg" -AltText "Alt text" -Title "Optional title attribute"
$markdown+=New-MDParagraph

$markdown+=New-MDHeader "Badges"
$markdown+=New-MDHeader "shields.io" -Level 2
$markdown+=New-MDParagraph -Lines "Badge " -NoNewLine 
$markdown+=New-MDImage -Subject "<SUBJECT>" -Status "<STATUS>" -Color red
$markdown+=New-MDParagraph
$markdown+=New-MDParagraph -Lines "Badge with link" -NoNewLine 
$markdown+=New-MDImage -Subject "<SUBJECT>" -Status "<STATUS>" -Color red -Link "https://img.shields.io/badge/%3CSUBJECT%3E-%3CSTATUS%3E-red.svg"
$markdown+=New-MDParagraph
#endregion

#region Code quote
$markdown+=New-MDHeader "Code"
$markdown+="Use "+(New-MDInlineCode -Text "git status") + "to list all new or modified files that haven't yet been committed."
$markdown+=New-MDParagraph

$markdown+=New-MDParagraph -Lines "Some basic Git commands are:"
$lines=@(
    "git status",
    "git add",
    "git commit"
)
$markdown+=New-MDCode -Lines $lines

$lines=@(
    '<?xml version="1.0" encoding="UTF-8"?>'
    "<node />"
)
$markdown+=New-MDCode -Lines $lines -Style "xml"


#endregion

#region Tables
$markdown+=New-MDHeader "Tables"
$markdown+=New-MDParagraph -Lines "Without aligned columns"
$markdown+=Get-Command -Module MarkdownPS |Select-Object Name,CommandType,Version | New-MDTable
$markdown+=New-MDParagraph -Lines "With aligned columns"
$markdown+=Get-Command -Module MarkdownPS | New-MDTable -Columns ([ordered]@{Name="left";CommandType="center";Version="right"})
#endregion

$markdown
$markdown|clip

