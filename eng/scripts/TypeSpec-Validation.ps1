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

Write-Host "Checking $($typespecFolders.Count) TypeSpec folders:"
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

    LogInfo "npm exec --no -- tsv $typespecFolder ""$context"""

    if ($DryRun) {
      LogGroupEnd
      continue
    }

    npm exec --no -- tsv $typespecFolder "$context" 2>&1 | Write-Host
    if ($LASTEXITCODE) {
      $typespecFoldersWithFailures += $typespecFolder
      $errorString = "TypeSpec Validation failed for project $typespecFolder run the following command locally to validate."
      $errorString += "`n > npm ci"
      $errorString += "`n > npx tsv $typespecFolder"
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
    LogError "TypeSpec Validation - All did not validate any specs"
    LogJobFailure
    exit 1
  }
}

if ($typespecFoldersWithFailures.Count -gt 0) {
  LogInfo "TypeSpec Validation failed for some folder to fix run and address any errors:"
  LogInfo " > npm ci"
  foreach ($typespecFolderWithFailure in $typespecFoldersWithFailures) {
    LogInfo " > npx tsv $typespecFolderWithFailure"
  }
  LogInfo "For more detailed docs see https://aka.ms/azsdk/specs/typespec-validation"
  LogJobFailure
  exit 1
}

exit 0
