param(
    [string]$FilePath = ".\API_CHANGES.md"
)

if (-not (Test-Path $FilePath)) {
    Write-Error "File not found: $FilePath"
    exit 1
}

Write-Host "`nAnalyzing API_CHANGES.md..." -ForegroundColor Cyan
Write-Host "Counting table rows as diff items...`n" -ForegroundColor Cyan

$lines = Get-Content $FilePath
$totalDiffItems = 0
$changedPathsCount = 0
$swaggerChangesCount = 0
$modifiedValuesCount = 0

$inChangedPaths = $false
$inSwaggerChanges = $false
$inModifiedValues = $false
$categories = @{}
$currentCategory = ""

foreach ($line in $lines) {
    if ($line -match "^## Changed Paths") {
        $inChangedPaths = $true
        $inSwaggerChanges = $false
        $inModifiedValues = $false
        continue
    }
    elseif ($line -match "^## Swagger Changes") {
        $inChangedPaths = $false
        $inSwaggerChanges = $true
        $inModifiedValues = $false
        continue
    }
    elseif ($line -match "^## Modified Values") {
        $inChangedPaths = $false
        $inSwaggerChanges = $false
        $inModifiedValues = $true
        continue
    }
    
    if ($inSwaggerChanges -and $line -match "^### Changes for ``(.+)``") {
        $currentCategory = $Matches[1]
        if (-not $categories.ContainsKey($currentCategory)) {
            $categories[$currentCategory] = 0
        }
    }
    
    if ($inChangedPaths -and $line -match "^Path: ") {
        $totalDiffItems++
        $changedPathsCount++
        continue
    }
    
    if ($line -match "^\| ``?[^|]+``? \|") {
        if ($line -match "\| Path \| Change Type \|" -or 
            $line -match "\| Path \| Old Value \|") {
            continue
        }
        
        if ($line -match "^\|[\s\-:]+\|") {
            continue
        }
        
        $totalDiffItems++
        
        if ($inSwaggerChanges) {
            $swaggerChangesCount++
            if ($currentCategory) {
                $categories[$currentCategory]++
            }
        }
        elseif ($inModifiedValues) {
            $modifiedValuesCount++
        }
    }
}

Write-Host "========================================"
Write-Host "  API_CHANGES.md Diff Items Count"
Write-Host "========================================`n"
Write-Host "Section Breakdown:"
Write-Host "  Changed Paths:    $changedPathsCount items"
Write-Host "  Swagger Changes:  $swaggerChangesCount items"
Write-Host "  Modified Values:  $modifiedValuesCount items"
Write-Host "`nTotal Diff Items:"
Write-Host "  $totalDiffItems individual diff items (table rows)`n"
Write-Host "========================================`n"

if ($categories.Count -gt 0) {
    Write-Host "Diff Items by Category:"
    Write-Host "----------------------`n"
    
    $categories.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object {
        $categoryName = $_.Key
        $count = $_.Value
        
        if ($categoryName.Length -gt 80) {
            $categoryName = $categoryName.Substring(0, 77) + "..."
        }
        
        Write-Host ("  {0,-85} : {1,3}" -f $categoryName, $count)
    }
    
    Write-Host ""
}

Write-Host "Summary:"
Write-Host "--------"
Write-Host "  Total Categories: $($categories.Count)"
if ($categories.Count -gt 0) {
    Write-Host "  Average items per category: $([math]::Round($swaggerChangesCount / $categories.Count, 2))"
}

Write-Host "`n"
return $totalDiffItems
