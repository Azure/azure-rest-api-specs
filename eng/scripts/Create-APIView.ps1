
. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/../common/scripts/logging.ps1

<#
.DESCRIPTION
  Get the readme.md file associated with a swagger file.

.PARAMETER SwaggerFile
  Path to a swagger files inside the 'specification' directory.

.OUTPUTS
  the readme.md file associated with the swagger file or null if not found.
#>
function Get-SwaggerReadMeFile {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SwaggerFile
    )
    
    $currentPath = Resolve-Path $SwaggerFile
    
    while ($currentPath -ne [System.IO.Path]::GetPathRoot($currentPath)) {
        $currentPath = [System.IO.Path]::GetDirectoryName($currentPath)
        $readmeFile = Get-ChildItem -Path $currentPath -Filter "readme.md" -File -ErrorAction SilentlyContinue
        if ($readmeFile -and $readmeFile.Name -eq "readme.md") {
            return $readmeFile.FullName
        }
    }

    return $null
}

<#
.DESCRIPTION
  Use the directory structure convention to get the resource provider name.

.PARAMETER ReadMeFilePath
  ReadMe File Path for a resource provider.

.OUTPUTS
  The resource provider name.
#>
function Get-ResourceProviderFromReadMePath {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ReadMeFilePath
    )

    $directoryPath = [System.IO.Path]::GetDirectoryName($ReadMeFilePath)
    $resourceProviderDirectory = Get-ChildItem -Path $directoryPath -Directory | Select-Object -First 1
    return $resourceProviderDirectory.Name
}

<#
.DESCRIPTION
  Invoke the swagger parset to generate APIView tokens.

.PARAMETER Type
  New or Baseline swagger APIView tokens.

.PARAMETER ReadMeFilePath
  The Swagger ReadMeFilePath.

.PARAMETER ResourceProvider
  The ResourceProvider Name.

.PARAMETER Tag
  The Tag to use for generating the APIView Tokens.

.PARAMETER TokenDirectory
  The directory to store the generated APIView Tokens.

.OUTPUTS
  The resource provider name.
#>
function Invoke-SwaggerAPIViewParser {
    param (
        [ValidateSet("New", "Baseline")]
        [Parameter(Mandatory = $true)]
        [string]$Type,
        [Parameter(Mandatory = $true)]
        [string]$ReadMeFilePath,
        [Parameter(Mandatory = $true)]
        [string]$ResourceProvider,
        [Parameter(Mandatory = $true)]
        [string]$TokenDirectory,
        [string]$Tag
    )
    $tempWorkingDirectoryName = [guid]::NewGuid().ToString()
    $tempWorkingDirectoryPath = [System.IO.Path]::Combine($TempDirectory, $tempWorkingDirectoryName)
    New-Item -ItemType Directory -Path $tempWorkingDirectoryPath > $null

    Push-Location -Path $tempWorkingDirectoryPath

    try {
      # Generate Swagger APIView tokens
      $command = "swaggerAPIParser"
      $arguments = @("--readme", "$readMeFile", "--package-name", "$resourceProvider", "--use-tag-for-output")

      if ($Tag) {
        $arguments += "--tag"
        $arguments += "$Tag"
      }

      LogInfo " $command $arguments"
      LogGroupStart " Generating '$Type' APIView Tokens using '$readMeFile' for '$resourceProvider'..."

      & $command @arguments 2>&1 | ForEach-Object { Write-Host $_ }

      LogGroupEnd

      $generatedAPIViewTokenFile = Get-ChildItem -File | Select-Object -First 1
      $readMeTag = $generatedAPIViewTokenFile.BaseName

      LogSuccess " Generated '$Type' APIView Token File using file, '$readMeFile' and tag '$readMeTag'"

      $apiViewTokensFilePath = [System.IO.Path]::Combine($TokenDirectory, "$resourceProvider.$Type.json")
      LogInfo " Moving generated APIView Token file to '$apiViewTokensFilePath'"
      Move-Item -Path $generatedAPIViewTokenFile.FullName -Destination $apiViewTokensFilePath -Force > $null

      return $readMeTag
    } catch {
      LogError " Failed to generate '$Type' APIView Tokens using '$readMeFile' for '$resourceProvider'"
      throw
    } finally {
      Pop-Location
      if (Test-Path -Path $tempWorkingDirectoryPath) {
        Remove-Item -Path $tempWorkingDirectoryPath -Recurse -Force > $null
      }
    }
}

<#
.DESCRIPTION
  Generate New and Baseline APIView tokens for the changed swagger files in the PR.
  Detects the swagger files changed in the PR and generates APIView tokens for the swagger files.
  New APIView tokens are generated using the default tag on the base branch.
  Baseline APIView tokens are generated using the same tag on the target branch.
  Script asumes that the merge commit is checked out. Such that Source commit = HEAD^ and Target commit = HEAD.

