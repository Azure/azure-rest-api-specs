# Run from ResourceBuilder.Management directory
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Push-Location $ScriptDir
try {
    Write-Host "Running tsp format..." -ForegroundColor Cyan
    tsp format .
    if ($LASTEXITCODE -ne 0) { throw "tsp format" }

    Write-Host "Running tsp compile..." -ForegroundColor Cyan
    tsp compile .
    if ($LASTEXITCODE -ne 0) { throw "tsp compile" }

    Write-Host "Running npx prettier --write ." -ForegroundColor Cyan
    npx prettier --write .
    if ($LASTEXITCODE -ne 0) { throw "npx prettier --write ." }

    Write-Host "Running npx tsv ." -ForegroundColor Cyan
    npx tsv .
    if ($LASTEXITCODE -ne 0) { throw "npx tsv ." }

    Write-Host "Build completed successfully." -ForegroundColor Green
} catch {
    Write-Host "`nBUILD FAILED: The following command failed:" -ForegroundColor Red
    Write-Host "  $_" -ForegroundColor Red
    Write-Host "Fix the error above and run the script again.`n" -ForegroundColor Yellow
    exit 1
} finally {
    Pop-Location
}