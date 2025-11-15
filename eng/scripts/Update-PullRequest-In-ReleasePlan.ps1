param(    
    [Parameter(Mandatory = $true)]
    $ReleasePlanWorkItemId,
    [Parameter(Mandatory = $true)]
    $PullRequestUrl,
    [Parameter(Mandatory = $true)]
    $Status,
    [Parameter(Mandatory = $true)]
    $SdkRepoName
)

<#
.SYNOPSIS
Updates the pull request URL and status in the specified release plan work item for a given programming language.

.PARAMETER ReleasePlanWorkItemId
The ID of the release plan work item to update.

.PARAMETER PullRequestUrl
The URL of the pull request to set in the release plan.

.PARAMETER Status
The status of the pull request.

.PARAMETER SdkRepoName
The name of the repository associated with the pull request.

#>

Set-StrictMode -Version 3
. $PSScriptRoot/../common/scripts/Helpers/DevOps-WorkItem-Helpers.ps1

$languageName = $SdkRepoName.replace('azure-sdk-for-', '')
Write-Host "Updating pull request [$PullRequestUrl] in release plan [$ReleasePlanWorkItemId] for language [$languageName]"
Update-PullRequestInReleasePlan $ReleasePlanWorkItemId $PullRequestUrl $Status $languageName
Write-Host "Updated pull request in release plan"