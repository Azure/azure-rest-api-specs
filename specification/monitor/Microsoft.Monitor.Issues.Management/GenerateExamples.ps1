function ReplaceValueByKey($obj, $key, $value, $replacementsUsage, $skipTopLevel = $false)
{
    # Set all values with the specified key to the
    # specified value in the provided json object (recursively)
    foreach ($p in $obj.PSObject.Properties) {
        if ($false -eq $skipTopLevel -and $p.Name -eq $key) {
            # Update the value
            if ($null -eq $value) {
                # Remove the value if it should be replaced by null
                $obj.PSObject.Properties.Remove($p.Name)
                $p.Value = $null
            }
            else {
                # Replace the value
                $p.Value = $value
            }

            # Update usage dictionary
            if (-not $replacementsUsage.ContainsKey($key)) {
                $replacementsUsage[$key] = 0
            }
            $replacementsUsage[$key]++
        }
        else {
            if ($p.Value -is [System.Management.Automation.PSCustomObject]) {
                # Handled nested objects
                ReplaceValueByKey $p.Value $key $value $replacementsUsage
            }
            elseif ($p.Value -is [System.Object[]]) {
                # Handled nested arrays
                foreach ($item in $p.Value) {
                    ReplaceValueByKey $item $key $value $replacementsUsage
                }
            }
        }
    }
}

$apiType = "preview"
$apiVersion = "2025-05-03-preview"
$specFolder = "C:\Dev\azure-rest-api-specs\specification\monitor\Microsoft.Monitor.Issues.Management"
$swaggerFolder = "C:\Dev\azure-rest-api-specs\specification\monitor\resource-manager\Microsoft.Monitor\Issues\$apiType\$apiVersion"
$examplesPathInSpec = "$specFolder\examples\$apiVersion"
$examplesPathInSwagger = "$swaggerFolder\examples"
$swaggerPath = "$swaggerFolder\issues.json"

# Generate examples
Write-Output "Generating examples..."
if (-not (Test-Path $examplesPathInSwagger)) {
    New-Item -Path $examplesPathInSwagger -ItemType Directory -Force | Out-Null
}
Remove-Item "$examplesPathInSwagger\Issue_*" -Recurse -Force
oav generate-examples $swaggerPath --logLevel off

# Perform replacements in all example files
Write-Output "Processing examples..."
$subscriptionId = "aceaa046-91f0-492a-96dc-45e10a9183dc";
$issueName = "3f29e1b2b05f8371595dc761fed8e8b3";
$workspaceName = "myWorkspace";
$workspaceId = "/subscriptions/$subscriptionId/resourceGroups/rg1/providers/Microsoft.Monitor/accounts/$workspaceName";
$targetResourceId = "/subscriptions/$subscriptionId/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1";
$issueResourceId = if ($generationInfo.type -eq 'Microsoft.Monitor/accounts/issues') { "$workspaceId/issues/$issueName" } else { "$targetResourceId/providers/Microsoft.AlertsManagement/issues/$issueName" };
$alertId = "$targetResourceId/Microsoft.AlertsManagement/2ca4a194-dd28-4d38-92ca-df48f6a3efc3";
$investigationId = "76399e8c-f7b2-421e-a97b-40182cfa2743";
$replacements = @{
    "subscriptionId" = $subscriptionId;
    "resourceGroupName" = "rg1";
    "azureMonitorWorkspaceName" = $workspaceName;
    "issueName" = $issueName;
    "title" = "Alert fired on VM CPU";
    "severity" = "Sev2";
    "id" = "#if (`$file.Contains(`"Alerts_`")) { `"$alertId`" } elseif (`$file.Contains(`"Resources_`")) { `"$targetResourceId`" } elseif (`$file.Contains(`"Investigation`")) { `"$investigationId`" } else { `"$issueResourceId`" }";
    "investigations" = @();
    "type" = $generationInfo.Type;
    "name" = "$issueName";
    "investigationsCount" = 0;
    "impactTime" = "2024-12-13T02:45:33";
    "createdAt" = "2024-12-13T03:11:07";
    "addedAt" = "2024-12-13T03:11:07";
    "lastModifiedAt" = "2024-12-13T03:51:45";
    "completedAt" = "2024-12-13T03:24:40";
    "investigationId" = "b7341c85-b2c7-46ea-9a7f-784823b71fbc";
    "filter" = "";
    "nextLink" = "https://microsoft.com/a";
    "addedBy" = "171a811c-2a3a-4e6c-b742-f78f5f6ca51c";
    "createdBy" = "171a811c-2a3a-4e6c-b742-f78f5f6ca51c";    
    "lastModifiedBy" = "171a811c-2a3a-4e6c-b742-f78f5f6ca51c";    
    "addedByType" = "Manual";
    "createdByType" = "Manual";
    "lastModifiedByType" = "Manual";
    "result" = "";
}
$replacementsUsage = @{}
Get-ChildItem -Path "$swaggerFolder\examples" -Recurse -Filter "Issue_*.json" | ForEach-Object {    
    $file = $_.FullName
    $content = Get-Content $file | ConvertFrom-Json

    $replacements.GetEnumerator() | ForEach-Object {
        if ($null -ne $_.Value -and $_.Value.ToString().StartsWith("#")) {
            $value = Invoke-Expression $_.Value.Substring(1)
        }
        else {
            $value = $_.Value
        }
        ReplaceValueByKey $content $_.Key $value $replacementsUsage $true
    }

    if ($file.Contains("StartInvestigation")) {
        $content.parameters.body.investigationScopes[0].id = $targetResourceId
        $content.responses."200".body.runParameters.alerts[0].id = $alertId
        $content.responses."200".body.runParameters.resources[0].id = $targetResourceId
    }
    elseif ($file.Contains("FetchInvestigation")) {
        $content.responses."200".body.runParameters.alerts[0].id = $alertId
        $content.responses."200".body.runParameters.resources[0].id = $targetResourceId
    }

    $contentString = $content | ConvertTo-Json -Depth 20

    $contentString = $contentString -replace '"relevance": "None"', '"relevance": "Relevant"'

    $contentString > $file
}

foreach ($key in $replacements.Keys) {
    if (-not ($replacementsUsage.ContainsKey($key) -and $replacementsUsage[$key] -ne 0)) {
        Write-Output "Replacement key $key is not used"
    }
}

# Copy all examples from the swagger folder to the spec folder
Write-Output "Copying to spec folder..."
Get-ChildItem -Path "$examplesPathInSwagger\Issue_*" | ForEach-Object {
    $dest = Join-Path -Path $examplesPathInSpec -ChildPath $_.Name
    Copy-Item -Path $_.FullName -Destination $dest -Force
}

Write-Output "Done!"