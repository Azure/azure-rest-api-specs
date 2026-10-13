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

$releasePlanInfoUnavailableMessage = "Release plan information is not available. Create a release plan and link SDK pull request to the release plan. Refer aka.ms/azsdk/releaseplan-dashboard for more info."
$releasePlanInfo = $releasePlanInfoUnavailableMessage

if (([string]::IsNullOrWhiteSpace("$ReleasePlanWorkItemId")) -or ($ReleasePlanWorkItemId -eq 0))
{
    Write-Host "Release plan information is not available for work item ID: $ReleasePlanWorkItemId"
    Write-Output $releasePlanInfo
    return
}


Write-Host "Getting release plan info for work item ID: $ReleasePlanWorkItemId"
$releasePlan = Get-ReleasePlan-Link $ReleasePlanWorkItemId
if ($null -eq $releasePlan)
{
    Write-Host "Failed to retrieve the Release Plan work item or the release plan work item is not present with Id [$ReleasePlanWorkItemId]."
}
else
{
    $releasePlanId = $releasePlan["Custom.ReleasePlanID"]
    if ([string]::IsNullOrWhiteSpace("$releasePlanId") -or ($releasePlanId -eq 0))
    {
        Write-Host "Release plan ID is empty or 0 for work item ID: $ReleasePlanWorkItemId"
    }
    else
    {
        $releasePlanLink = "https://azsdk-releaseplan-dashboard-hveph5aqhhcfhtgu.westus-01.azurewebsites.net/?releaseplan=" + $releasePlanId
        $submittedBy = $releasePlan["Custom.ReleasePlanSubmittedby"]
        $releasePlanInfo = "**Release plan link:** [$releasePlanLink]($releasePlanLink) **Submitted by**: $submittedBy"
    }
}
Write-Output $releasePlanInfo