#!/usr/bin/env pwsh

#Requires -Version 7.0
#Requires -PSEdition Core

param(
    [string]$InstallDirectory = '',
    [string]$RunDirectory = (Resolve-Path (Join-Path $PSScriptRoot .. .. ..)),
    [switch]$UpdatePathInProfile,
    [switch]$Run
)

$ErrorActionPreference = 'Stop'

$releaseVersion = 'v0.0.8-linux'
$repository     = 'chunyu3/typespec-authoring-doc'
$exeName        = 'azsdk'
$downloadUrl    = "https://github.com/$repository/releases/download/$releaseVersion/$exeName"

# Resolve install directory (default: ~/bin)
if (-not $InstallDirectory) {
    $InstallDirectory = Join-Path $HOME 'bin'
}

if (-not (Test-Path $InstallDirectory)) {
    New-Item -ItemType Directory -Path $InstallDirectory -Force | Out-Null
}

$destination = Join-Path $InstallDirectory $exeName

Write-Host "Downloading $exeName $releaseVersion from $downloadUrl ..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $destination

Write-Host "Installed $exeName to $destination"

if ($UpdatePathInProfile) {
    $profileFile = $PROFILE.CurrentUserAllHosts

    if (-not (Test-Path $profileFile)) {
        New-Item -ItemType File -Path $profileFile -Force | Out-Null
    }

    $exportLine = "`$env:PATH = `"$InstallDirectory`$([System.IO.Path]::PathSeparator)`$env:PATH`""
    $profileContent = Get-Content -Raw $profileFile -ErrorAction SilentlyContinue

    if ($profileContent -notlike "*$InstallDirectory*") {
        Add-Content -Path $profileFile -Value "`n# Added by download-azsdk.ps1`n$exportLine"
        Write-Host "Added $InstallDirectory to PATH in $profileFile"
    }
    else {
        Write-Host "$InstallDirectory is already present in $profileFile"
    }
}
else {
    Write-Warning "To add the tool to PATH for new shell sessions, re-run with -UpdatePathInProfile."
}


if ($Run) {
    $proc = Start-Process -PassThru -WorkingDirectory $RunDirectory -FilePath $destination -ArgumentList 'mcp' -NoNewWindow -Wait
    exit $proc.ExitCode
}
