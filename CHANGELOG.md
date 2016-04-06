**20160407**
- Removed dependency to `ConvertTo-Markdown` from [PSMarkdown](http://www.powershellgallery.com/packages/PSMarkdown).
- `New-MDTable` now supports columns alignment and sequencing

**20160401**
- Due to dependency to `ConvertTo-Markdown` from [PSMarkdown](http://www.powershellgallery.com/packages/PSMarkdown) the `New-MDTable will throw when `@($object,$object) | New-MDTable`

**20160329**
- Added comment to drive Get-Help

**20160328**
- Mocked the ConvertTo-Markdown when the dependency is not found.


**20160324**
Initial commit with the following commandlets (No `Get-Help` support yet)

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
