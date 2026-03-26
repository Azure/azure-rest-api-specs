$baseDir = $PSScriptRoot
$managementDirs = Get-ChildItem $baseDir -Directory | Where-Object { $_.Name -match '\.Management$' } | Sort-Object Name

$results = @()

foreach ($dir in $managementDirs) {
    Write-Host "Compiling $($dir.Name)..." -ForegroundColor Cyan
    Push-Location $dir.FullName
    $output = tsp compile . 2>&1
    $exitCode = $LASTEXITCODE
    Pop-Location

    if ($exitCode -eq 0) {
        Write-Host "  [OK]" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL]" -ForegroundColor Red
        Write-Host $output
    }

    $results += [PSCustomObject]@{
        Project  = $dir.Name
        Status   = if ($exitCode -eq 0) { "OK" } else { "FAIL" }
        ExitCode = $exitCode
    }
}

Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Yellow
$results | Format-Table -AutoSize

$failCount = ($results | Where-Object { $_.Status -eq "FAIL" }).Count
if ($failCount -gt 0) {
    Write-Host "$failCount project(s) failed." -ForegroundColor Red
    exit 1
} else {
    Write-Host "All $($results.Count) projects compiled successfully." -ForegroundColor Green
}
