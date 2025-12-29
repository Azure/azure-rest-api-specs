[CmdletBinding()]
param (
  [switch]$IgnoreCoreFiles = $false,
  [switch]$CheckAll = $false,
  [int]$Shard = 0,
  [int]$TotalShards = 1,
  [switch]$GitClean = $false,
  [switch]$DryRun = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$HeadCommitish = "HEAD"
)

if ($TotalShards -gt 0 -and $Shard -ge $TotalShards) { 
  throw "Shard ($Shard) must be less than TotalShards ($TotalShards)"
}

. $PSScriptRoot/../common/scripts/logging.ps1
. $PSScriptRoot/Suppressions-Functions.ps1
. $PSScriptRoot/Array-Functions.ps1

$typespecFolders, $checkingAllSpecs = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" `
  -BaseCommitish:$BaseCommitish `
  -HeadCommitish:$HeadCommitish `
  -CheckAll:$CheckAll `
  -IgnoreCoreFiles:$IgnoreCoreFiles

if ($TotalShards -gt 1 -and $TotalShards -le $typespecFolders.Count) { 
  $typespecFolders = shardArray $typespecFolders $Shard $TotalShards
}

Write-Host "Checking $($typespecFolders.Count) spec folders:"
foreach ($typespecFolder in $typespecFolders) {
  Write-Host "  $typespecFolder"
}

$typespecFoldersWithFailures = @()
if ($typespecFolders) {
  $typespecFolders = $typespecFolders.Split('', [System.StringSplitOptions]::RemoveEmptyEntries)
  foreach ($typespecFolder in $typespecFolders) {
    LogGroupStart "Validating $typespecFolder"

    if ($checkingAllSpecs) {
      $suppression = Get-Suppression "TypeSpecValidationAll" $typespecFolder
      if ($suppression) {
        $reason = $suppression["reason"] ?? "<no reason specified>"
        LogInfo "Suppressed: $reason"
        LogGroupEnd
        continue
      }
    }

    # Example: '{"checkingAllSpecs"=true}'
    $context = @{ checkingAllSpecs = $checkingAllSpecs } | ConvertTo-Json -Compress

    LogInfo "npm exec --no -- folder-structure --validate $typespecFolder ""$context"""
    LogInfo "npm exec --no -- tsv $typespecFolder ""$context"""

    if ($DryRun) {
      LogGroupEnd
      continue
    }

    npm exec --no -- folder-structure --validate $typespecFolder "$context" 2>&1 | Write-Host
    if ($LASTEXITCODE) {
      $typespecFoldersWithFailures += $typespecFolder
      $errorString = "Folder structure validation failed for folder $typespecFolder.\n"
      $errorString += "Run the following commands locally to validate."
      $errorString += "`n > npm ci"
      $errorString += "`n > npx folder-structure --validate $typespecFolder"
      $errorString += "`nFor more detailed docs see https://aka.ms/azsdk/specs/spec-validation"
      LogError $errorString
    }

    npm exec --no -- tsv $typespecFolder "$context" 2>&1 | Write-Host
    if ($LASTEXITCODE) {
      $typespecFoldersWithFailures += $typespecFolder
      $errorString = "Spec validation (tsv) failed for project $typespecFolder.\n"
      $errorString += "Run the following commands locally to validate."
      $errorString += "`n > npm ci"
      $errorString += "`n > npx tsv $typespecFolder"
      $errorString += "`nFor more detailed docs see https://aka.ms/azsdk/specs/spec-validation"
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
    LogError "Spec Validation - All did not validate any specs"
    LogJobFailure
    exit 1
  }
}

if ($typespecFoldersWithFailures.Count -gt 0) {
  $typespecFoldersWithFailures = $typespecFoldersWithFailures | Sort-Object -Unique
  LogInfo "Spec Validation failed for some folders; to fix, run and address any errors:"
  LogInfo " > npm ci"
  foreach ($typespecFolderWithFailure in $typespecFoldersWithFailures) {
    LogInfo " > npx folder-structure --validate $typespecFolderWithFailure"
    LogInfo " > npx tsv $typespecFolderWithFailure"
  }
  LogInfo "For more detailed docs see https://aka.ms/azsdk/specs/spec-validation"
  LogJobFailure
  exit 1
}

exit 0
