
<#
.DESCRIPTION


.PARAMETER ArtifactName
  Temporary directory for files being processed. Use $(Agent.TempDirectory) on DevOps

#>
param (
    [Parameter(Mandatory = $true)]
    [string]$ArtiFactsStagingDirectory,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsDirectoryName,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsName,
    [Parameter(Mandatory = $true)]
    [string]$APIViewUri,
    [Parameter(Mandatory = $true)]
    [string]$BuildId,
    [Parameter(Mandatory = $true)]
    [string]$RepoName,
    [Parameter(Mandatory = $true)]
    [string]$PullRequestNumber,
    [Parameter(Mandatory = $true)]
    [string]$Language,
    [Parameter(Mandatory = $true)]
    [string]$CommitSha
)

. $PSScriptRoot/../common/scripts/logging.ps1

$apiViewArtifactsDirectory = [System.IO.Path]::Combine($ArtiFactsStagingDirectory, $APIViewArtifactsDirectoryName)
$publishedPackages = Get-ChildItem -Path $apiViewArtifactsDirectory -Directory -ErrorAction SilentlyContinue

Write-Host "Published packages: $publishedPackages"

$publishedPackages | ForEach-Object {
  $apiViewArtifacts = Get-ChildItem -Path $_.FullName -File -Filter "*.json" -ErrorAction SilentlyContinue
  $query = [System.Web.HttpUtility]::ParseQueryString('')

  $apiViewArtifacts | ForEach-Object {
    if ($_.BaseName.EndsWith("New")) {
      $query.Add("codeFile", $_.Name)
    }
    elseif ($_.BaseName.EndsWith("Baseline")) {
      $query.Add("baselineCodeFile", $_.Name)
    }
  }

  if (-not $query['codeFile']) {
    LogWarning "'New' APIView token file not found for resource provider '$($_.BaseName)'. Skipping APIView creation."
    return
  }

  if (-not $query['baselineCodeFile']) {
    LogWarning "'Baseline' APIView token file not found for resource provider '$($_.BaseName)'. Skipping APIView creation."
    return
  }
 
  $query.Add('artifactName', $APIViewArtifactsName)
  $query.Add('buildId', $BuildId)
  $query.Add('commitSha', $CommitSha)
  $query.Add('repoName', $RepoName)
  $query.Add('pullRequestNumber', $PullRequestNumber)
  $query.Add('packageName', $_.BaseName)
  $query.Add('language', $Language)
  $query.Add('commentOnPR', $true)
  $query.Add('location', "GitHub")

  $uri = [System.UriBuilder]$APIViewUri
  $uri.Query = $query.ToString()

  LogInfo "Create APIView for resource provider '$($_.BaseName)'"
  LogInfo "APIView Uri: $($uri.Uri)"

  try {
    Invoke-WebRequest -Method 'GET' -Uri $uri.Uri -MaximumRetryCount 3
  }
  catch {
    LogError "Failed to create APIView for resource provider '$($_.BaseName)'. Error: $($_.Exception.Response)"
  }
}
