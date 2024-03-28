Import-Module Pester

. "$PSScriptRoot\..\..\Copy-ApiVersion-Functions.ps1"

Describe "Copy-ApiVersion" {
    Context "Update provider Readme file" {
        It "Should generate a new tag section with a list of all specs files for the new version" -TestCases @(
            @{
                version = "2024-01-01-preview"
                provider = "Microsoft.AgFoodPlatform"
                versionStatus = "preview"
                specFiles = @("agfood.json")
                expected = "newTag-Test1.md"
                providerSubFolder = $null
            },
            @{
                version = "2024-01-01"
                provider = "Microsoft.Compute"
                versionStatus = "preview"
                specFiles = @("availabilitySet.json","capacityReservation.json","computeRPCommon.json","dedicatedHost.json","image.json","logAnalytic.json","proximityPlacementGroup.json","restorePoint.json","runCommand.json","sshPublicKey.json","virtualMachine.json","virtualMachineExtensionImage.json","virtualMachineImage.json","virtualMachineScaleSet.json")
                expected = "newTag-Test2.md"
                providerSubFolder = "ComputeRP"
            }
        ) {
            param($version, $provider, $versionStatus, $specFiles, $expected, $providerSubFolder)
            $newContentBlock = Get-NewTagSection $version $provider $versionStatus $specFiles $providerSubFolder
            $fileToCompare = Get-Content "$PSScriptRoot\expected\$expected" -Raw
            $newContentBlock | Should be $fileToCompare
        }

        It "Should add the new tag section and update default tag" -TestCases @(
            @{
                readmeContent = "input\agfood.md"
                tagContent = "expected\newTag-Test1.md"
                expectedReadme = "expected\agfood.md"
                apiVersion = "2024-01-01-preview"
                saveName = "Test1"
            },
            @{
                readmeContent = "input\compute.md"
                tagContent = "expected\newTag-Test2.md"
                expectedReadme = "expected\compute.md"
                apiVersion = "2024-01-01-preview"
                saveName = "Test2"
            }
        ) {
            param($readmeContent, $tagContent, $expectedReadme, $apiVersion, $saveName)
            $readmeContent = Get-Content "$PSScriptRoot\$readmeContent" -Raw
            $tagContent = Get-Content "$PSScriptRoot\$tagContent" -Raw
            $contents = Get-ReadmeWithNewTag $readmeContent $tagContent
            $output = Get-ReadmeWithLatestTag $contents $apiVersion
            $expectedOutput = Get-Content "$PSScriptRoot\$expectedReadme" -Raw
            # Write output to file for manual inspection
            $output | Set-Content "$PSScriptRoot\OUTPUT-$saveName.md"
            $output | Should be $expectedOutput
        }
    }
}