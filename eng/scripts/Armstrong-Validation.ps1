[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [string] $BaseCommitish = "HEAD^",

  [Parameter(Position = 1)]
  [string] $TargetCommitish = "HEAD"
)
Set-StrictMode -Version 3

. $PSScriptRoot/../common/scripts/Invoke-GitHubAPI.ps1
. $PSScriptRoot/../common/scripts/logging.ps1
. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/Suppressions-Functions.ps1

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

function Get-AddedSwaggerFiles() {
  $addedFiles = git -c core.quotepath=off diff --name-status --diff-filter=d $BaseCommitish $TargetCommitish | Where-Object { $_ -match 'A\s' } | ForEach-Object { $_.Substring(2).Trim() }
  $addedSwaggerFiles = $addedFiles.Where({ 
    $_.EndsWith(".json")
  })
    
  return $addedSwaggerFiles
}

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$filesToCheck = (Get-ChangedTerraformFiles (Get-ChangedFiles $BaseCommitish $TargetCommitish))

# Check whether new swagger files have Armstrong Configurations
$addedFiles = Get-AddedSwaggerFiles
foreach ($file in $addedFiles) {
  $directory = Split-Path -Path $file -Parent
  $filePath = Join-Path $repoPath $file
  LogInfo $filePath
  $suppression = Get-Suppression ArmstrongValidation $filePath
  if ($suppression) {
    $reason = $suppression["reason"] ?? "<no reason specified>"
    LogInfo "$file suppressed Armstrong Test: $reason"
    continue
  }

  $terraformFiles = $filesToCheck.Where({ 
    # since `git diff` returns paths with `/`, use the following code to match the `main.tf`
    $_.StartsWith($directory)
  })

  if ($terraformFiles.Count -eq 0) {
    LogError "The new swagger file $file does not have Armstrong Configurations"
    exit 1
  }
}

# Check Armstrong Configurations
$terraformErrors = @()

if (!$filesToCheck) {
  LogInfo "No Terraform files found to check"
}
else {
  foreach ($file in $filesToCheck) {
    LogInfo "Checking $file"

    $filePath = (Join-Path $repoPath $file)

    $suppression = Get-Suppression ArmstrongValidation $filePath
    if ($suppression) {
      $reason = $suppression["reason"] ?? "<no reason specified>"

      LogInfo "$file suppressed Armstrong configuration validation: $reason"
      continue
    }

    try {
      Ensure-Armstrong-Installed
      LogInfo "  Validating errors from Terraform file: $filePath"
      $terraformErrors += (Validate-Terraform-Error $repoPath $filePath)
    }
    catch {
      $terraformErrors += "failed to validate errors from Terraform file $file : $_"
    }
  }
}

if ($terraformErrors.Count -gt 0) {
  $errorString = "Armstrong Validation failed for some files. To fix, address the following errors. For false positive errors, please follow https://eng.ms/docs/products/azure-developer-experience/design/specs-pr-guides/pr-suppressions to suppress 'ArmstrongValidation'`n"
  $errorString += $terraformErrors -join "`n"
  LogInfo $errorString
  exit 1
}

# Check the Armstrong Test Result
$repositoryId = [Environment]::GetEnvironmentVariable("GITHUB_REPOSITORY", [EnvironmentVariableTarget]::Process)
LogInfo "Repository ID: $repositoryId"
$repoOwner = $repositoryId.Split("/")[0]
$repoName = $repositoryId.Split("/")[1]
LogInfo "Repository Owner: $repoOwner"
LogInfo "Repository Name: $repoName"
$pullRequestNumber = [Environment]::GetEnvironmentVariable("GH_PR_NUMBER", [EnvironmentVariableTarget]::Process)
$authToken = [Environment]::GetEnvironmentVariable("GH_TOKEN", [EnvironmentVariableTarget]::Process)
LogInfo "Repository ID: $repositoryId"
LogInfo "Pull Request Number: $pullRequestNumber"

$hasArmstrongTestResult = $false
try {
  $response = Get-GitHubIssueComments -RepoOwner $repoOwner -RepoName $repoName -IssueNumber $pullRequestNumber -AuthToken $AuthToken
  for ($i = $response.Length - 1; $i -ge 0; $i--) {
    $responseObject = $response[$i]
    if ($responseObject.body.Contains("API TEST ERROR REPORT")) {
      LogInfo $responseObject.body
      $hasArmstrongTestResult = $true

      if ($responseObject.body.Contains("Approved-Suppression")) {
        LogInfo "The API TEST ERROR REPORT is tagged Approved-Suppression"
        continue
      }

      if ($responseObject.body.Contains("**message**:")) {
        LogError "Please fix all errors in API TEST ERROR REPORT: $($responseObject.html_url)"
      }

      $coverages = [regex]::Matches($responseObject.body, '(\d+(\.\d+)?)(?=%)')
      # Output the matches
      foreach ($coverage in $coverages) {
        if ($coverage.Value + "%" -ne "100.0%") {
          LogError "Properties of some APIs are not 100% covered in API TEST ERROR REPORT: $($responseObject.html_url)"
        }
      }

      LogInfo "Armstrong Test result is submitted in PR comments: $($responseObject.html_url)"
      break
    }
  }
}
catch { 
  LogError "Failed with exception: $_"
  exit 1
}

if (!$hasArmstrongTestResult) {
  LogError "Armstrong Test result is not submitted in PR comments."
  exit 1
}

exit 0