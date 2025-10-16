# Script to copy Operations_List.json files to version-specific folders
# Reads version folders from extra-operations.txt and copies files if destination exists

$baseDir = "C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci"
$versionsFile = Join-Path $baseDir "extra-operations.txt"
$sourceBase = Join-Path $baseDir "Operations.Management\examples"
$destBase = Join-Path $baseDir "AzureStackHCI.StackHCIVM.Management\examples"

# Check if the versions file exists
if (-not (Test-Path $versionsFile)) {
    Write-Error "File not found: $versionsFile"
    exit 1
}

# Read all version folder names from the file
$versions = Get-Content $versionsFile | Where-Object { $_.Trim() -ne "" }

Write-Host "Found $($versions.Count) version folders in extra-operations.txt"
Write-Host ""

$copiedCount = 0
$skippedCount = 0

foreach ($version in $versions) {
    $version = $version.Trim()
    
    # Construct source and destination paths
    $sourcePath = Join-Path $sourceBase "$version\Operations_List.json"
    $destDir = Join-Path $destBase $version
    $destPath = Join-Path $destDir "Operations_List.json"
    
    Write-Host "Processing version: $version"
    
    # Check if source file exists
    if (-not (Test-Path $sourcePath)) {
        Write-Warning "  Source file not found: $sourcePath"
        $skippedCount++
        continue
    }
    
    # Check if destination directory exists
    if (-not (Test-Path $destDir)) {
        Write-Warning "  Destination directory does not exist: $destDir"
        $skippedCount++
        continue
    }
    
    # Copy the file
    try {
        Copy-Item -Path $sourcePath -Destination $destPath -Force
        Write-Host "  ✓ Copied to: $destPath" -ForegroundColor Green
        $copiedCount++
    }
    catch {
        Write-Error "  Failed to copy file: $_"
        $skippedCount++
    }
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Files copied: $copiedCount" -ForegroundColor Green
Write-Host "  Files skipped: $skippedCount" -ForegroundColor Yellow
