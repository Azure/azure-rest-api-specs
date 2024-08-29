[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [string] $BaseCommitish = "HEAD^",
  [Parameter(Position = 1)]
  [string] $TargetCommitish = "HEAD",
  [Parameter(Position = 2)]
  [string] $SpecType = "data-plane|resource-manager",
  [string] $CheckAllUnder,
  # Reserved for testing.  Call using:
  # $ pwsh -Command '... -_ResponseCache @{"url"=200}'
  [Parameter(DontShow)]
  [hashtable] $_ResponseCache = @{}
)
Set-StrictMode -Version 3

. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/Logging-Functions.ps1
. $PSScriptRoot/Suppressions-Functions.ps1

function Get-ValidatedSuppression {
  param (
    [string]$fileInSpecFolder
  )

  $suppression = Get-Suppression "TypeSpecRequirement" $fileInSpecFolder

  if ($suppression) {
    # Each path must specify a single version (without wildcards) under "preview|stable"
    # 
    # Allowed:    data-plane/Azure.Contoso.WidgetManager/preview/2022-11-01-preview/**/*.json
    # Disallowed: data-plane/Azure.Contoso.WidgetManager/preview/**/*.json
    # Disallowed: data-plane/**/*.json
    # 
    # Include "." since a few specs use versions like "X.Y" instead of "YYYY-MM-DD"
    $singleVersionPattern = "/(preview|stable)/[A-Za-z0-9._-]+/"

    $paths = $suppression["paths"]

    foreach ($path in $paths) {
      if ($path -notmatch $singleVersionPattern) {
        LogError ("Invalid path '$path'.  Path must only include one version per suppression.")
        LogJobFailure
        exit 1
      }
    }
  }

  return $suppression
}

$repoPath = Resolve-Path "$PSScriptRoot/../.."
$pathsWithErrors = @()

$filesToCheck = $CheckAllUnder ?
  (Get-ChildItem -Path $CheckAllUnder -Recurse -File | Resolve-Path -Relative -RelativeBasePath $repoPath | ForEach-Object { $_ -replace '\\', '/' }) :
  (Get-ChangedSwaggerFiles (Get-ChangedFiles $BaseCommitish $TargetCommitish))

$filesToCheck = $filesToCheck.Where({
  ($_ -notmatch "/(examples|scenarios|restler|common|common-types)/") -and
  ($_ -match "specification/[^/]+/($SpecType).*?/(preview|stable)/[^/]+/[^/]+\.json$")
  })

if (!$filesToCheck) {
  LogInfo "No OpenAPI files found to check"
}
else {
  # Cache responses to GitHub web requests, for efficiency and to prevent rate limiting
  $responseCache = $_ResponseCache

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

    $suppression = Get-ValidatedSuppression $fullPath
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

        if ($file -match "^.*specification/[^/]+/") {
          $rpFolder = $Matches[0];
          $tspConfigs = @(Get-ChildItem -Path $rpFolder -Recurse -File | Where-Object { $_.Name -eq "tspconfig.yaml" })

          if ($tspConfigs) {
            LogInfo "  Folder '$rpFolder' contains $($tspConfigs.Count) file(s) named 'tspconfig.yaml'"
          }
          else {
            LogError ("OpenAPI was generated from TypeSpec, but folder '$rpFolder' contains no files named 'tspconfig.yaml'." `
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
    $logUrlToStableFolder = $urlToStableFolder -replace '^https://', ''

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
    elseif ($responseStatus -eq 404) {
      LogInfo "  Branch 'main' does not contain path '$servicePath/stable', so spec is new and must use TypeSpec"
      $pathsWithErrors += $file
    }
    else {
      LogError "Unexpected response from ${logUrlToStableFolder}: ${responseStatus}"
      LogJobFailure
      exit 1
    }
  }
}

if ($pathsWithErrors.Count -gt 0) {
  # DevOps only adds the first 4 errors to the github checks list so lets always add the generic one first
  # and then as many of the individual ones as can be found afterwards
  LogError "New specs must use TypeSpec.  For more detailed docs see https://aka.ms/azsdk/typespec"
  LogJobFailure

  foreach ($path in $pathsWithErrors) {
    LogErrorForFile $path "OpenAPI was not generated from TypeSpec, and spec appears to be new"
  }
  exit 1
}

exit 0
