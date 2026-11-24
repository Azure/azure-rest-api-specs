[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    # Invoke-Query inserts the WIQL into a JSON string. The config path uses repo-relative forward slashes.
    [ValidatePattern('^[^"\\\x00-\x1f]+$')]
    [string]$TypeSpecConfigPath,
    [Parameter(Mandatory)]
    [string]$SdkRepoName,
    [ValidateRange(0, [int]::MaxValue)]
    [int]$ReleasePlanWorkItemId = 0
)

Set-StrictMode -Version 4
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot .. common scripts Helpers DevOps-WorkItem-Helpers.ps1)

$language = $SdkRepoName -replace '^azure-sdk-for-', '' -replace '-pr$', ''
$devOpsLanguage = Get-LanguageDevOpsName $language
if (-not $devOpsLanguage) {
    Write-Host "Release plans do not track SDK pull requests for '$SdkRepoName'."
    return
}

$specRepoRoot = [IO.Path]::GetFullPath('../..', $PSScriptRoot)
$configDirectory = [IO.Path]::GetDirectoryName([IO.Path]::GetFullPath($TypeSpecConfigPath, $specRepoRoot))
$typeSpecProjectPath = [IO.Path]::GetRelativePath($specRepoRoot, $configDirectory).Replace('\', '/')
$escapedProjectPath = $typeSpecProjectPath.Replace("'", "''")
$pullRequestField = "Custom.SDKPullRequestFor$devOpsLanguage"
$releaseStatusField = "Custom.ReleaseStatusFor$devOpsLanguage"
$query = "SELECT [System.Id] FROM WorkItems WHERE [System.TeamProject] = 'Release'"
$query += " AND [System.WorkItemType] = 'Release Plan' AND [Custom.ApiSpecProjectPath] = '$escapedProjectPath'"
$query += " AND [System.State] NOT IN ('Closed','Duplicate','Abandoned','Finished')"
$query += " AND [System.Tags] NOT CONTAINS 'Release Planner App Test'"

$activeReleasePlans = Invoke-Query -fields @($pullRequestField, $releaseStatusField) -wiql $query
$selectedReleasePlan = $activeReleasePlans | Where-Object { $_.id -eq $ReleasePlanWorkItemId }
if ($selectedReleasePlan -and -not [string]::IsNullOrWhiteSpace($selectedReleasePlan.fields[$pullRequestField])) {
    Write-Host "Release plan work item $ReleasePlanWorkItemId already has a $devOpsLanguage SDK pull request. Allowing regeneration."
    return
}

foreach ($releasePlan in $activeReleasePlans) {
    if ($releasePlan.id -ne $ReleasePlanWorkItemId -and
        -not [string]::IsNullOrWhiteSpace($releasePlan.fields[$pullRequestField]) -and
        $releasePlan.fields[$releaseStatusField] -ne 'Released') {
        throw "SDK generation for '$typeSpecProjectPath' is blocked because active release plan work item $($releasePlan.id) already has an unreleased $devOpsLanguage SDK pull request. Complete or abandon that plan before generating for a different plan. See https://aka.ms/azsdk/releaseplan-dashboard."
    }
}
