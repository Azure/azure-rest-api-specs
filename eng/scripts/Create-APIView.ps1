
<#
.DESCRIPTION
  Create APIView for the published packages. Send DevOps artifacts information to APIView to create APIView for the published packages.

.PARAMETER ArtiFactsStagingDirectory
  The DevOps artifacts staging directory. Use $(Build.ArtifactStagingDirectory) on DevOps
.PARAMETER APIViewArtifactsDirectoryName
 Temporary Directory for processing the APIView artifacts
.PARAMETER APIViewArtifactsName
  The name of the APIView artifact
.PARAMETER APIViewUri
 The EndPoint for creating APIView https://apiviewstagingtest.com/PullRequest/DetectAPIChanges
.PARAMETER BuildId
TGhe BuildId of the Run
.PARAMETER RepoName
  Repo name eg Azure/azure-rest-api-specs
.PARAMETER PullRequestNumber
  The PR number
.PARAMETER Language
  The language of the resource provider `Swagger` or `TypeSpec`
.PARAMETER CommitSha
  The commit sha of the current branch. Uusally the merge commit of the PR.
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
