[CmdletBinding()]
param (
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/Logging-Functions.ps1

# Example: /home/username/azure-rest-api-specs
$repoPath = Resolve-Path "$PSScriptRoot/../.."

$pathsWithErrors = @()

$filesToCheck = @(Get-ChangedSwaggerFiles)
if (!$filesToCheck) {
    LogInfo "No specification files found to check."
}
else {
    # Example: specification/foo/resource-manager/Microsoft.Foo/stable/2023-01-01/Foo.json
    foreach ($file in $filesToCheck) {
        LogInfo "Checking $repoPath/$file"

        $jsonContent = Get-Content $repoPath/$file | ConvertFrom-Json -AsHashtable

        if ($null -ne $jsonContent["info"]["x-typespec-generated"]) {          
          LogInfo "  Contains '/info/x-typespec-generated', so spec is using TypeSpec."
          # Skip future checks for perf
          continue
        }
        else {
          LogInfo "  Does not contain '/info/x-typespec-generated', so spec is not using TypeSpec."
        }

        # Example: specification/foo/resource-manager/Microsoft.Foo
        # ToDo: Support Windows paths       
        $pathToServiceName = ($file -split '/')[0..3] -join '/'

        $urlToStableFolder = "https://github.com/Azure/azure-rest-api-specs/tree/main/$pathToServiceName/stable"

        $response = Invoke-WebRequest -Uri $urlToStableFolder -Method Head -SkipHttpErrorCheck
        if ($response.StatusCode -eq 404) {
          LogInfo "  Main does not contain path '$pathToServiceName/stable', so spec is new and must use TypeSpec."
          $pathsWithErrors += $file
        }
        elseif ($response.StatusCode -eq 200) {
          LogInfo "  Main contains path '$pathToServiceName/stable', so spec already exists and is NOT required to use TypeSpec."
        }
        else {
          LogError "  Unexpected response from ${urlToStableFolder}: ${response.StatusCode}"
        }
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
