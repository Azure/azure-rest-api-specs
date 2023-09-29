[CmdletBinding()]
param (
  [switch]$CheckAll = $false
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1

$exitCode = 0

$repoPath = Resolve-Path "$PSScriptRoot/../.."

if ($CheckAll) {
  Write-Host "npx --no -- prettier --check $repoPath/specification/**/*.json --log-level warn"
  npx --no -- prettier --check $repoPath/specification/**/*.json --log-level warn
  if ($LASTEXITCODE) {
    Write-Host "> npx prettier --write $repoPath/specification/**/*.json"
    $exitCode = 1
  }
}
else 
{
  $filesToCheck = @(Get-ChangedSwaggerFiles)
  if (!$filesToCheck) {
    Write-Host "No specification files found to check."
  }
  else {
    foreach ($file in $filesToCheck) {
      Write-Host "npx --no -- prettier --check $repoPath/$file --log-level warn"
      npx --no -- prettier --check $repoPath/$file --log-level warn
      if ($LASTEXITCODE) {
        Write-Host "> npx prettier --write $repoPath/$file"
        $exitCode = 1
      }
    }
  }
}

if ($exitCode) {
  Write-Host "Code style issues found in the above file(s), please run prettier to update. For more detailed docs see https://aka.ms/azsdk/specs/prettier."
}

exit $exitCode
