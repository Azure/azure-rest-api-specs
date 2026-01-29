# Test script for Private.ApplicationMigration RP API versions
# Replace variables with your actual values

$subscriptionId = "YOUR_SUBSCRIPTION_ID"
$resourceGroupName = "YOUR_TEST_RG"
$discoveryHubName = "test-discovery-hub"
$location = "westus2"
$apiVersion = "2026-01-01-preview"

# Get access token
$token = (az account get-access-token --query accessToken -o tsv)

# Test 1: List Operations
Write-Host "Testing Operations List..."
$operationsUrl = "https://management.azure.com/providers/Private.ApplicationMigration/operations?api-version=$apiVersion"
$response = Invoke-RestMethod -Uri $operationsUrl -Method GET -Headers @{Authorization="Bearer $token"}
Write-Host "Operations available: $($response.value.Count)"

# Test 2: Create DiscoveryHub
Write-Host "Testing DiscoveryHub Creation..."
$createUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Private.ApplicationMigration/discoveryHubs/$discoveryHubName" + "?api-version=$apiVersion"
$body = @{
    location = $location
    properties = @{
        projectId = "test-project-123"
        appDiscovery = @{
            optOut = $false
            status = "NotStarted"
        }
    }
} | ConvertTo-Json -Depth 3

try {
    $response = Invoke-RestMethod -Uri $createUrl -Method PUT -Body $body -ContentType "application/json" -Headers @{Authorization="Bearer $token"}
    Write-Host "DiscoveryHub created successfully: $($response.name)"
} catch {
    Write-Error "Failed to create DiscoveryHub: $_"
}

# Test 3: Get DiscoveryHub
Write-Host "Testing DiscoveryHub Get..."
try {
    $response = Invoke-RestMethod -Uri $createUrl -Method GET -Headers @{Authorization="Bearer $token"}
    Write-Host "DiscoveryHub retrieved: $($response.properties.provisioningState)"
} catch {
    Write-Error "Failed to get DiscoveryHub: $_"
}

# Test 4: Test new autoDiscoverApplications action
Write-Host "Testing autoDiscoverApplications action..."
$actionUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Private.ApplicationMigration/discoveryHubs/$discoveryHubName/autoDiscoverApplications?api-version=$apiVersion"
$actionBody = @{
    masterSiteId = "test-site-123"
    inventoryCount = 10
    forceDiscover = $false
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $actionUrl -Method POST -Body $actionBody -ContentType "application/json" -Headers @{Authorization="Bearer $token"}
    Write-Host "autoDiscoverApplications completed successfully"
} catch {
    Write-Error "Failed autoDiscoverApplications action: $_"
}

Write-Host "All tests completed!"