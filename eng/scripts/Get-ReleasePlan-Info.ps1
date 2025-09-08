param(    
    [Parameter(Mandatory = $true)]
    $ReleasePlanWorkItemId
)

<#
.SYNOPSIS
Updates the pull request URL and status in the specified release plan work item for a given programming language.

.PARAMETER ReleasePlanWorkItemId
The ID of the release plan work item to update.

#>

Set-StrictMode -Version 3

. $PSScriptRoot/../common/scripts/Helpers/DevOps-WorkItem-Helpers.ps1


Write-Host "Getting release plan info for work item ID: $ReleasePlanWorkItemId"
$releasePlan = Get-ReleasePlan-Link $ReleasePlanWorkItemId
$releasePlanInfo = ""
if ($null -eq $releasePlan)
{
    Write-Host "Failed to retrieve the Release Plan work item or the release plan work item is not present with Id [$ReleasePlanWorkItemId]."
}
else
{
    $releasePlanLink = $releasePlan["Custom.ReleasePlanLink"]
    $title = $releasePlan["System.Title"]
    $submittedBy = $releasePlan["Custom.ReleasePlanSubmittedby"]
    $releasePlanInfo = "`n`n## Release plan details`nTitle: $title`nLink: [$releasePlanLink]($releasePlanLink)`nSubmitted by: $submittedBy"
}
return $releasePlanInfo