.PARAMETER TempDirectory
  Temporary directory for files being processed. Use $(Agent.TempDirectory) on DevOps

.PARAMETER ArtiFactsStagingDirectory
  The directory where the APIView tokens will be stored. Use $(Build.ArtifactStagingDirectory) on DevOps

.PARAMETER APIViewArtifactsDirectoryName
  Name for the subdirectory where the APIView tokens will be stored.
#>
function New-SwaggerAPIViewTokens {
  param (
    [Parameter(Mandatory = $true)]
    [string]$TempDirectory,
    [Parameter(Mandatory = $true)]
    [string]$ArtiFactsStagingDirectory,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsDirectoryName
  )

  $SourceCommitId = $(git rev-parse HEAD^2)
  $TargetCommitId = $(git rev-parse HEAD^1)

  # Get Changed Swagger Files
  LogInfo " Getting changed swagger files in PR, between $SourceCommitId and $TargetCommitId"
  $changedFiles = Get-ChangedFiles -baseCommitish $SourceCommitId -targetCommitish $TargetCommitId
  $changedSwaggerFiles = Get-ChangedSwaggerFiles -changedFiles $changedFiles

  if ($changedSwaggerFiles.Count -eq 0) {
    LogWarning " There are no changes to swagger files in the current PR..."
    Write-Host "##vso[task.complete result=SucceededWithIssues;]DONE"
    exit 0
  }

  LogGroupStart " Pullrequest has changes in these swagger files..."
  $changedSwaggerFiles | ForEach-Object {
    LogInfo " - $_"
  }
  LogGroupEnd

  # Get Related Swagger ReadMe Files
  $swaggerReadMeFiles = [System.Collections.Generic.HashSet[string]]::new()
  $changedSwaggerFiles | ForEach-Object {
    $readmeFile = Get-SwaggerReadMeFile -swaggerFile $_
    if ($readmeFile) {
        $swaggerReadMeFiles.Add($readmeFile) | Out-Null
    }
  }

  LogGroupStart " Swagger APIView Tokens will be generated for the following configuration files..."
  $readmeFile | ForEach-Object {
    LogInfo " - $_"
  }
  LogGroupEnd

  $currentBranch = git rev-parse --abbrev-ref HEAD

  $swaggerAPIViewArtifactsDirectory = [System.IO.Path]::Combine($ArtiFactsStagingDirectory, $APIViewArtifactsDirectoryName)

  # Generate Swagger APIView Tokens
  foreach ($readMeFile in $swaggerReadMeFiles) {
      $resourceProvider = Get-ResourceProviderFromReadMePath -ReadMeFilePath $readMeFile
      $tokenDirectory = [System.IO.Path]::Combine($swaggerAPIViewArtifactsDirectory, $resourceProvider)
      New-Item -ItemType Directory -Path $tokenDirectory | Out-Null

      # Generate New APIView Token using default tag on base branch
      git checkout $SourceCommitId
      $defaultTag = Invoke-SwaggerAPIViewParser -Type "New" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory

      # Generate BaseLine APIView Token using same tag on target branch
      git checkout $TargetCommitId
      Invoke-SwaggerAPIViewParser -Type "Baseline" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory -Tag $defaultTag | Out-Null
  }

  git checkout $currentBranch

  LogGroupStart " See all generated Swagger APIView Artifacts..."
  Get-ChildItem -Path $swaggerAPIViewArtifactsDirectory -Recurse
  LogGroupEnd
}

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
  The language of the resource provider `Swagger`
.PARAMETER CommitSha
  The commit sha of the current branch. Uusally the merge commit of the PR.
#>
function New-RestSpecsAPIViewReviews {
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

  $apiViewArtifactsDirectory = [System.IO.Path]::Combine($ArtiFactsStagingDirectory, $APIViewArtifactsDirectoryName)
  $publishedPackages = Get-ChildItem -Path $apiViewArtifactsDirectory -Directory -ErrorAction SilentlyContinue

  Write-Host "Published packages: $publishedPackages"

  $createAPIViewFailed = $false

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
      LogWarning "'Baseline' APIView token file not found for resource provider '$($_.BaseName)'. Created APIView without baseline."
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
      $createAPIViewFailed = $true
    }
  }

  if ($createAPIViewFailed) {
    LogError "Failed to create APIView for some resource providers. Check the logs for more details."
    Write-Host "##vso[task.complete result=SucceededWithIssues;]DONE"
    exit 1
  }
}