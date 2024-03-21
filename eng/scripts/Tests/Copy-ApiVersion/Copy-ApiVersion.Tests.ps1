Import-Module Pester

. "$PSScriptRoot\..\..\Copy-ApiVersion-Functions.ps1"

Describe "Copy-ApiVersion" {
    Context "Update provider Readme file" {
        It "Should generate a new tag section with all specs files listed for the new version" -TestCases @(
            @{
                version = "2024-04-01-preview"
                provider = "Microsoft.AgFoodPlatform"
                versionStatus = "preview"
                specFiles = @("agfood.json")
                expected = "newTag-Test1.md"
            },
            @{
                version = "2024-12-01"
                provider = "Microsoft.Batch"
                versionStatus = "stable"
                specFiles = @("BatchManagement.json")
                expected = "newTag-Test2.md"
            }
        ) {
            param($version, $provider, $versionStatus, $specFiles, $expected)
            $newContentBlock = Get-NewTagSection $version $provider $versionStatus $specFiles
            $fileToCompare = Get-Content "$PSScriptRoot\expected\$expected" -Raw
            $newContentBlock | Should be $fileToCompare
        }
    }
}