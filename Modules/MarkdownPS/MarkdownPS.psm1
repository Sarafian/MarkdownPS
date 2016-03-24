$names=(
    "New-MDHeader",
    "New-MDParagraph",
    "New-MDCharacterStyle",
    "New-MDLink",          
    "New-MDList",          
    "New-MDQuote",         
    "New-MDInlineCode",    
    "New-MDCode",          
    "New-MDImage",         
    "New-MDTable"
)

$names | ForEach-Object {. $PSScriptRoot\$_.ps1 }

Export-ModuleMember $names


