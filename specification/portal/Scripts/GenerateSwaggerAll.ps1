# This script generates Swagger for all Management APIs under portal services.
param(
    [bool] $runNpmCi = $false
    )
if( $runNpmCi) {
    Write-Host "Running npm ci"
    & npm ci
}

# Generate Swagger for all Management APIs
$rootPath = Join-Path -Path $PSScriptRoot -ChildPath ".." -Resolve

Get-ChildItem $rootPath -Filter "*.Management" | ForEach-Object {
    Write-Host "Generating Swagger for $($_.Name)"
    npx tsv (Join-Path $rootPath $_.Name)
}