Install-Module -Name powershell-yaml

. $PSScriptRoot/../common/scripts/common.ps1

$baseOwner = $env:GITHUB_EVENT_PULL_REQUEST_BASE_REPO_OWNER
$baseRepo = $env:GITHUB_EVENT_PULL_REQUEST_BASE_REPO_NAME
$baseBranch = $env:GITHUB_EVENT_PULL_REQUEST_BASE_REF

$headOwner = $env:GITHUB_EVENT_PULL_REQUEST_HEAD_REPO_OWNER
$headRepo = $env:GITHUB_EVENT_PULL_REQUEST_HEAD_REPO_NAME
$headBranch = $env:GITHUB_EVENT_PULL_REQUEST_HEAD_REF

$prNumber = $env:GITHUB_EVENT_PULL_REQUEST_NUMBER

$GithubToken = $env:SPEC_REPO_TOKEN

LogNotice "Base Owner: $baseOwner"
LogNotice "Base Repo: $baseRepo"
LogNotice "Base Branch: $baseBranch"
LogNotice "Head Owner: $headOwner"
LogNotice "Head Repo: $headRepo"
LogNotice "Head Branch: $headBranch"
LogNotice "Pull Request Number: $prNumber"

$SuppressionFileName = "sdk-suppressions.yaml"

$sdkLabels = @{
    "azure-sdk-for-go"               = @{
        breakingChange                    = "BreakingChange-Go-Sdk"
        breakingChangeApproved            = "BreakingChange-Go-Sdk-Approved"
        breakingChangeSuppression         = "BreakingChange-Go-Sdk-Suppression"
        breakingChangeSuppressionApproved = "BreakingChange-Go-Sdk-Suppression-Approved"
    }
    "azure-sdk-for-java"             = @{
        breakingChange                    = "BreakingChange-Java-Sdk"
        breakingChangeApproved            = "BreakingChange-Java-Sdk-Approved"
        breakingChangeSuppression         = "BreakingChange-Java-Sdk-Suppression"
        breakingChangeSuppressionApproved = "BreakingChange-Java-Sdk-Suppression-Approved"
    }
    "azure-sdk-for-js"               = @{
        breakingChange                    = "BreakingChange-JavaScript-Sdk"
        breakingChangeApproved            = "BreakingChange-JavaScript-Sdk-Approved"
        breakingChangeSuppression         = "BreakingChange-JavaScript-Sdk-Suppression"
        breakingChangeSuppressionApproved = "BreakingChange-JavaScript-Sdk-Suppression-Approved"
    }
    "azure-sdk-for-net"              = @{
        breakingChange                    = $null
        breakingChangeApproved            = $null
        breakingChangeSuppression         = $null
        breakingChangeSuppressionApproved = $null
    }
    "azure-sdk-for-python"           = @{
        breakingChange                    = "BreakingChange-Python-Sdk"
        breakingChangeApproved            = "BreakingChange-Python-Sdk-Approved"
        breakingChangeSuppression         = "BreakingChange-Python-Sdk-Suppression"
        breakingChangeSuppressionApproved = "BreakingChange-Python-Sdk-Suppression-Approved"
    }
}

# Check if the token is available
if ($null -eq $GithubToken) {
    LogError "GitHub token is not available"
    exit 1
}

function Get-SDKNames {
    param (
        [Parameter(Mandatory = $true)]
        $BaseRepoOwner,
        [Parameter(Mandatory = $true)]
        $BaseRepoName,
        [Parameter(Mandatory = $true)]
        $BaseRepoBranch,
        [Parameter(Mandatory = $true)]
        $HeadRepoName,
        [Parameter(Mandatory = $true)]
        $HeadRepoOwner,
        [Parameter(Mandatory = $true)]
        $HeadRepoBranch,
        [Parameter(Mandatory = $true)]
        $IssueNumber,
        [Parameter(Mandatory = $true)]
        $SuppressionFiles,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $true)]
        $AuthToken
    )
    $sdkNames = @()
    foreach ($suppressionFile in $SuppressionFiles) {
        $HeadSDKSuppressionYaml = Get-GitHubFileContent -Token $AuthToken -RepoOwner $HeadRepoOwner -RepoName $HeadRepoName -FilePath $SuppressionFile -Branch $HeadRepoBranch
        $BaseSDKSuppressionYaml = Get-GitHubFileContent -Token $AuthToken -RepoOwner $BaseRepoOwner -RepoName $BaseRepoName -FilePath $SuppressionFile -Branch $BaseRepoBranch

        if (!$HeadSDKSuppressionYaml -or !$BaseSDKSuppressionYaml) {
            LogError "Unable to retrieve file content."
            exit 1
        }
        $HeadSDKSuppressionYamlContent = Convert-Yaml -yamlContent $HeadSDKSuppressionYaml
        $BaseSDKSuppressionYamlContent = Convert-Yaml -yamlContent $BaseSDKSuppressionYaml
    
        if (!$HeadSDKSuppressionYamlContent -or !$BaseSDKSuppressionYamlContent) {
            LogError "Yaml is invalid"
            exit 1
        } 

        $sdkNames += Get-SdkName $HeadSDKSuppressionYamlContent $BaseSDKSuppressionYamlContent
    }

    $sdkNames | Sort-Object -Unique | ForEach-Object { Write-Output $_ }
    return $sdkNames
}

