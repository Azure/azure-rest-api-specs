[CmdletBinding()]
param (
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/Logging-Functions.ps1

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$pathsWithErrors = @()

$filesToCheck = @(Get-ChangedSwaggerFiles)
if (!$filesToCheck) {
    LogInfo "No specification files found to check."
}
else {
    foreach ($file in $filesToCheck) {
        LogInfo "Checking $repoPath/$file"

        # ToDo: If the swagger file is in a "new service" (defined as
        # "not having a API version in a stable folder in public/main"),
        # and the swagger does not contain "x-typespec-generated", the
        # path is in error.

        # npx --no -- prettier --check $repoPath/$file --log-level warn
        # if ($LASTEXITCODE) {
        #     $pathsWithErrors += $file
        # }
    }
}

if ($pathsWithErrors.Count -gt 0)
{
  # DevOps only adds the first 4 errors to the github checks list so lets always add the generic one first
  # and then as many of the individual ones as can be found afterwards
  LogError "New specs must use TypeSpec.  For more detailed docs see https://aka.ms/azsdk/specs/typespec-requirement"
  LogJobFailure

  foreach ($path in $pathsWithErrors)
  {
    LogErrorForFile $path "New spec is not using TypeSpec."
  }
  exit 1
}

exit 0
