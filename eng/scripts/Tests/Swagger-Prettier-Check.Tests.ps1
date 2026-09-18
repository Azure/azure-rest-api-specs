BeforeAll {
    $repoRoot = Join-Path $TestDrive "repo with spaces"
    $scripts = Join-Path $repoRoot "eng/scripts"
    $commonScripts = Join-Path $repoRoot "eng/common/scripts"
    New-Item -ItemType Directory -Path $scripts, $commonScripts -Force | Out-Null
    $scriptPath = Join-Path $scripts "Swagger-Prettier-Check.ps1"
    Copy-Item "$PSScriptRoot/../Swagger-Prettier-Check.ps1" $scriptPath
    Set-Content (Join-Path $scripts "ChangedFiles-Functions.ps1") @'
function Get-ChangedSwaggerFiles {
    @("specification/first file.json", "specification/second.json")
}
'@
    Set-Content (Join-Path $commonScripts "logging.ps1") @'
function LogInfo {}
function LogError {}
function LogJobFailure {}
function LogErrorForFile {}
'@
}

Describe "Swagger-Prettier-Check" {
    BeforeEach {
        Mock node { $global:LASTEXITCODE = 0 }
    }

    It "runs Prettier directly for each changed file, including paths with spaces" {
        & $scriptPath
        $LASTEXITCODE | Should -Be 0
        Should -Invoke node -Times 2 -Exactly
        Should -Invoke node -Times 1 -Exactly -ParameterFilter {
            $args[0] -eq (Join-Path $repoRoot "node_modules/prettier/bin/prettier.cjs") -and
            $args[1] -eq "--check" -and
            $args[2] -eq "$repoRoot/specification/first file.json" -and
            $args[3] -eq "--log-level" -and
            $args[4] -eq "debug"
        }
    }

    It "passes the check-all glob unchanged to a single Prettier process" {
        & $scriptPath -CheckAll
        $LASTEXITCODE | Should -Be 0
        Should -Invoke node -Times 1 -Exactly -ParameterFilter {
            $args[0] -eq (Join-Path $repoRoot "node_modules/prettier/bin/prettier.cjs") -and
            $args[2] -eq "$repoRoot/specification/**/*.json"
        }
    }

    It "preserves failure reporting and checks the remaining files" {
        Mock node { $global:LASTEXITCODE = 1 }
        & $scriptPath
        $LASTEXITCODE | Should -Be 1
        Should -Invoke node -Times 2 -Exactly
    }
}
