
. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/../common/scripts/logging.ps1

$defaultTagRegex = "^tag:\s*(?<tag>.+)"
$tagRegex = '^```\s*yaml\s*\$\(tag\)\s*==\s*''(?<tag>.+)'''

<#
.DESCRIPTION
  Gets configuration info (tags and configFilePath) associated with a swagger file.

.PARAMETER SwaggerFile
  Path to a swagger files inside the 'specification' directory.

.OUTPUTS
  the configuration info (tags and configFilePath) or null if not found.
#>
function Get-AutoRestConfigInfo {
  param (
      [Parameter(Mandatory = $true)]
      [string]$SwaggerFile
  )
  
  $currentPath = Resolve-Path $SwaggerFile

  while ($currentPath -ne [System.IO.Path]::GetPathRoot($currentPath)) {
    $currentPath = [System.IO.Path]::GetDirectoryName($currentPath)
    $currentFilePath = [System.IO.Path]::GetFileName($currentPath)

    if ($currentFilePath -eq "specification") {
      break
    }

    $readmeFile = Get-ChildItem -Path $currentPath -Filter "readme.md" -File -ErrorAction SilentlyContinue
    if ($readmeFile -and $readmeFile.Name -eq "readme.md") {
      $tagInfo = Get-TagInformationFromReadMeFile -ReadMeFilePath $readmeFile.FullName

      if ($tagInfo.DefaultTag) {
        $tagInfo | Add-Member -MemberType NoteProperty -Name "ConfigPath" -Value $readmeFile
        return $tagInfo
      }
    }
  }

  return $null
}

<#
.DESCRIPTION
  Use the directory structure convention to get the resource provider name.
  Append the service directory name if there are multiple services in the same resource provider

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
    $pathName = [System.IO.Path]::GetFileName($directoryPath)

    if ($pathName -eq "resource-manager" -or $pathName -eq "data-plane") {
      $resourceProviderDirectory = Get-ChildItem -Path $directoryPath -Directory | Select-Object -First 1
      return $resourceProviderDirectory.Name
    }
    else {
      $currentPath = Resolve-Path $directoryPath
      $serviceName = $pathName

      while ($currentPath -ne [System.IO.Path]::GetPathRoot($currentPath)) {
        $pathName = [System.IO.Path]::GetFileName($currentPath)

        if ($pathName -eq "resource-manager" -or $pathName -eq "data-plane") {
          $resourceProviderDirectory = Get-ChildItem -Path $currentPath -Directory | Select-Object -First 1
          return $resourceProviderDirectory.Name + "-" + $serviceName
        }
        $currentPath = Resolve-Path ([System.IO.Path]::GetDirectoryName($currentPath))
      }
    }
    return $null
}

