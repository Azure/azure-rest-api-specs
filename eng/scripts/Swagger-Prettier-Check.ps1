[CmdletBinding()]
param (
  [switch]$CheckAll = $false
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/../common/scripts/logging.ps1

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$pathsWithErrors = @()

if ($CheckAll) {
  LogInfo "npm exec --no -- prettier --check $repoPath/specification/**/*.json --log-level debug"
  npm exec --no -- prettier --check $repoPath/specification/**/*.json --log-level debug
  if ($LASTEXITCODE) {
    $pathsWithErrors += "$repoPath/specification/**/*.json"
  }
}
else 
{
  $filesToCheck = @(Get-ChangedSwaggerFiles)
  if (!$filesToCheck) {
    LogInfo "No specification files found to check."
  }
  else {
    foreach ($file in $filesToCheck) {
      LogInfo "npm exec --no -- prettier --check $repoPath/$file --log-level debug"
      npm exec --no -- prettier --check $repoPath/$file --log-level debug
      if ($LASTEXITCODE) {
        $pathsWithErrors += $file
      }
    }
  }
}

if ($pathsWithErrors.Count -gt 0)
{
  # DevOps only adds the first 4 errors to the github checks list so lets always add the generic one first and then as many of the individual ones as can be found afterwards
  LogError "Code style issues found in the above file(s), please run prettier to update. For more detailed docs see https://aka.ms/azsdk/specs/prettier"
  LogJobFailure

  foreach ($path in $pathsWithErrors)
  {
    $errorString = "Code style issues found, please run prettier."
    $errorString += "`n > npm install"
    $errorString += "`n > npx prettier --write $path"
    LogErrorForFile $path $errorString
  }
  exit 1
}

exit 0
