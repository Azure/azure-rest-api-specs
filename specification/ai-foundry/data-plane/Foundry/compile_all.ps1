# Script to compile main.tsp at the project root and all client.tsp files in the \src\sdk-* folders
$ErrorActionPreference = 'Stop'

$rootDir = $PSScriptRoot
if (-not $rootDir) {
    $rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}

Set-Location -Path $rootDir

Write-Host 'Compiling all sdk-* client TypeSpec files...'

Get-ChildItem -Path 'src' -Directory -Filter 'sdk-*' | ForEach-Object {
    $dirPath = $_.FullName
    $clientTspPath = Join-Path $dirPath 'client.tsp'

    if (Test-Path -Path $clientTspPath) {
        Write-Host ''
        Write-Host "[$dirPath] npx tsp compile client.tsp"

        Push-Location -Path $dirPath
        try {
            & npx tsp compile client.tsp
            if ($LASTEXITCODE -ne 0) {
                Write-Host ''
                Write-Host "Compile failed in $dirPath"
                exit 1
            }
        }
        finally {
            Pop-Location
        }
    }
}

Write-Host ''
Write-Host '[ROOT] npx tsp compile .'
& npx tsp compile .
if ($LASTEXITCODE -ne 0) {
    exit 1
}

Write-Host ''
Write-Host 'All compilations completed successfully.'
exit 0
