[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false,
  [switch]$DryRun = $false,
  [string]$BaseCommitish = "HEAD^",
  [string]$TargetCommitish = "HEAD"
)

. $PSScriptRoot/Logging-Functions.ps1
. $PSScriptRoot/Suppressions-Functions.ps1

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" -BaseCommitish:$BaseCommitish -TargetCommitish:$TargetCommitish -CheckAll:$CheckAll

$typespecFoldersWithFailures = @()
if ($typespecFolders) {
  $typespecFolders = $typespecFolders.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)
  foreach ($typespecFolder in $typespecFolders) {
    LogGroupStart "Validating $typespecFolder"

    if ($CheckAll) {
      $suppression = Get-Suppression "TypeSpecValidationAll" $typespecFolder
      if ($suppression) {
        $reason = $suppression["reason"] ?? "<no reason specified>"
        LogInfo "Suppressed: $reason"
        LogGroupEnd
        continue
      }
    }

    LogInfo "npm exec --no -- tsv $typespecFolder"

    if ($DryRun) {
      LogGroupEnd
      continue
    }

    npm exec --no -- tsv $typespecFolder 2>&1 | Write-Host
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
} else {
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
