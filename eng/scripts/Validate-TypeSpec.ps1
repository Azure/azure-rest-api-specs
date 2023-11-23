[CmdletBinding()]
param (
  [switch]$CheckAll = $false,
  [switch]$GitClean = $false
)

. $PSScriptRoot/Logging-Functions.ps1

$typespecFolders = &"$PSScriptRoot/Get-TypeSpec-Folders.ps1" -CheckAll:$CheckAll

$typespecFoldersWithFailures = @()
if ($typespecFolders) {
  $typespecFolders = $typespecFolders.Split('',[System.StringSplitOptions]::RemoveEmptyEntries)
  foreach ($typespecFolder in $typespecFolders) {
    LogGroupStart "Validating $typespecFolder"
    LogInfo "npx --no tsv $typespecFolder"
    npx --no tsv $typespecFolder 2>&1 | Write-Host
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