function Get-SdkName {
    param (
        [Parameter(Mandatory)]
        $HeadSDKSuppressionYamlContent,

        [Parameter(Mandatory)]
        $BaseSDKSuppressionYamlContent
    )

    $sdkNamesWithChangedSuppressions = [System.Collections.ArrayList]::new()
    $headSdkSuppressionsSection = $HeadSDKSuppressionYamlContent.suppressions
    $baseSdkSuppressionsSection = $BaseSDKSuppressionYamlContent.suppressions
    
    $headSdksWithSuppressions = $headSdkSuppressionsSection.Keys
    $baseSdksWithSuppressions = $baseSdkSuppressionsSection.Keys
    
    if ($headSdksWithSuppressions.length -eq 0) {
        if ($baseSdksWithSuppressions.length -gt 0) {
            [void]$sdkNamesWithChangedSuppressions.AddRange($baseSdksWithSuppressions)
        }
    }
    # 1. If modify Sdk in SdkSuppressionsSection, add SdkName to sdkNamesWithChangedSuppressions
    $differentSdkNamesWithChangedSuppressions = @(
        $headSdksWithSuppressions | Where-Object { -not ($baseSdksWithSuppressions -contains $_) }
        $baseSdksWithSuppressions | Where-Object { -not ($headSdksWithSuppressions -contains $_) }
    )
    
    if ($differentSdkNamesWithChangedSuppressions.length -gt 0) {
        [void]$sdkNamesWithChangedSuppressions.AddRange($differentSdkNamesWithChangedSuppressions)
    }
    
    #  2. If modify SdkPackageSuppressionsEntry in SdkSuppressionsSection include package name and breaking changes , add SdkName to sdkNamesWithChangedSuppressions
    $similarSdkNamesWithChangedSuppressions = $headSdksWithSuppressions | Where-Object { $baseSdksWithSuppressions -contains $_ }
    
    foreach ($sdkName in $similarSdkNamesWithChangedSuppressions) {
        $headSdkPackageSuppressionsEntry = $headSdkSuppressionsSection[$sdkName]
        $baseSdkPackageSuppressionsEntry = $baseSdkSuppressionsSection[$sdkName]
    
        $headPackages = $headSdkPackageSuppressionsEntry | ForEach-Object { $_.package }
        $basePackages = $baseSdkPackageSuppressionsEntry | ForEach-Object { $_.package }
    
        $differentPackageNamesWithChangedSuppressions = @(
            $headPackages | Where-Object { -not ($basePackages -contains $_) }
            $basePackages | Where-Object { -not ($headPackages -contains $_) }
        )
    
        if ($differentPackageNamesWithChangedSuppressions.length -gt 0) {
            [void]$sdkNamesWithChangedSuppressions.Add($sdkName)
            continue;
        }
        foreach ($headEntry in $headSdkPackageSuppressionsEntry) {
            $baseEntry = $baseSdkPackageSuppressionsEntry | Where-Object { $_.package -eq $headEntry.package }
            if (!$baseEntry) {
                [void]$sdkNamesWithChangedSuppressions.Add($sdkName)
                continue;
            }
    
            $headEntryBreakingChanges = $headEntry["breaking-changes"]
            $baseEntryBreakingChanges = $baseEntry["breaking-changes"]
            $differentBreakingChangesWithChangedSuppressions = @(
                $headEntryBreakingChanges | Where-Object { -not ($baseEntryBreakingChanges -contains $_) }
                $baseEntryBreakingChanges | Where-Object { -not ($headEntryBreakingChanges -contains $_) }
            )
            if ($differentBreakingChangesWithChangedSuppressions.length -gt 0) {
                [void]$sdkNamesWithChangedSuppressions.Add($sdkName)
                continue;
            }
        }
    
    }
    
    # $sdkNamesWithChangedSuppressions = $sdkNamesWithChangedSuppressions | Sort-Object -Unique
    # # $sdkNamesWithChangedSuppressions | Sort-Object -Unique | ForEach-Object { Write-Output $_ }
    return $sdkNamesWithChangedSuppressions
}

function Convert-Yaml {
    param (
        [Parameter(Mandatory = $true)]
        [string]$yamlContent
    )

    try {
        $yamlParsed = $yamlContent | ConvertFrom-Yaml
    }
    catch {
        return "ConvertFrom-Yaml Error: $($_.Exception.Message)"
    }

    return $yamlParsed
}

