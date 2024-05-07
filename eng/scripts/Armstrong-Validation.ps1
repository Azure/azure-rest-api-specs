[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [string] $BaseCommitish = "HEAD^",
  [Parameter(Position = 1)]
  [string] $TargetCommitish = "HEAD"
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/Logging-Functions.ps1

function Get-Suppression {
  param (
    [string]$fileInSpecFolder
  )

  # -NoEnumerate to prevent single-element arrays from being collapsed to a single object
  # -AsHashtable is closer to raw JSON than PSCustomObject
  $suppressions = npx get-suppressions ArmstrongValidation $fileInSpecFolder | ConvertFrom-Json -NoEnumerate -AsHashtable

  if ($LASTEXITCODE -ne 0) {
      LogError "Failure running 'npm exec get-suppressions'"
      LogJobFailure
      exit 1
  }

  return $suppressions ? $suppressions[0] : $null
}

function Get-ChangedTerraformFiles($changedFiles = (Get-ChangedFiles)) {
  $changedFiles = Get-ChangedFilesUnderSpecification $changedFiles

  $changedSwaggerFiles = $changedFiles.Where({ 
      # since `git diff` returns paths with `/`, use the following code to match the `main.tf`
      $_.EndsWith("/main.tf")
    })
    
  return $changedSwaggerFiles
}

$script:armstrongInstalled = $false
function Ensure-Armstrong-Installed {
  if ($script:armstrongInstalled) {
    # If already checked once in this script, don't log anything further
    return;
  }

  $script:armstrongInstalled = $true

  # install golang
  if (!(Get-Command "go" -ErrorAction SilentlyContinue)) {
    LogError "Golang is not installed"
    exit 1
  }

  # install armstrong
  if (!(Get-Command "armstrong" -ErrorAction SilentlyContinue)) {
    LogError "Armstrong is not installed"
    exit 1
  }
}

function Validate-Terraform-Error($repoPath, $filePath) {
  $fileDirectory = (Split-Path -Parent $filePath)
  $outputDirectory = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
  $result = @()

  try {
    if (!(Test-Path -Path $outputDirectory)) {
      New-Item -Path $outputDirectory -ItemType Directory *> $null
      # run armstrong credscan
      $specPath = Join-Path -Path $repoPath -ChildPath "specification"
      LogInfo "armstrong credscan -working-dir $fileDirectory -swagger-repo $specPath -output-dir $outputDirectory"
      armstrong credscan -working-dir $fileDirectory -swagger-repo $specPath -output-dir $outputDirectory
    }
  
    # error reports are stored in a directory named armstrong_credscan_<timestamp>
    Get-ChildItem -Path $outputDirectory -Directory -Filter "armstrong_credscan_*" | ForEach-Object {
      $errorJsonPath = Join-Path -Path $_.FullName -ChildPath "errors.json"
      if (Test-Path -Path $errorJsonPath) {
        Get-Content -Path $errorJsonPath -Raw | ConvertFrom-Json | ForEach-Object {
          $properties = $_.PSObject.Properties
          $item = "Credential Error:"
          foreach ($property in $properties) {
            $item += "`n    $($property.Name): $($property.Value)" 
          }
          
          $result += $item
        }
      }
    }
  }
  finally {
    Remove-Item -Path $outputDirectory -Recurse -Force
  }

  return $result
}

# Check if the repository and target branch are the ones that need to do API Testing
$repositoryName = [Environment]::GetEnvironmentVariable("BUILD_REPOSITORY_NAME", [EnvironmentVariableTarget]::Process)
$targetBranchName = [Environment]::GetEnvironmentVariable("SYSTEM_PULLREQUEST_TARGETBRANCH", [EnvironmentVariableTarget]::Process)
LogInfo "Repository: $repositoryName"
LogInfo "Target branch: $targetBranchName"
if ($repositoryName -eq "Azure/azure-rest-api-specs" -and $targetBranchName -eq "ms-zhenhua/armstrong-validation") {
  $apiTestingError = "API Testing Warning:"
  $apiTestingError += "`n    The Pull Request against main branch may need to provide API Testing results. Please follow https://github.com/Azure/armstrong/blob/main/docs/guidance-for-api-test.md to complete the API Testing"
  # Though it is a warning, we still log it as error because warning log won't be shown in GitHub
  LogError $apiTestingError
}

$repoPath = Resolve-Path "$PSScriptRoot/../.."

$terraformErrors = @()

$filesToCheck = (Get-ChangedTerraformFiles (Get-ChangedFiles $BaseCommitish $TargetCommitish))

if (!$filesToCheck) {
  LogInfo "No Terraform files found to check"
}
else {
  foreach ($file in $filesToCheck) {
    LogInfo "Checking $file"

    $fullPath = (Join-Path $repoPath $file)

    $suppression = Get-Suppression $fullPath
    if ($suppression) {
      $reason = $suppression["reason"] ?? "<no reason specified>"

      LogInfo "  Suppressed: $reason"
      # Skip further checks, to avoid potential errors on files already suppressed
      continue
    }

    try {
      Ensure-Armstrong-Installed
      LogInfo "  Validating errors from Terraform file: $fullPath"
      $terraformErrors += (Validate-Terraform-Error $repoPath $fullPath)
    }
    catch {
      $terraformErrors += "  failed to validate errors from Terraform file: $file`n    $_"
    }
  }
}

if ($terraformErrors.Count -gt 0) {
  $errorString = "Armstrong Validation failed for some files. To fix, address the following errors. For false positive errors, please follow https://eng.ms/docs/products/azure-developer-experience/design/specs-pr-guides/pr-suppressions to suppress 'ArmstrongValidation'`n"
  $errorString += $terraformErrors -join "`n"
  LogError $errorString

  LogJobFailure
  exit 1
}

exit 0
