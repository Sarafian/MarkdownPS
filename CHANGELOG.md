**v1.10** *20240531*
- Fixed issue with GH-33 where the `New-MDQuote` would output extra `> ` between quote lines

**v1.9** *20200227*
- Based on GH-20 the default output of `New-MDTable` has a cell length alignment per column. New parameter `-Shrink` is added to reduce the overall size and each cell is not padded. Thanks to @al-cheb

**v1.6** *20160420*
- Fixed published manifest file which broke the 1.5 module.
- No code changes.

**v1.5** *20160420*
- GH-17 thanks to @Wav3
- Removed from the manifest the `PowerShellHostVersion` because it created some issues with *in-remoting* like sessions.

**20160420**
- Within `New-MDImage` `[System.Uri]::EscapeDataString` is not escaping `(`,`)` when not executing from withing ise. Don't know why. Fixed with extra replacements.

**20160419**
- With `New-MDImage` changed parameter `-Link` to `-Source` to drive the image source.
- With `New-MDImage` added parameter `-Link` to make a link image.
- `New-MDImage` supports parameterset `shields.io` that generates badges from [shields.io](https://shields.io/) using the url format `https://img.shields.io/badge/%3CSUBJECT%3E-%3CSTATUS%3E-%3CCOLOR%3E.svg`.

**20160408**
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
