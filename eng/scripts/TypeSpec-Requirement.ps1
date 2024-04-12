[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [string] $BaseCommitish = "HEAD^",
  [Parameter(Position = 1)]
  [string] $TargetCommitish = "HEAD",
  [Parameter(Position = 2)]
  [string] $SpecType = "data-plane|resource-manager"
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
    } else {
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

      if ($tool -eq "TypeSpecRequirement") {
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

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$pathsWithErrors = @()

$filesToCheck = (Get-ChangedSwaggerFiles (Get-ChangedFiles $BaseCommitish $TargetCommitish)).Where({
  ($_ -notmatch "/(examples|scenarios|restler|common|common-types)/") -and
  ($_ -match "specification/[^/]+/($SpecType).*?/(preview|stable)/[^/]+/[^/]+\.json$")
})

if (!$filesToCheck) {
  LogInfo "No OpenAPI files found to check"
}
else {
  # Cache responses to GitHub web requests, for efficiency and to prevent rate limiting
  $responseCache = @{}

  # - Forward slashes on both Linux and Windows
  # - May be nested 4 or 5 levels deep, perhaps even deeper
  # - Examples
  #   - specification/foo/data-plane/Foo/stable/2023-01-01/Foo.json
  #   - specification/foo/data-plane/Foo/bar/stable/2023-01-01/Foo.json
  #   - specification/foo/resource-manager/Microsoft.Foo/stable/2023-01-01/Foo.json
  # - Doc: https://github.com/Azure/azure-rest-api-specs/blob/main/README.md#directory-structure
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
      $jsonContent = Get-Content $fullPath | ConvertFrom-Json -AsHashtable
    }
    catch {
      LogWarning "  OpenAPI cannot be parsed as JSON, so assuming not generated from TypeSpec"
      LogWarning "    $_"
    }

    if ($jsonContent) {
      if ($null -ne ${jsonContent}?["info"]?["x-typespec-generated"]) {
        LogInfo "  OpenAPI was generated from TypeSpec (contains '/info/x-typespec-generated')"

        if ($file -match "specification/(?<rpFolder>[^/]+)/") {
          $rpFolder = $Matches["rpFolder"];
          $tspConfigs = @(Get-ChildItem -Path (Join-Path $repoPath "specification" $rpFolder) -Recurse -File
            | Where-Object { $_.Name -eq "tspconfig.yaml" })

          if ($tspConfigs) {
            LogInfo "  Folder 'specification/$rpFolder' contains $($tspConfigs.Count) file(s) named 'tspconfig.yaml'"
          }
          else {
            LogError ("OpenAPI was generated from TypeSpec, but folder 'specification/$rpFolder' contains no files named 'tspconfig.yaml'." `
              + "  The TypeSpec used to generate OpenAPI must be added to this folder.")
            LogJobFailure
            exit 1
          }
        }
        else {
          LogError "Path to OpenAPI did not match expected regex.  Unable to extract RP folder."
          LogJobFailure
          exit 1
        }

        # Skip further checks, since spec is already using TypeSpec
        continue
      }
      else {
        LogInfo "  OpenAPI was not generated from TypeSpec (missing '/info/x-typespec-generated')"
      }
    }

    # Extract path between "specification/" and "/(preview|stable)"
    if ($file -match "specification/(?<servicePath>[^/]+/($SpecType).*?)/(preview|stable)/[^/]+/[^/]+\.json$") {
      $servicePath = $Matches["servicePath"]
    }
    else {
      LogError "Path to OpenAPI did not match expected regex.  Unable to extract service path."
      LogJobFailure
      exit 1
    }

    $urlToStableFolder = "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/$servicePath/stable"

    # Avoid conflict with pipeline secret
    $logUrlToStableFolder = $urlToStableFolder -replace '^https://',''

    LogInfo "  Checking $logUrlToStableFolder"

    $responseStatus = $responseCache[$urlToStableFolder];
    if ($null -ne $responseStatus) {
      LogInfo "    Found in cache"
    }
    else {
      LogInfo "    Not found in cache, making web request"
      try {
        $response = Invoke-WebRequest -Uri $urlToStableFolder -Method Head -SkipHttpErrorCheck
        $responseStatus = $response.StatusCode
        $responseCache[$urlToStableFolder] = $responseStatus
      }
      catch {
        LogError "Exception making web request to ${logUrlToStableFolder}: $_"
        LogJobFailure
        exit 1
      }
    }

    LogInfo "    Status: $responseStatus"

    if ($responseStatus -eq 200) {
      LogInfo "  Branch 'main' contains path '$servicePath/stable', so spec already exists and is not required to use TypeSpec"
    }
    elseif ($response.StatusCode -eq 404) {
      LogInfo "  Branch 'main' does not contain path '$servicePath/stable', so spec is new and must use TypeSpec"
      $pathsWithErrors += $file
    }
    else {
      LogError "Unexpected response from ${logUrlToStableFolder}: ${response.StatusCode}"
      LogJobFailure
      exit 1
    }
  }
}

if ($pathsWithErrors.Count -gt 0)
{
  # DevOps only adds the first 4 errors to the github checks list so lets always add the generic one first
  # and then as many of the individual ones as can be found afterwards
  LogError "New specs must use TypeSpec.  For more detailed docs see https://aka.ms/azsdk/typespec"
  LogJobFailure

  foreach ($path in $pathsWithErrors)
  {
    LogErrorForFile $path "OpenAPI was not generated from TypeSpec, and spec appears to be new"
  }
  exit 1
}

exit 0
