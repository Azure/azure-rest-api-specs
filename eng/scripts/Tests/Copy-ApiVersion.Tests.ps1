Import-Module Pester

BeforeAll {
    . "$PSScriptRoot\..\Copy-ApiVersion-Functions.ps1"
}

Describe "Copy-ApiVersion regex tests" {
    Context "Generate new version tag section" {
        It "Section tag corresponds to new version" -TestCases @(
            @{
                version       = "2024-01-01-preview"
                provider      = "Microsoft.AgFoodPlatform"
                versionStatus = "preview"
                specsDir      = '..\..\..\..\specification\agrifood\resource-manager\Microsoft.AgFoodPlatform\preview\2023-06-01-preview'
            },
            @{
                version       = "2024-01-01"
                provider      = "Microsoft.Compute\ComputeRP"
                versionStatus = "stable"
                specsDir      = '..\..\..\..\specification\compute\resource-manager\Microsoft.Compute\ComputeRP\stable\2023-09-01'
            },
            @{
                version       = "7.6-preview.1"
                provider      = "Microsoft.KeyVault"
                versionStatus = "preview"
                specsDir      = '..\..\..\..\specification\keyvault\data-plane\Microsoft.KeyVault\preview\7.6-preview.1'
            },
            @{
                version       = "7.5"
                provider      = "Microsoft.Compute\ComputeRP"
                versionStatus = "stable"
                specsDir      = '..\..\..\..\specification\keyvault\data-plane\Microsoft.KeyVault\stable\7.5'
            }
        ) {
            param($version, $provider, $versionStatus, $specsDir)
            
            $jsonFiles = Get-ChildItem $PSScriptRoot+$specsDir -Filter '*.json' | Select-Object -ExpandProperty Name
            $newTagSection = Get-NewTagSection $version $provider $versionStatus $jsonFiles
            
            $tag = $version
            if ($versionStatus -eq "preview") {
                $tag = "preview-" + $tag
            }

            $newTagSection | Should -Match "(?m)^### Tag: package-$tag$"
        }

        # TODO: This is fragile. The tests stop working when a service team updates their readme.md. We should instead take fixed copies or something.
        It "Default version gets updated" -TestCases @(
            @{
                inputReadme   = '..\..\..\..\specification\compute\resource-manager\readme.md'
                apiVersion    = "2024-01-01"
                versionStatus = "stable"
            },
            @{
                inputReadme   = '..\..\..\..\specification\compute\resource-manager\readme.md'
                apiVersion    = "2025-02"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\specification\compute\resource-manager\readme.md'
                apiVersion    = "2025-03-01"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\specification\securityinsights\resource-manager\readme.md'
                apiVersion    = "7.6"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\specification\keyvault\data-plane\readme.md'
                apiVersion    = "7.6-preview"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\specification\keyvault\data-plane\readme.md'
                apiVersion    = "7.6-preview.1"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\specification\securityinsights\resource-manager\readme.md'
                apiVersion    = "2025-05-01-preview"
                versionStatus = "preview"
            }
        ) {
            param($inputReadme, $apiVersion, $versionStatus)
            $contents = Get-Content $PSScriptRoot+$inputReadme -Raw
            $output = Get-ReadmeWithLatestTag $contents $apiVersion $versionStatus

            $tag = $apiVersion
            if ($versionStatus -eq "preview") {
                $tag = "preview-" + $tag
            }

            $output | Should -Match "(?m)^tag:\s*package-$tag$"
        }
    }
}