<#PSManifest
# This the hash to generate the module's manifest with New-ModuleManifest
@{
	# Required fields
	"RootModule"="MarkdownPS.psm1"
	"Description"="PowerShell module for Semantic Version"
	"Guid"="c1e7cbac-9e47-4906-8281-5f16471d7ccd"
	"ModuleVersion"="1.10"
	# Optional fields
	"Author"="Alex Sarafian"
	# "CompanyName" = "Company name"
	# "Copyright"="Some Copyright"
	"LicenseUri"='https://github.com/Sarafian/MarkdownPS/blob/master/LICENSE'
    "ProjectUri"= 'https://github.com/Sarafian/MarkdownPS/'
    Tags = 'Markdown', 'Tools'
    ReleaseNotes = 'https://github.com/Sarafian/MarkdownPS/blob/master/CHANGELOG.md'
    # Auto generated. Don't implement
}
#>

#requires -Version 4.0

$public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Exclude @("*.Tests.ps1"))
#$private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Exclude @("*.Tests.ps1"))
$private=@()

Foreach($import in @($public + $private))
{
	. $import.FullName
}

Export-ModuleMember -Function $public.BaseName