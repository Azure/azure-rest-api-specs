BeforeAll {
    $scriptPath = Join-Path $PSScriptRoot ".." "Get-TypeSpec-Folders.ps1"
    $testRepo = Join-Path $TestDrive "repo"

    New-Item -ItemType Directory -Path "$testRepo/specification/service/OldProject" -Force | Out-Null
    New-Item -ItemType Directory -Path "$testRepo/.github" -Force | Out-Null
    Set-Content -Path "$testRepo/specification/service/OldProject/tspconfig.yaml" -Value "extends: test"
    Set-Content -Path "$testRepo/.github/workflow.yaml" -Value "name: initial"

    git -C $testRepo init --quiet
    git -C $testRepo config user.email "test@example.com"
    git -C $testRepo config user.name "Test User"
    git -C $testRepo add .
    git -C $testRepo commit --quiet -m "base"
    $baseRevision = git -C $testRepo rev-parse HEAD

    Set-Content -Path "$testRepo/.github/workflow.yaml" -Value "name: changed"
    git -C $testRepo add .
    git -C $testRepo commit --quiet -m "head"
    $headRevision = git -C $testRepo rev-parse HEAD

    New-Item -ItemType Directory -Path "$testRepo/specification/service/NewProject" -Force | Out-Null
    Move-Item `
        -Path "$testRepo/specification/service/OldProject/tspconfig.yaml" `
        -Destination "$testRepo/specification/service/NewProject/tspconfig.yaml"
    Remove-Item -Path "$testRepo/specification/service/OldProject"
    git -C $testRepo add .
    git -C $testRepo commit --quiet -m "target branch migration"
    $targetRevision = git -C $testRepo rev-parse HEAD
}

AfterAll {
    Get-ChildItem -Path $testRepo -Recurse -Force -File -ErrorAction SilentlyContinue |
        ForEach-Object { $_.IsReadOnly = $false }
    Remove-Item -Path $testRepo -Recurse -Force -ErrorAction SilentlyContinue
}

Describe "Get-TypeSpec-Folders" {
    BeforeEach {
        Push-Location $testRepo
    }

    AfterEach {
        Pop-Location
    }

    It "discovers projects from the compared revisions when core files change" {
        $result = @(
            & $scriptPath `
                -RepoPath $testRepo `
                -BaseCommitish $baseRevision `
                -HeadCommitish $headRevision
        )

        @($result[0]) | Should -Be @("specification/service/OldProject")
        $result[-1] | Should -BeTrue
    }

    It "includes projects present in either revision when a project is renamed" {
        $result = @(
            & $scriptPath `
                -RepoPath $testRepo `
                -BaseCommitish $baseRevision `
                -HeadCommitish $targetRevision
        )

        $projects = @($result[0])
        $projects | Should -HaveCount 2
        $projects | Should -Contain "specification/service/NewProject"
        $projects | Should -Contain "specification/service/OldProject"
        $result[-1] | Should -BeTrue
    }

    It "preserves current-checkout discovery for explicit CheckAll callers" {
        $result = @(& $scriptPath -RepoPath $testRepo -CheckAll)

        @($result[0]) | Should -Be @("specification/service/NewProject")
        $result[-1] | Should -BeTrue
    }
}