function Update-Label {
    param (
        [Parameter(Mandatory = $true)]
        $RepoOwner,
        [Parameter(Mandatory = $true)]
        $RepoName,
        [Parameter(Mandatory = $true)]
        $IssueNumber,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory = $true)]
        $AuthToken,
        [Parameter(Mandatory)]
        $sdkNames,
        [Parameter(Mandatory)]
        $sdkLabels,
        [Parameter(Mandatory)]
        $presentLabels
    )

    if ($sdkNames.Length -eq 0) {
        $sdkSuppressionsLabels = $sdkLabels | ForEach-Object { $_.values.'breakingChangeSuppression' }
        # $sdkSuppressionsLabels | Sort-Object -Unique | ForEach-Object { Write-Output $_ }
    
        $removeSdkSuppressionsLabels = [System.Collections.ArrayList]::new()
        foreach ($prLabel in $presentLabels) {
            if ($sdkSuppressionsLabels -contains $prLabel) {
                $sdkSuppressionsApprovedLabel = $null
                foreach ($sdk in $sdkLabels.GetEnumerator()) {
                    if ($sdk.Value.'breakingChangeSuppression' -eq $prLabel) {
                        $sdkSuppressionsApprovedLabel = $sdk.Value.'breakingChangeSuppressionApproved'
                        break
                    }
                }
                if (-not ($presentLabels -contains $sdkSuppressionsApprovedLabel)) {
                    LogNotice "updateSdkSuppressionsLabels: PR: $("pr.html_url") To remove the existed suppression label if there are no difference between head commit and base commit for the suppression content."
                    [void]$removeSdkSuppressionsLabels.Add($prLabel);
                }
            }
        }
        if ($removeSdkSuppressionsLabels.length -gt 0) {
            Remove-GithubIssueLabels -RepoOwner $RepoOwner -RepoName $RepoName `
                -IssueNumber $IssueNumber -LabelsToRemove $willRemoveLabel -AuthToken $token
            LogNotice "updateSdkSuppressionsLabels: PR: $("pr.html_url") Remove label: $($removeSdkSuppressionsLabels -join ", " )"
        }
        else {
            LogNotice "updateSdkSuppressionsLabels: PR: $("pr.html_url") No Remove label"
        }
    }
    else {
        $addSdkSuppressionsLabels = [System.Collections.ArrayList]::new()
        foreach ($sdkName in $sdkNames) {
            $sdkSuppressionsLabel = $sdkLabels[$sdkName]["breakingChangeSuppression"];
            if (-not ($presentLabels -contains $sdkSuppressionsLabel)) {
                [void]$addSdkSuppressionsLabels.Add($sdkSuppressionsLabel);
            }
        }
        if ($addSdkSuppressionsLabels.length -gt 0) {
            try {
                Add-GithubIssueLabels -RepoOwner $RepoOwner -RepoName $RepoName `
                    -IssueNumber $IssueNumber -Labels $addSdkSuppressionsLabels -AuthToken $AuthToken  | Out-Null
            }
            catch {
                LogError "Add-GithubIssueLabels failed with exception:`n$_"
                exit 1
            }
            LogNotice "updateSdkSuppressionsLabels: PR: $("$pr.html_url") add label: $($addSdkSuppressionsLabels -join ", " )"
        }
        else {
            LogNotice "updateSdkSuppressionsLabels: PR: $("pr.html_url") no add label"
        }
    }
}

$FilesChanges = Get-GitHubPullRequestChangeFiles -RepoOwner $baseOwner -RepoName $baseRepo `
    -PullRequestNumber $prNumber -AuthToken $GithubToken

$FilteredSuppressionFiles = $FilesChanges | Where-Object { $_.Split('/')[-1] -eq $SuppressionFileName }
if ($null -eq $FilteredSuppressionFiles) {
    LogError "No suppression file changes found in the pull request."
    exit 1
}
$SDKNames = Get-SDKNames -BaseRepoOwner $baseOwner -BaseRepoName $baseRepo -BaseRepoBranch $baseBranch `
    -HeadRepoOwner $headOwner -HeadRepoName $headRepo -HeadRepoBranch $headBranch`
    -IssueNumber $prNumber `
    -SuppressionFile $FilteredSuppressionFiles -AuthToken $GithubToken

if ($null -eq $SDKNames) {
    LogError "No SDKs changes found in the suppression file."
    exit 1
}
else {
    $PresentLabels = Get-GitHubIssueLabels -RepoOwner $baseOwner -repoName $baseRepo -IssueNumber $prNumber -AuthToken $GithubToken
    Update-Label -RepoOwner $baseOwner -repoName $baseRepo -IssueNumber $prNumber -AuthToken $GithubToken `
        -PresentLabels $PresentLabels -sdkNames $SDKNames -sdkLabels $sdkLabels
}
