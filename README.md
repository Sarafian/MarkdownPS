# MarkdownPS

[![Join the chat at https://gitter.im/Sarafian/MarkdownPS](https://badges.gitter.im/Sarafian/MarkdownPS.svg)](https://gitter.im/Sarafian/MarkdownPS?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
A powershell module to render markdown files. 

| Branch | Status
| ---------- | ---------
| **master** | ![masterstatus](https://asarafian.visualstudio.com/DefaultCollection/_apis/public/build/definitions/9411077a-da68-4370-9d62-7fa8ec77dfa9/9/badge)
| **develop** | ![masterstatus](https://asarafian.visualstudio.com/DefaultCollection/_apis/public/build/definitions/9411077a-da68-4370-9d62-7fa8ec77dfa9/8/badge)

[MarkdownPS](https://www.powershellgallery.com/packages/MarkdownPS/) on powershell gallery.

# Commandlets

- New-MDCharacterStyle
- New-MDCode
- New-MDHeader
- New-MDImage
- New-MDInlineCode
- New-MDLink
- New-MDList
- New-MDParagraph
- New-MDQuote
- New-MDTable

# Example script

## The showcase script

The following [Showcase](Scripts/Showcase.ps1) script renders various artifacts as described on [Github/Basic writing and formatting syntax](https://help.github.com/articles/basic-writing-and-formatting-syntax/) and the output is validated on [(GitHub-Flavored) Markdown Editor](https://jbt.github.io/markdown-editor/)

```powershell
# Try to render some markdown as described here
# https://help.github.com/articles/basic-writing-and-formatting-syntax/

# Verify here
# https://jbt.github.io/markdown-editor/

& "$PSScriptRoot\..\ISEScripts\Reset-Module.ps1"

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
```

## The output

> # Headings
> ## The second largest heading
> ###### The smallest heading
> # Paragraphs
> Paragraphs are separated by empty lines. Within a paragraph it's possible to have a line break,
> simply press <return> for a new line.
> 
> For example,
> like this.
> 
> # Character styles
> *Italic characters*
> 
> **bold characters**
> 
> ~~strikethrough text~~
> 
> ~~***All Styles***~~
> 
> # Lists
> ## Unordered
> 
> 
> - George Washington
> - John Adams
> - Thomas Jefferson
> 
> ## Ordered
> 1. James Madison
> 2. James Monroe
> 3. John Quincy Adams
> 
> ## Mixed
> 1. Make my changes
>    1. Fix bug
>    2. Improve formatting
>     - Make the headings bigger
> 1. Push my commits to GitHub
> 1. Open a pull request
>    1. Describe my changes
>    2. Mention all the members of my team
>     - Ask for feedback
> 
> # Quote
> In the words of Abraham Lincoln:
> 
> > Pardon my French
> 
> Multi line quote
> 
> > Line 1
> >
> > Line 2
> 
> # Links
> This is [an example](http://www.example.com/) inline link.
> 
> [This link](http://www.example.com/ "Title") has a title attribute.
> 
> # Images
> ![Alt text](http://www.iana.org/_img/2013.1/iana-logo-header.svg)
> 
> ![Alt text](http://www.iana.org/_img/2013.1/iana-logo-header.svg "Optional title attribute")
> 
> # Badges
> ## shields.io
> Badge 
> ![](https://img.shields.io/badge/%3CSUBJECT%3E-%3CSTATUS%3E-red.svg)
> 
> Badge with link
> [![](https://img.shields.io/badge/%3CSUBJECT%3E-%3CSTATUS%3E-red.svg)](https://img.shields.io/badge/%3CSUBJECT%3E-%3CSTATUS%3E-red.svg)
> 
> # Code
> Use `git status`to list all new or modified files that haven't yet been committed.
> 
> Some basic Git commands are:
> 
> ```
>     git status
>     git add
>     git commit
> ```
> ```xml
>     <?xml version="1.0" encoding="UTF-8"?>
>     <node />
> ```
> # Tables
> Without aligned columns
> 
> | Name                 | CommandType          | Version              |
> | -------------------- | -------------------- | -------------------- |
> | New-MDCharacterStyle | Function             | 1.2                  |
> | New-MDCode           | Function             | 1.2                  |
> | New-MDHeader         | Function             | 1.2                  |
> | New-MDImage          | Function             | 1.2                  |
> | New-MDInlineCode     | Function             | 1.2                  |
> | New-MDLink           | Function             | 1.2                  |
> | New-MDList           | Function             | 1.2                  |
> | New-MDParagraph      | Function             | 1.2                  |
> | New-MDQuote          | Function             | 1.2                  |
> | New-MDTable          | Function             | 1.2                  |
> With aligned columns
> 
> | Name                 | CommandType          | Version              |
> | -------------------- |:--------------------:| --------------------:|
> | New-MDCharacterStyle | Function             | 1.2                  |
> | New-MDCode           | Function             | 1.2                  |
> | New-MDHeader         | Function             | 1.2                  |
> | New-MDImage          | Function             | 1.2                  |
> | New-MDInlineCode     | Function             | 1.2                  |
> | New-MDLink           | Function             | 1.2                  |
> | New-MDList           | Function             | 1.2                  |
> | New-MDParagraph      | Function             | 1.2                  |
> | New-MDQuote          | Function             | 1.2                  |
> | New-MDTable          | Function             | 1.2                  |