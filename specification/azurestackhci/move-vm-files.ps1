# Script to move VM-related files to StackHCIVM directory
# Base paths
$baseSource = "C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI"
$baseTarget = "C:\pvt\azure-rest-api-specs-pr\specification\azurestackhci\resource-manager\Microsoft.AzureStackHCI\StackHCI"
$pathsFile = "stackhcipaths.md"

# Read all paths from the file
$paths = Get-Content $pathsFile

Write-Host "Starting file move operation..." -ForegroundColor Cyan
Write-Host "Total paths to process: $($paths.Count)" -ForegroundColor Cyan
Write-Host ""

$movedCount = 0
$skippedCount = 0

foreach ($relativePath in $paths) {
    # Construct full source and target paths
    $sourcePath = Join-Path $baseSource $relativePath
    $targetPath = Join-Path $baseTarget $relativePath
    
    # Check if source file exists
    if (Test-Path $sourcePath) {
        # Get the target directory
        $targetDir = Split-Path $targetPath -Parent
        
        # Create target directory if it doesn't exist
        if (-not (Test-Path $targetDir)) {
            Write-Host "Creating directory: $targetDir" -ForegroundColor Yellow
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        
        # Move the file with verbose output
        Write-Host "Moving: $sourcePath" -ForegroundColor Green
        Write-Host "     -> $targetPath" -ForegroundColor Green
        Move-Item -Path $sourcePath -Destination $targetPath -Force -Verbose
        $movedCount++
    }
    else {
        Write-Host "Skipped (not found): $sourcePath" -ForegroundColor Gray
        $skippedCount++
    }
}

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Cyan
Write-Host "Files moved: $movedCount" -ForegroundColor Green
Write-Host "Files skipped: $skippedCount" -ForegroundColor Yellow