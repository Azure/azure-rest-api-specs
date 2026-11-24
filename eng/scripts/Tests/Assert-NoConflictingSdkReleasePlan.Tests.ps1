BeforeAll {
    $script:checkReleasePlans = Join-Path $PSScriptRoot .. Assert-NoConflictingSdkReleasePlan.ps1
    $script:typeSpecConfigPath = 'specification/contoso/Contoso.Management/tspconfig.yaml'

    function az {
        throw 'Unexpected Azure CLI call.'
    }
}

Describe 'Assert-NoConflictingSdkReleasePlan' {
    BeforeEach {
        $mockActiveReleasePlans = @()
        Mock az { 'test-token' }
        Mock Invoke-RestMethod { throw 'Unexpected DevOps request.' }
        Mock Invoke-RestMethod {
            @{ workItems = @($mockActiveReleasePlans | ForEach-Object { @{ id = $_.id } }) }
        } -ParameterFilter { $Method -eq 'Post' -and $Uri.AbsolutePath -like '*/wiql/' }
        Mock Invoke-RestMethod {
            @{ value = $mockActiveReleasePlans }
        } -ParameterFilter { $Method -eq 'Get' -and $Uri.AbsolutePath -like '*/workitems' }
    }

    It 'blocks <sdkRepo> generation without a release plan ID' -ForEach @(
        @{ sdkRepo = 'azure-sdk-for-net'; devOpsLanguage = 'Dotnet' },
        @{ sdkRepo = 'azure-sdk-for-js'; devOpsLanguage = 'JavaScript' },
        @{ sdkRepo = 'azure-sdk-for-python-pr'; devOpsLanguage = 'Python' },
        @{ sdkRepo = 'azure-sdk-for-java'; devOpsLanguage = 'Java' },
        @{ sdkRepo = 'azure-sdk-for-go'; devOpsLanguage = 'Go' }
    ) {
        $mockActiveReleasePlans = @(
            @{ id = 101; fields = @{ "Custom.SDKPullRequestFor$devOpsLanguage" = 'https://github.com/Azure/sdk/pull/1' } }
        )

        { & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName $sdkRepo } |
            Should -Throw "*release plan work item 101*unreleased $devOpsLanguage SDK pull request*"
    }

    It 'blocks a different selected plan that has no pull request for this language' {
        $mockActiveReleasePlans = @(
            @{ id = 101; fields = @{ 'Custom.SDKPullRequestForPython' = 'https://github.com/Azure/azure-sdk-for-python/pull/1' } }
            @{ id = 102; fields = @{ 'Custom.SDKPullRequestForJava' = 'https://github.com/Azure/azure-sdk-for-java/pull/2' } }
        )

        { & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName 'azure-sdk-for-python' -ReleasePlanWorkItemId 102 } |
            Should -Throw '*release plan work item 101*'
    }

    It 'allows regeneration when the selected active plan already has a pull request for this language' {
        $mockActiveReleasePlans = @(
            @{ id = 101; fields = @{ 'Custom.SDKPullRequestForPython' = 'https://github.com/Azure/azure-sdk-for-python/pull/1' } }
            @{ id = 102; fields = @{ 'Custom.SDKPullRequestForPython' = 'https://github.com/Azure/azure-sdk-for-python/pull/2' } }
        )

        { & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName 'azure-sdk-for-python' -ReleasePlanWorkItemId 102 } |
            Should -Not -Throw
    }

    It 'allows generation with <scenario>' -ForEach @(
        @{ scenario = 'no active plans'; plans = @() },
        @{ scenario = 'no SDK pull request'; plans = @(@{ id = 101; fields = @{} }) },
        @{
            scenario = 'a pull request for another language'
            plans = @(@{ id = 101; fields = @{ 'Custom.SDKPullRequestForJava' = 'https://github.com/Azure/azure-sdk-for-java/pull/1' } })
        },
        @{
            scenario = 'an already released SDK'
            plans = @(@{
                id = 101
                fields = @{
                    'Custom.SDKPullRequestForPython' = 'https://github.com/Azure/azure-sdk-for-python/pull/1'
                    'Custom.ReleaseStatusForPython' = 'Released'
                }
            })
        }
    ) {
        $mockActiveReleasePlans = $plans

        { & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName 'azure-sdk-for-python' -ReleasePlanWorkItemId 0 } |
            Should -Not -Throw
    }

    It 'looks up active non-test plans for the exact TypeSpec project' {
        & $script:checkReleasePlans -TypeSpecConfigPath "specification/contoso/./Contoso's.Service/tspconfig.yaml" -SdkRepoName 'azure-sdk-for-python'

        Should -Invoke Invoke-RestMethod -ParameterFilter {
            $query = ($Body | ConvertFrom-Json).query
            $Method -eq 'Post' -and
            $query.Contains("[System.WorkItemType] = 'Release Plan'") -and
            $query.Contains("[Custom.ApiSpecProjectPath] = 'specification/contoso/Contoso''s.Service'") -and
            $query.Contains("[System.State] NOT IN ('Closed','Duplicate','Abandoned','Finished')") -and
            $query.Contains("[System.Tags] NOT CONTAINS 'Release Planner App Test'")
        }
    }

    It 'fails when active plans cannot be read' {
        Mock Invoke-RestMethod { throw 'Azure DevOps is unavailable.' } -ParameterFilter { $Method -eq 'Post' }

        { & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName 'azure-sdk-for-python' } |
            Should -Throw '*Azure DevOps is unavailable*'
    }

    It 'does not look up release plans for an SDK language they do not track' {
        & $script:checkReleasePlans -TypeSpecConfigPath $script:typeSpecConfigPath -SdkRepoName 'azure-sdk-for-rust'

        Should -Invoke Invoke-RestMethod -Times 0 -Exactly
    }
}