function Get-ImpactedTypespecProjects {
    param (
        [Parameter(Mandatory = $true)]
        [string]$TypeSpecFile
    )
    $it = $TypeSpecFile
    while ($it -and !$configFilesInTypeSpecProjects) {
      $it = Split-Path -Parent $it
      $configFilesInTypeSpecProjects = Get-ChildItem -Path $it -File "tspconfig.yaml"
    }
    
    if ($configFilesInTypeSpecProjects) {
      foreach($configFilesInTypeSpecProject in $configFilesInTypeSpecProjects) {
        $entryPointFile = Get-ChildItem -Path $($configFilesInTypeSpecProject.Directory.FullName) -File "main.tsp"
        if ($entryPointFile) {
          Write-Host "Found $($configFilesInTypeSpecProject.Name) and $($entryPointFile.Name) in directory $($configFilesInTypeSpecProject.Directory.FullName)"
          return $configFilesInTypeSpecProject.Directory.FullName
        }
        else {
          Write-Host "Did not find main.tsp in directory $($configFilesInTypeSpecProject.Directory.FullName)"
        }
      }
    }
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
        [Parameter(Mandatory = $true)]
        [string]$TempDirectory,
        [string]$Tag
    )
    $tempWorkingDirectoryName = [guid]::NewGuid().ToString()
    $tempWorkingDirectoryPath = [System.IO.Path]::Combine($TempDirectory, $tempWorkingDirectoryName)
    New-Item -ItemType Directory -Path $tempWorkingDirectoryPath > $null

    Push-Location -Path $tempWorkingDirectoryPath

    try {
      # Generate Swagger APIView tokens
      $command = "swaggerAPIParser"
      $arguments = @("--readme", "$ReadMeFilePath", "--package-name", "$ResourceProvider")

      if ($Tag) {
        $arguments += "--tag"
        $arguments += "$Tag"
      }

      LogInfo " $command $arguments"
      LogGroupStart " Generating '$Type' APIView Tokens using '$ReadMeFilePath' for '$ResourceProvider'..."

      & $command @arguments 2>&1 | ForEach-Object { Write-Host $_ }

      LogGroupEnd

      $generatedAPIViewTokenFile = Join-Path (Get-Location) "swagger.json"

      if (Test-Path -Path $generatedAPIViewTokenFile) {
        LogSuccess " Generated '$Type' APIView Token File using file, '$ReadMeFilePath' and tag '$Tag'"
  
        $apiViewTokensFilePath = [System.IO.Path]::Combine($TokenDirectory, "$ResourceProvider.$Type.json")
        LogInfo " Moving generated APIView Token file to '$apiViewTokensFilePath'"
        Move-Item -Path $generatedAPIViewTokenFile -Destination $apiViewTokensFilePath -Force > $null
      }
    } catch {
      LogError " Failed to generate '$Type' APIView Tokens using '$ReadMeFilePath' for '$ResourceProvider'"
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
  Invoke the TypeSpec parser to generate APIView tokens.

.PARAMETER Type
  New or Baseline TypeSpec APIView tokens.

.PARAMETER ProjectPath
  The TypeSpec Project path.

.PARAMETER ResourceProvider
  The ResourceProvider Name.

.PARAMETER Tag
  The Tag to use for generating the APIView Tokens.

.PARAMETER TokenDirectory
  The directory to store the generated APIView Tokens.

.OUTPUTS
  The resource provider name.
#>
function Invoke-TypeSpecAPIViewParser {
  param (
      [ValidateSet("New", "Baseline")]
      [Parameter(Mandatory = $true)]
      [string]$Type,
      [Parameter(Mandatory = $true)]
      [string]$ProjectPath,
      [Parameter(Mandatory = $true)]
      [string]$ResourceProvider,
      [Parameter(Mandatory = $true)]
      [string]$TokenDirectory
  )
  $tempWorkingDirectoryName = [guid]::NewGuid().ToString()
  $tempWorkingDirectoryPath = [System.IO.Path]::Combine($TempDirectory, $tempWorkingDirectoryName)
  New-Item -ItemType Directory -Path $tempWorkingDirectoryPath > $null

  try {
    Write-Host "Compiling files and generating '$Type' APIView for '$resourceProvider'..."
    Push-Location $ProjectPath
    Write-Host "npm exec --no -- tsp compile . --emit=@azure-tools/typespec-apiview --option @azure-tools/typespec-apiview.emitter-output-dir=$tempWorkingDirectoryPath/output/apiview.json"
    npm exec --no -- tsp compile . --emit=@azure-tools/typespec-apiview --option @azure-tools/typespec-apiview.emitter-output-dir=$tempWorkingDirectoryPath/output/apiview.json
    if ($LASTEXITCODE) {
      throw "Compilation error when running: 'npm exec --no -- tsp compile . --emit=@azure-tools/typespec-apiview --option @azure-tools/typespec-apiview.emitter-output-dir=$tempWorkingDirectoryPath/output/apiview.json'"
    }
    Pop-Location
    
    $generatedAPIViewTokenFile = Get-ChildItem -File $tempWorkingDirectoryPath/output/apiview.json | Select-Object -First 1
    $apiViewTokensFilePath = [System.IO.Path]::Combine($TokenDirectory, "$resourceProvider.$Type.json")
    Write-Host "Moving generated APIView Token file to '$apiViewTokensFilePath'"
    Move-Item -Path $generatedAPIViewTokenFile.FullName -Destination $apiViewTokensFilePath -Force > $null
  } catch {
    LogError " Failed to generate '$Type' APIView Tokens on '$ProjectPath' for '$resourceProvider', please check the detail log and make sure TypeSpec compiler version is the latest."
    LogError $_
    throw
  } finally {
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

.PARAMETER ArtifactsStagingDirectory
  The directory where the APIView tokens will be stored. Use $(Build.ArtifactStagingDirectory) on DevOps

.PARAMETER APIViewArtifactsDirectoryName
  Name for the subdirectory where the APIView tokens will be stored.
#>
function New-SwaggerAPIViewTokens {
  param (
    [Parameter(Mandatory = $true)]
    [string]$TempDirectory,
    [Parameter(Mandatory = $true)]
    [string]$ArtifactsStagingDirectory,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsDirectoryName
  )

  $SourceCommitId = $(git rev-parse HEAD^2)
  $TargetCommitId = $(git rev-parse HEAD^1)

  # Get Changed Swagger Files
  LogInfo " Getting changed swagger files in PR, between $SourceCommitId and $TargetCommitId"
  $changedFiles = Get-ChangedFiles
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

  # Get Related AutoRest Configuration Information
  $autoRestConfigInfo = [System.Collections.Generic.Dictionary[string, object]]::new()
  $changedSwaggerFiles | ForEach-Object {
    $configInfo = Get-AutoRestConfigInfo -swaggerFile $_
    if ($null -ne $configInfo -and -not $autoRestConfigInfo.ContainsKey($configInfo.ConfigPath)) {
      $autoRestConfigInfo[$configInfo.ConfigPath] = $configInfo
    }
  }

  if ($autoRestConfigInfo.Count -eq 0) {
    LogWarning " No AutoRest configuration found for the changed swagger files in the current PR..."
    Write-Host "##vso[task.complete result=SucceededWithIssues;]DONE"
    exit 0
  }

  LogGroupStart " Swagger APIView Tokens will be generated for the following configuration files..."
  $autoRestConfigInfo.GetEnumerator() | ForEach-Object {
    LogInfo " - $($_.Key)"
  }
  LogGroupEnd

  $currentBranch = git rev-parse --abbrev-ref HEAD

  $swaggerAPIViewArtifactsDirectory = [System.IO.Path]::Combine($ArtifactsStagingDirectory, $APIViewArtifactsDirectoryName)

  # Generate Swagger APIView Tokens
  foreach ($entry in $autoRestConfigInfo.GetEnumerator()) {
    $configInfo = $entry.Value
    $readMeFile = $entry.Key
    git checkout $SourceCommitId
    if (Test-Path -Path $readmeFile) {
      $resourceProvider = Get-ResourceProviderFromReadMePath -ReadMeFilePath $readMeFile
      $tokenDirectory = [System.IO.Path]::Combine($swaggerAPIViewArtifactsDirectory, $resourceProvider)
      New-Item -ItemType Directory -Path $tokenDirectory -Force | Out-Null

      # Generate New APIView Token using default tag on source branch
      Invoke-SwaggerAPIViewParser -Type "New" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory `
        -TempDirectory $TempDirectory -Tag $configInfo.DefaultTag | Out-Null

      # Generate BaseLine APIView Token using source commit tag on target branch or defaukt tag if source commit tag does not exist
      git checkout $TargetCommitId
      if (Test-Path -Path $readMeFile) {
        $targetTagInfo = Get-TagInformationFromReadMeFile -ReadMeFilePath $readMeFile
        $baseLineTag = $targetTagInfo.DefaultTag
        if ($targetTagInfo.Tags.Contains($configInfo.DefaultTag)) {
          $baseLineTag = $configInfo.DefaultTag
        }
        Invoke-SwaggerAPIViewParser -Type "Baseline" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory `
          -TempDirectory $TempDirectory -Tag $baseLineTag | Out-Null
      }
      else {
        LogWarning " Swagger ReadMe file '$readMeFile' not found on TargetBranch. Skipping APIView token generation."
      }
    }
    else {
      LogWarning " Swagger ReadMe file '$readMeFile' not found on SourceBranch. Skipping APIView token generation."
    }
  }

  git checkout $currentBranch
  $generatedSwaggerArtifacts = Get-ChildItem -Path $swaggerAPIViewArtifactsDirectory -Recurse
  if ($generatedSwaggerArtifacts.Count -eq 0) {
    LogWarning " No Swagger APIView Tokens generated..."
    Write-Host "##vso[task.complete result=SucceededWithIssues;]DONE"
    exit 0
  }

  LogGroupStart " See all generated Swagger APIView Artifacts..."
  $generatedSwaggerArtifacts
  LogGroupEnd
}

<#
.DESCRIPTION
  Generate New and Baseline APIView tokens for the changed TypeSpec files in the PR.
  Detects the TypeSpec files changed in the PR and generates APIView tokens for the TypeSpec files.
  New APIView tokens are generated using the default tag on the base branch.
  Baseline APIView tokens are generated using the same tag on the target branch.
  Script asumes that the merge commit is checked out. Such that Source commit = HEAD^ and Target commit = HEAD.

.PARAMETER TempDirectory
  Temporary directory for files being processed. Use $(Agent.TempDirectory) on DevOps

.PARAMETER ArtifactsStagingDirectory
  The directory where the APIView tokens will be stored. Use $(Build.ArtifactStagingDirectory) on DevOps

.PARAMETER APIViewArtifactsDirectoryName
  Name for the subdirectory where the APIView tokens will be stored.
#>
function New-TypeSpecAPIViewTokens {
  param (
    [Parameter(Mandatory = $true)]
    [string]$TempDirectory,
    [Parameter(Mandatory = $true)]
    [string]$ArtifactsStagingDirectory,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsDirectoryName
  )

  $SourceCommitId = $(git rev-parse HEAD^2)
  $TargetCommitId = $(git rev-parse HEAD^1)

  LogInfo " Getting changed TypeSpec files in PR, between $SourceCommitId and $TargetCommitId"
  $changedFiles = Get-ChangedFiles
  $changedTypeSpecFiles = Get-ChangedTypeSpecFiles -changedFiles $changedFiles

  if ($changedTypeSpecFiles.Count -eq 0) {
    LogWarning " There are no changes to TypeSpec files in the current PR..."
    Write-Host "##vso[task.complete result=SucceededWithIssues;]DONE"
    exit 0
  }

  LogGroupStart " Pullrequest has changes in these TypeSpec files..."
  $changedTypeSpecFiles | ForEach-Object {
    LogInfo " - $_"
  }
  LogGroupEnd
  
  # Get impacted TypeSpec projects
  $typeSpecProjects = [System.Collections.Generic.HashSet[string]]::new()
  $changedTypeSpecFiles | ForEach-Object {
    $tspProj = Get-ImpactedTypespecProjects -TypeSpecFile "$_"
    if ($tspProj) {
      $typeSpecProjects.Add($tspProj) | Out-Null
    }
  }

  LogGroupStart " TypeSpec APIView Tokens will be generated for the following configuration files..."
  $typeSpecProjects | ForEach-Object {
    LogInfo " - $_"
  }
  LogGroupEnd

  $currentBranch = git rev-parse --abbrev-ref HEAD

  $typeSpecAPIViewArtifactsDirectory = [System.IO.Path]::Combine($ArtifactsStagingDirectory, $APIViewArtifactsDirectoryName)
  New-Item -ItemType Directory -Path $typeSpecAPIViewArtifactsDirectory -Force | Out-Null

  try {
    npm --version --loglevel info
    
    # Generate New TypeSpec APIView Tokens
    git checkout $SourceCommitId
    Write-Host "Installing required dependencies to generate New API review"
    npm ci
    LogGroupStart "npm ls -a" 
    npm ls -a
    LogGroupEnd 
    foreach ($typeSpecProject in $typeSpecProjects) {
      $tokenDirectory = Join-Path $typeSpecAPIViewArtifactsDirectory $(Split-Path $typeSpecProject -Leaf)
      New-Item -ItemType Directory -Path $tokenDirectory -Force | Out-Null
      Invoke-TypeSpecAPIViewParser -Type "New" -ProjectPath $typeSpecProject -ResourceProvider $(Split-Path $typeSpecProject -Leaf) -TokenDirectory $tokenDirectory
    }

    # Generate Baseline TypeSpec APIView Tokens 
    git checkout $TargetCommitId
    Write-Host "Installing required dependencies to generate Baseline API review"
    npm ci
    LogGroupStart "npm ls -a" 
    npm ls -a
    LogGroupEnd 
    foreach ($typeSpecProject in $typeSpecProjects) {
      # Skip Baseline APIView Token for new projects
      if (!(Test-Path -Path $typeSpecProject)) {
        Write-Host "TypeSpec project $typeSpecProject is not found in pull request target branch. API review will not have a baseline revision."
      }
      else {
        $tokenDirectory = Join-Path $typeSpecAPIViewArtifactsDirectory $(Split-Path $typeSpecProject -Leaf)
        Invoke-TypeSpecAPIViewParser -Type "Baseline" -ProjectPath $typeSpecProject -ResourceProvider $(Split-Path $typeSpecProject -Leaf) -TokenDirectory $tokenDirectory | Out-Null
      }
    }
  }
  finally {
    git checkout $currentBranch
    LogGroupStart " See all generated TypeSpec APIView Artifacts..."
    Get-ChildItem -Path $typeSpecAPIViewArtifactsDirectory -Recurse
    LogGroupEnd
  }
}

<#
.DESCRIPTION
  Create APIView for the published packages. Send DevOps artifacts information to APIView to create APIView for the published packages.

.PARAMETER ArtifactsStagingDirectory
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
  The language of the resource provider
.PARAMETER CommitSha
  The commit sha of the current branch. Uusally the merge commit of the PR.
#>
function New-RestSpecsAPIViewReviews {
  param (
    [Parameter(Mandatory = $true)]
    [string]$ArtifactsStagingDirectory,
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

  $apiViewArtifactsDirectory = [System.IO.Path]::Combine($ArtifactsStagingDirectory, $APIViewArtifactsDirectoryName)
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
    $query.Add('commentOnPR', $false)

    $uri = [System.UriBuilder]$APIViewUri
    $uri.Query = $query.ToString()

    $correlationId = [System.Guid]::NewGuid().ToString()
    $headers = @{
      "x-correlation-id" = $correlationId
    }

    LogInfo "Create APIView for resource provider '$($_.BaseName)'"
    LogInfo "Request URI: $($uri.Uri.OriginalString)"
    LogInfo "Correlation ID: $correlationId"

    try {
      $Response = Invoke-WebRequest -Method 'GET' -Uri $uri.Uri -Headers $headers -MaximumRetryCount 3
      $responseContent = $Response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
      LogSuccess $responseContent
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

<#
.DESCRIPTION
  Get all the tags from the swagger readme file with the default tag indicated.

.PARAMETER ReadMeFilePath
  The file path to the readme file.
#>
function Get-TagInformationFromReadMeFile {
  param (
    [Parameter(Mandatory = $true)]
    [string]$ReadMeFilePath
  )
  $tags = [System.Collections.Generic.HashSet[string]]::new()
  $markDownContent = Get-Content -Path $ReadMeFilePath
  $checkForDefaultTag = $false
  $defaultTag = $null

  foreach ($line in $markDownContent) {
    $line = $line.Trim()
    if ($line -match "###\s+Basic\s+Information") {
      $checkForDefaultTag = $true
    }

    if ($checkForDefaulttag -and ($null -eq $defaultTag)) {
      if ($line -match $defaultTagRegex) {
        $defaultTag = $matches["tag"]
        $checkForDefaultTag = $false
      }
    }

    if ($line -match $tagRegex) {
      $tag = $matches["tag"]
      $tags.Add($tag) | Out-Null
    }
  }

  [PSCustomObject]@{
    Tags = $tags
    DefaultTag  = $defaultTag
  }
}