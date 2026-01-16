# Fix validation errors in 2026-01-01-preview examples

$examplesPath = "resource-manager\PureStorage.Block\preview\2026-01-01-preview\examples"

Write-Host "Fixing Reservations examples - adding missing reservationName parameter..." -ForegroundColor Cyan

# Fix Reservations examples - replace incorrect parameter name with reservationName
$reservationsFiles = @(
    "Reservations_Get_MaximumSet_Gen.json",
    "Reservations_Update_MaximumSet_Gen.json",
    "Reservations_Delete_MaximumSet_Gen.json",
    "Reservations_GetBillingReport_MaximumSet_Gen.json",
    "Reservations_GetBillingStatus_MaximumSet_Gen.json",
    "Reservations_GetResourceLimits_MaximumSet_Gen.json"
)

foreach ($file in $reservationsFiles) {
    $filePath = Join-Path $examplesPath $file
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        $content = $content -replace '"reservation-01":', '"reservationName":'
        Set-Content -Path $filePath -Value $content -NoNewline
        Write-Host "  Fixed: $file" -ForegroundColor Green
    }
}

Write-Host "`nFixing AvsStorageContainers_ListByStoragePool - adding missing storagePoolName parameter..." -ForegroundColor Cyan

# Fix AvsStorageContainers_ListByStoragePool - incorrect parameter name
$file = "AvsStorageContainers_ListByStoragePool_MaximumSet_Gen.json"
$filePath = Join-Path $examplesPath $file
if (Test-Path $filePath) {
    $content = Get-Content $filePath -Raw
    $content = $content -replace '"storagepool-01":', '"storagePoolName":'
    Set-Content -Path $filePath -Value $content -NoNewline
    Write-Host "  Fixed: $file" -ForegroundColor Green
}

Write-Host "`nFixing AvsStorageContainers - removing additional property storageContainerName..." -ForegroundColor Cyan

# Fix AvsStorageContainers - remove storageContainerName property
$files = @(
    "AvsStorageContainers_ListByStoragePool_MaximumSet_Gen.json",
    "AvsStorageContainers_Get_MaximumSet_Gen.json"
)

foreach ($file in $files) {
    $filePath = Join-Path $examplesPath $file
    if (Test-Path $filePath) {
        $json = Get-Content $filePath -Raw | ConvertFrom-Json

        # Remove storageContainerName from response body
        if ($file -eq "AvsStorageContainers_ListByStoragePool_MaximumSet_Gen.json") {
            foreach ($item in $json.responses.'200'.body.value) {
                $item.PSObject.Properties.Remove('storageContainerName')
            }
        } else {
            $json.responses.'200'.body.PSObject.Properties.Remove('storageContainerName')
        }

        $json | ConvertTo-Json -Depth 100 | Set-Content -Path $filePath -NoNewline
        Write-Host "  Fixed: $file" -ForegroundColor Green
    }
}

Write-Host "`nFixing pattern validation errors - updating IDs to match hex pattern..." -ForegroundColor Cyan

# Fix pattern validation for volumeId and avsVmId - use hex pattern
$patternFixes = @{
    "AvsStorageContainerVolumes_Get_MaximumSet_Gen.json" = @{ "volumeId" = "a1b2c3d4-e5f6" }
    "AvsStorageContainerVolumes_Update_MaximumSet_Gen.json" = @{ "volumeId" = "a1b2c3d4-e5f6" }
    "AvsStorageContainerVolumes_Delete_MaximumSet_Gen.json" = @{ "volumeId" = "a1b2c3d4-e5f6" }
    "AvsVms_Get_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456" }
    "AvsVms_Update_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456" }
    "AvsVms_Delete_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456" }
    "AvsVmVolumes_ListByAvsVm_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456" }
    "AvsVmVolumes_Get_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456"; "volumeId" = "a1b2c3d4-e5f6" }
    "AvsVmVolumes_Update_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456"; "volumeId" = "a1b2c3d4-e5f6" }
    "AvsVmVolumes_Delete_MaximumSet_Gen.json" = @{ "avsVmId" = "abc123def456"; "volumeId" = "a1b2c3d4-e5f6" }
}

foreach ($file in $patternFixes.Keys) {
    $filePath = Join-Path $examplesPath $file
    if (Test-Path $filePath) {
        $json = Get-Content $filePath -Raw | ConvertFrom-Json

        foreach ($param in $patternFixes[$file].Keys) {
            $json.parameters.$param = $patternFixes[$file][$param]
        }

        $json | ConvertTo-Json -Depth 100 | Set-Content -Path $filePath -NoNewline
        Write-Host "  Fixed: $file" -ForegroundColor Green
    }
}

Write-Host "`nFixing Volumes examples - replacing volumeId with volumeName parameter..." -ForegroundColor Cyan

# Fix Volumes examples - replace volumeId with volumeName
$volumesFiles = @(
    "Volumes_Get_MaximumSet_Gen.json",
    "Volumes_Create_MaximumSet_Gen.json",
    "Volumes_Update_MaximumSet_Gen.json",
    "Volumes_Delete_MaximumSet_Gen.json"
)

foreach ($file in $volumesFiles) {
    $filePath = Join-Path $examplesPath $file
    if (Test-Path $filePath) {
        $json = Get-Content $filePath -Raw | ConvertFrom-Json

        # Replace volumeId with volumeName
        if ($json.parameters.volumeId) {
            $volumeName = $json.parameters.volumeId
            $json.parameters.PSObject.Properties.Remove('volumeId')
            $json.parameters | Add-Member -MemberType NoteProperty -Name 'volumeName' -Value $volumeName
        }

        $json | ConvertTo-Json -Depth 100 | Set-Content -Path $filePath -NoNewline
        Write-Host "  Fixed: $file" -ForegroundColor Green
    }
}

Write-Host "`nAll validation errors fixed!" -ForegroundColor Green
Write-Host "Run 'npx prettier --write `"$examplesPath/*.json`"' to format the files." -ForegroundColor Yellow
