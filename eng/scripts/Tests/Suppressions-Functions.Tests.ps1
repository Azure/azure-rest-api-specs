BeforeAll {
    . "$PSScriptRoot/../Suppressions-Functions.ps1"
}

Describe "Get-Suppressions" {
    BeforeEach {
        Mock node {
            $global:LASTEXITCODE = 0
            '[]'
        }
    }

    It "runs the suppression CLI directly and preserves an empty array" {
        $result = @(Get-Suppressions "TypeSpecValidationAll" "specification/path with spaces")

        $result.Count | Should -Be 0
        Should -Invoke node -Times 1 -Exactly -ParameterFilter {
            $args[0] -like "*get-suppressions.js" -and
            $args[1] -eq "TypeSpecValidationAll" -and
            $args[2] -eq "specification/path with spaces"
        }
    }

    It "preserves a single suppression as an array of hashtables" {
        Mock node {
            $global:LASTEXITCODE = 0
            '[{"tool":"TypeSpecValidationAll","reason":"test","paths":["foo"]}]'
        }

        $result = @(Get-Suppressions "TypeSpecValidationAll" "specification/foo")
        $result.Count | Should -Be 1
        $result[0] | Should -BeOfType [System.Collections.IDictionary]
        $result[0].reason | Should -Be "test"
    }

    It "reports a nonzero CLI exit code" {
        Mock node {
            $global:LASTEXITCODE = 1
        }

        { Get-Suppressions "TypeSpecValidationAll" "missing" } | Should -Throw "*Failure running 'node*"
    }
}
