[CmdletBinding()]
param (
  [switch]$IgnoreCoreFiles = $false,
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false,
  [switch]$DryRun = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$HeadCommitish = "HEAD"
)

Set-StrictMode -Version 3

. $PSScriptRoot/../common/scripts/logging.ps1
. $PSScriptRoot/ChangedFiles-Functions.ps1

$repoPath = Resolve-Path "$PSScriptRoot/../.."

$checkAllPath = ((Get-ChildItem "specification" -Directory).Name -replace '^', 'specification/') -replace '$', '/'
$checkedAll = $false

if ($CheckAll) {
  $changedFiles = $checkAllPath
  $checkedAll = $true
}
else {
  $changedFiles = @(Get-ChangedFiles -baseCommitish $BaseCommitish -headCommitish $HeadCommitish -diffFilter "")
  $coreChangedFiles = Get-ChangedCoreFiles $changedFiles

  if ($coreChangedFiles -and !$IgnoreCoreFiles) {
    Write-Verbose "Found changes to core eng or root files so checking all specs."
    $changedFiles = $checkAllPath
    $checkedAll = $true
  }
  else {
    $changedFiles = Get-ChangedFilesUnderSpecification $changedFiles
  }
}

# Extract specification/{org} folders from changed files
$orgFolders = @()
foreach ($file in $changedFiles) {
  if ($file -match 'specification\/([^\/]+)\/') {
    $orgFolder = "specification/$($matches[1])"
    $orgFolders += $orgFolder
  }
}

if ($orgFolders.Length) {
  $orgFolders = $orgFolders | Sort-Object -Unique
}

Write-Host "Checking $($orgFolders.Count) org folders for folder structure:"
foreach ($orgFolder in $orgFolders) {
  Write-Host "  $orgFolder"
}

# Skip folder-structure validation when checking all specs (TypeSpec Validation - All mode)
if ($checkedAll) {
  Write-Host "Skipping folder structure validation in CheckAll mode"
  exit 0
}

$foldersWithFailures = @()
$context = @{ checkingAllSpecs = $checkedAll } | ConvertTo-Json -Compress

if ($orgFolders) {
  foreach ($orgFolder in $orgFolders) {
    LogGroupStart "Validating folder structure: $orgFolder"

    if ($DryRun) {
      LogGroupEnd
      continue
    }

    LogInfo "npm exec --no -- folder-structure $orgFolder ""$context"""
    npm exec --no -- folder-structure $orgFolder "$context" 2>&1 | Write-Host
    if ($LASTEXITCODE) {
      $foldersWithFailures += $orgFolder
      $errorString = "Folder Structure Validation failed for $orgFolder run the following command locally to validate."
      $errorString += "`n > npm ci"
      $errorString += "`n > npx folder-structure $orgFolder"
      $errorString += "`nFor more detailed docs see https://aka.ms/azsdk/specs/typespec-validation"
      LogError $errorString
    }
    
    if ($GitClean) {
      git restore .
      git clean -df
    }
    LogGroupEnd
  }
}
else {
  if ($CheckAll) {
    LogError "Folder Structure Validation - All did not validate any folders"
    LogJobFailure
    exit 1
  }
}

if ($foldersWithFailures.Count -gt 0) {
  LogInfo "Folder Structure Validation failed for some folders. To fix, run and address any errors:"
  LogInfo " > npm ci"
  foreach ($folder in $foldersWithFailures) {
    LogInfo " > npx folder-structure $folder"
  }
  LogInfo "For more detailed docs see https://aka.ms/azsdk/spec-dirs"
  LogJobFailure
  exit 1
}

exit 0
