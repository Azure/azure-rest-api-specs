###
# Conventient usage: 
# 1) generate specific language sdk based on current typespec folder
#   ./TypeSpec-Generate-Sdk.ps1 -SdkLanguage {language}
#   e.g. ./TypeSpec-Generate-Sdk.ps1 -SdkLanguage dotnet
# The pre-requisite is the sdk repos path in local machine follows below convention:
# 1). "azure-rest-api-specs" and "sdk-repos" are peer folder under same parent folder
# 2). each sdk language repo is under "sdk-repos" folder, i.e.
#     sdk-repos/azure-sdk-for-net
#     sdk-repos/azure-sdk-for-java
#     sdk-repos/azure-sdk-for-python
#     sdk-repos/azure-sdk-for-js
###

[CmdletBinding()]
param (
  [Parameter(Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string] $SdkRepoRootDirectory,
  [Parameter(Position = 1)]
  [string] $TypeSpecProjectDirectory = ".", # A directory of `tspconfig.yaml` or a remoteUrl of `tspconfig.yaml`
  [Parameter(Position = 2)]
  [string] $CommitHash,
  [Parameter(Position = 3)]
  [string] $RepoUrl,
  [string] $SdkLanguage
)

$TypeSpecProjectDirectory = (Resolve-Path $TypeSpecProjectDirectory).Path

if ($SdkLanguage) {
  # example value of TypeSpecProjectDirectory: /workspaces/azure-rest-api-specs/specification/contosowidgetmanager/Contoso.WidgetManager
  $index = $TypeSpecProjectDirectory.IndexOf("specification")
  if ($index -eq -1) {
    Write-Error "The input TypeSpecProjectDirectory parameter doesn't have 'specification' folder in its path: $TypeSpecProjectDirectory"
    exit 1
  }
  $specFolderPath = $TypeSpecProjectDirectory.Substring(0, $index - 1)
  $rootPath = Split-Path $specFolderPath -Parent
  $sdkRepoRoot = Join-Path $rootPath "sdk-repos"
  if (!(Test-Path $sdkRepoRoot)) {
    Write-Error "sdk repos root folder doesn't exist: $sdkRepoRoot"
    exit 1
  }

  # trying to locate the default sdk repo folder under 'sdk-repos' folder by language value
  switch ($SdkLanguage) {
    "dotnet" {
      Write-Host "Generating dotnet sdk code ..."
      $sdkRepoPath = Join-Path $sdkRepoRoot "azure-sdk-for-net"
      if (!(Test-Path $sdkRepoPath)) {
        Write-Error "sdk repo doesn't exist: $sdkRepoPath"
        exit 1
      }
    }
    "java" {
      Write-Host "Generating java sdk code ..."
      $sdkRepoPath = Join-Path $sdkRepoRoot "azure-sdk-for-java"
      if (!(Test-Path $sdkRepoPath)) {
        Write-Error "sdk repo doesn't exist: $sdkRepoPath"
        exit 1
      }
    }
    "python" {
      Write-Host "Generating python sdk code ..."
      $sdkRepoPath = Join-Path $sdkRepoRoot "azure-sdk-for-python"
      if (!(Test-Path $sdkRepoPath)) {
        Write-Error "sdk repo doesn't exist: $sdkRepoPath"
        exit 1
      }
    }
    "js" {
      Write-Host "Generating js sdk code ..."
      $sdkRepoPath = Join-Path $sdkRepoRoot "azure-sdk-for-js"
      if (!(Test-Path $sdkRepoPath)) {
        Write-Error "sdk repo doesn't exist: $sdkRepoPath"
        exit 1
      }
    }
    default {
      Write-Error "The input SdkLanguage parameter should be one of this values: dotnet, java, python, js"
      exit 1
    }
  }
  $SdkRepoRootDirectory = $sdkRepoPath
}

try {
  Push-Location $SdkRepoRootDirectory
  $commonScript = Join-Path . "eng/common/scripts/TypeSpec-Project-Process.ps1"
  if (Test-Path $commonScript) {
    Write-Host ". $commonScript -TypeSpecProjectDirectory $TypeSpecProjectDirectory -CommitHash $CommitHash -RepoUrl $RepoUrl"
    . $commonScript -TypeSpecProjectDirectory $TypeSpecProjectDirectory -CommitHash $CommitHash -RepoUrl $RepoUrl
    if ($LASTEXITCODE) {
      exit $LASTEXITCODE
    }
  }
  else {
    Write-Error "Cannot find $commonScript at $SdkRepoRootDirectory"
  }
}
finally {
  Pop-Location
}

exit 0