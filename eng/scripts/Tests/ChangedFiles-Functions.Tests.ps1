BeforeAll {
    . "$PSScriptRoot\..\ChangedFiles-Functions.ps1"
}

Describe "Get-ChangedCoreFiles" {
    It "excludes ARM lease metadata at <path>" -ForEach @(
        @{ path = ".github/arm-leases/containerregistry/Microsoft.ContainerRegistry/lease.yaml" },
        @{ path = ".github/arm-leases/containerregistry/Microsoft.ContainerRegistry/Workflow/lease.yaml" },
        @{ path = ".github/arm-leases/README.md" }
    ) {
        @(Get-ChangedCoreFiles @($path)).Count | Should -Be 0
    }

    It "preserves the core-file trigger for <path>" -ForEach @(
        @{ path = ".github/workflows/typespec-validation.yaml" },
        @{ path = ".github/shared/src/changed-files.ts" },
        @{ path = ".github/arm-leases-other/lease.yaml" },
        @{ path = "eng/scripts/Get-TypeSpec-Folders.ps1" },
        @{ path = "specification/common-types/resource-management/v6/types.json" },
        @{ path = "package.json" },
        @{ path = ".oxfmtrc.json" },
        @{ path = ".prettierrc.json" },
        @{ path = "pnpm-lock.yaml" },
        @{ path = "pnpm-workspace.yaml" }
    ) {
        @(Get-ChangedCoreFiles @($path)) | Should -Be @($path)
    }

    It "preserves core changes in a mixed lease and core-file change" {
        $changedFiles = @(
            ".github/arm-leases/containerregistry/Microsoft.ContainerRegistry/Workflow/lease.yaml",
            "pnpm-lock.yaml",
            "pnpm-workspace.yaml"
        )

        @(Get-ChangedCoreFiles $changedFiles) | Should -Be @("pnpm-lock.yaml", "pnpm-workspace.yaml")
    }

    It "preserves scoped spec selection in a mixed lease and TypeSpec change" {
        $specFile = "specification/containerregistry/resource-manager/Microsoft.ContainerRegistry/Registry/main.tsp"
        $changedFiles = @(
            ".github/arm-leases/containerregistry/Microsoft.ContainerRegistry/Workflow/lease.yaml",
            $specFile
        )

        @(Get-ChangedCoreFiles $changedFiles).Count | Should -Be 0
        @(Get-ChangedFilesUnderSpecification $changedFiles) | Should -Be @($specFile)
    }

    It "returns no core files for an empty change" {
        @(Get-ChangedCoreFiles @()).Count | Should -Be 0
    }
}
