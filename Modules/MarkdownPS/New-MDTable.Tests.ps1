$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"
$VerbosePreference="SilentlyContinue"
$newLine=[System.Environment]::NewLine
Describe "New-MDTable" {
    It "-Object is null" {
        {New-MDTable -Object $null} | Should Throw "because it is null."
    }
}
Describe "New-MDTable" {
    Context "Mock if necessary the ConvertTo-Markdown" {
        $command=Get-Command ConvertTo-Markdown -ErrorAction SilentlyContinue
        if((-not $command) -or $command.ModuleName -ne "PSMarkdown")
        {
            Write-Warning "Creating mock module PSMarkdownMock with ConvertTo-Markdown"
            New-Module -Name PSMarkdownMock  -ScriptBlock {
                function ConvertTo-Markdown { 
                    Begin {
                        $output=@(
                            "Header"
                            "Seperator"
                        )
                    }

                    Process {
                        $output+="Line"
                    }

                    End {
                        $output
                    }
                }

                Export-ModuleMember -Function ConvertTo-Markdown
            } | Import-Module -Force
        }
        $object=Get-Command New-MDTable |Select-Object Name,CommandType
        It "-NoNewLine not specified" {
            $expected=4
            ((New-MDTable -Object $object) -split [System.Environment]::NewLine ).Length| Should Be $expected
            (($object | New-MDTable) -split [System.Environment]::NewLine ).Length| Should Be $expected
        }
        It "-NoNewLine specified" {
            $expected=3
            ((New-MDTable -Object $object -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
            (($object | New-MDTable -NoNewLine) -split [System.Environment]::NewLine ).Length| Should Be $expected
        }
    }
}
