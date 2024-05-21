Import-Module Pester

. "$PSScriptRoot\..\..\Copy-ApiVersion-Functions.ps1"

Describe "Copy-ApiVersion regex tests" {
    Context "Generate new version tag section" {
        It "Section tag corresponds to new version" -TestCases @(
            @{
                version       = "2024-01-01-preview"
                provider      = "Microsoft.AgFoodPlatform"
                versionStatus = "preview"
                specsDir      = '..\..\..\..\..\specification\agrifood\resource-manager\Microsoft.AgFoodPlatform\preview\2023-06-01-preview'
            },
            @{
                version       = "2024-01-01"
                provider      = "Microsoft.Compute\ComputeRP"
                versionStatus = "stable"
                specsDir      = '..\..\..\..\..\specification\compute\resource-manager\Microsoft.Compute\ComputeRP\stable\2023-09-01'
            }
        ) {
            param($version, $provider, $versionStatus, $specsDir)
            
            $jsonFiles = Get-ChildItem $PSScriptRoot+$specsDir -Filter '*.json' | Select-Object -ExpandProperty Name
            $newTagSection = Get-NewTagSection $version $provider $versionStatus $jsonFiles
            
            $version -match '\d{4}-\d{2}'
            $tag = $Matches[0]
            if ($versionStatus -eq "preview") {
                $tag = "preview-" + $tag
            }

            $newTagSection | Should match "package-$tag"
        }

        It "Default version gets updated" -TestCases @(
            @{
                inputReadme   = '..\..\..\..\..\specification\agrifood\resource-manager\readme.md'
                apiVersion    = "2024-01-01-preview"
                versionStatus = "preview"
            },
            @{
                inputReadme   = '..\..\..\..\..\specification\compute\resource-manager\readme.md'
                apiVersion    = "2024-01-01"
                versionStatus = "stable"
            }
        ) {
            param($inputReadme, $apiVersion, $versionStatus)
            $contents = Get-Content $PSScriptRoot+$inputReadme -Raw
            $output = Get-ReadmeWithLatestTag $contents $apiVersion $versionStatus
            $tag = $apiVersion -match '\d{4}-\d{2}'
            $tag = $Matches[0]
            if ($versionStatus -eq "preview") {
                $tag = "preview-" + $tag
            }
            $output | Should match "(?m)^tag:\s*package-$tag"
        }
    }
}