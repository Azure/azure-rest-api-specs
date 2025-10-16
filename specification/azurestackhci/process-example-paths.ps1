# Script to process example paths
# - Check if path exists, if yes, no-op
# - If path doesn't exist, create directory structure
# - Try to find path without "StackHCI" component
# - If found, move from non-StackHCI path to StackHCI path
# - Track warnings for paths where source doesn't exist

param(
    [string]$InputFile = "example-paths-list.txt"
)

# Initialize tracking variables
$warnings = @()
$processed = 0
$existed = 0
$created = 0
$moved = 0
$notFound = 0

Write-Host "Starting path processing..." -ForegroundColor Cyan
Write-Host "Reading paths from: $InputFile" -ForegroundColor Cyan
Write-Host ""

# Read all lines from the file
$paths = Get-Content -Path $InputFile | Where-Object { $_.Trim() -ne "" }

foreach ($path in $paths) {
    $processed++
    $path = $path.Trim()
    
    Write-Host "[$processed/$($paths.Count)] Processing: $path" -ForegroundColor Gray
    
    # Check if path already exists
    if (Test-Path -Path $path) {
        Write-Host "  ✓ Path exists, no action needed" -ForegroundColor Green
        $existed++
        continue
    }
    
    # Path doesn't exist - create directory structure
    $directory = Split-Path -Path $path -Parent
    if ($directory -and -not (Test-Path -Path $directory)) {
        Write-Host "  → Creating directory: $directory" -ForegroundColor Yellow
        New-Item -Path $directory -ItemType Directory -Force | Out-Null
        $created++
    }
    
    # Try to find the path without "StackHCI" folder
    # Only remove the "\StackHCI\" folder from the path (between Microsoft.AzureStackHCI and preview/stable)
    $pathWithoutStackHCI = $path -replace "\\StackHCI\\", "\"
    
    # Check if the modified path exists
    if ($pathWithoutStackHCI -ne $path -and (Test-Path -Path $pathWithoutStackHCI)) {
        Write-Host "  → Found source without StackHCI: $pathWithoutStackHCI" -ForegroundColor Yellow
        Write-Host "  → Moving to: $path" -ForegroundColor Yellow
        
        try {
            # Ensure destination directory exists
            $destDir = Split-Path -Path $path -Parent
            if ($destDir -and -not (Test-Path -Path $destDir)) {
                New-Item -Path $destDir -ItemType Directory -Force | Out-Null
            }
            
            # Move the file
            Move-Item -Path $pathWithoutStackHCI -Destination $path -Force
            Write-Host "  ✓ Successfully moved file" -ForegroundColor Green
            $moved++
        }
        catch {
            Write-Host "  ✗ Error moving file: $_" -ForegroundColor Red
            $warnings += [PSCustomObject]@{
                OriginalPath = $path
                SourcePath = $pathWithoutStackHCI
                Issue = "Move failed: $_"
            }
            $notFound++
        }
    }
    else {
        # Source without StackHCI doesn't exist
        if ($pathWithoutStackHCI -ne $path) {
            Write-Host "  ✗ Source path not found: $pathWithoutStackHCI" -ForegroundColor Red
            $warnings += [PSCustomObject]@{
                OriginalPath = $path
                SourcePath = $pathWithoutStackHCI
                Issue = "Source file does not exist"
            }
        }
        else {
            Write-Host "  ✗ No StackHCI component found in path" -ForegroundColor Red
            $warnings += [PSCustomObject]@{
                OriginalPath = $path
                SourcePath = "N/A - No StackHCI in path"
                Issue = "Path does not contain StackHCI component"
            }
        }
        $notFound++
    }
    
    Write-Host ""
}

# Display summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PROCESSING COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:" -ForegroundColor White
Write-Host "  Total paths processed: $processed" -ForegroundColor White
Write-Host "  Already existed: $existed" -ForegroundColor Green
Write-Host "  Directories created: $created" -ForegroundColor Yellow
Write-Host "  Files moved: $moved" -ForegroundColor Green
Write-Host "  Not found/Failed: $notFound" -ForegroundColor Red
Write-Host ""

# Display warnings report
if ($warnings.Count -gt 0) {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "WARNINGS REPORT ($($warnings.Count) issues)" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    
    foreach ($warning in $warnings) {
        Write-Host "Original Path: $($warning.OriginalPath)" -ForegroundColor Yellow
        Write-Host "Source Path:   $($warning.SourcePath)" -ForegroundColor Yellow
        Write-Host "Issue:         $($warning.Issue)" -ForegroundColor Red
        Write-Host ""
    }
    
    # Export warnings to CSV
    $warningsFile = "path-processing-warnings.csv"
    $warnings | Export-Csv -Path $warningsFile -NoTypeInformation -Encoding UTF8
    Write-Host "Warnings have been saved to: $warningsFile" -ForegroundColor Yellow
    Write-Host ""
}
else {
    Write-Host "No warnings - all paths processed successfully!" -ForegroundColor Green
    Write-Host ""
}

Write-Host "Script execution completed." -ForegroundColor Cyan
