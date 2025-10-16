# Script to sort file paths by reverse of pathname
$inputFile = "all-paths.txt"
$outputFile = "all-paths-sorted-reverse.txt"

Write-Host "Reading paths from $inputFile..." -ForegroundColor Cyan

# Read all paths from the file
$paths = Get-Content $inputFile

Write-Host "Total paths read: $($paths.Count)" -ForegroundColor Cyan
Write-Host "Sorting paths by reverse of pathname..." -ForegroundColor Yellow

# Remove duplicates first
$uniquePaths = $paths | Select-Object -Unique

Write-Host "Unique paths after removing duplicates: $($uniquePaths.Count)" -ForegroundColor Yellow

# Sort paths by the reverse of the entire path string
$sortedPaths = $uniquePaths | Sort-Object {
    # Reverse the entire path string for sorting
    $chars = $_.ToCharArray()
    [Array]::Reverse($chars)
    -join $chars
}

Write-Host "Writing sorted paths to $outputFile..." -ForegroundColor Green

# Write sorted paths to output file
$sortedPaths | Set-Content $outputFile

Write-Host ""
Write-Host "Operation completed!" -ForegroundColor Cyan
Write-Host "Sorted file created: $outputFile" -ForegroundColor Green
Write-Host "Total paths written: $($sortedPaths.Count)" -ForegroundColor Green