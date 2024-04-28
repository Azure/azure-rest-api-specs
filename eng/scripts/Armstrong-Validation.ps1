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

$script:psYamlInstalled = $false
function Ensure-PowerShell-Yaml-Installed {
  if ($script:psYamlInstalled) {
    # If already checked once in this script, don't log anything further
    return;
  }

  $script:psYamlInstalled = [bool] (Get-Module -ListAvailable -Name powershell-yaml | Where-Object { $_.Version -eq "0.4.7" })

  if ($script:psYamlInstalled) {
    LogInfo "Module powershell-yaml@0.4.7 already installed"
  }
  else {
    LogInfo "Installing module powershell-yaml@0.4.7"
    Install-Module -Name powershell-yaml -RequiredVersion 0.4.7 -Force -Scope CurrentUser
    $script:psYamlInstalled = $true
  }
}

function Find-Suppressions-Yaml {
  param (
    [string]$fileInSpecFolder
  )

  $currentDirectory = Get-Item (Split-Path -Path $fileInSpecFolder)

  while ($currentDirectory) {
    $suppressionsFile = Join-Path -Path $currentDirectory.FullName -ChildPath "suppressions.yaml"

    if (Test-Path $suppressionsFile) {
      return $suppressionsFile
    }
    else {
      $currentDirectory = $currentDirectory.Parent
    }
  }

  return $null
}

function Get-Suppression {
  param (
    [string]$fileInSpecFolder
  )

  $suppressionsFile = Find-Suppressions-Yaml $fileInSpecFolder
  if ($suppressionsFile) {
    Ensure-PowerShell-Yaml-Installed

    $suppressions = Get-Content -Path $suppressionsFile -Raw | ConvertFrom-Yaml
    foreach ($suppression in $suppressions) {
      $tool = $suppression["tool"]
      $path = $suppression["path"]

      if ($tool -eq "ArmstrongValidation") {
        # Paths in suppressions.yml are relative to the file itself
        $fullPath = Join-Path -Path (Split-Path -Path $suppressionsFile) -ChildPath $path

        # If path is not specified, suppression applies to all files
        if (!$path -or ($fileInSpecFolder -like $fullPath)) {
          return $suppression
        }
      }
    }
  }

  return $null
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
          $item = "Error Item:"
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

# DEBUG
Get-ChildItem Env: | ForEach-Object {
  LogInfo "$($_.Name): $($_.Value)"
}

LogWarning "Warning Test"
LogError "Error Test"
# DEBUG end

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
  $errorString = "Armstrong Validation failed for some files. To fix, address the following errors: `n"
  $errorString += $terraformErrors -join "`n"
  Write-Error $errorString

  LogJobFailure
  exit 1
}

exit 0
