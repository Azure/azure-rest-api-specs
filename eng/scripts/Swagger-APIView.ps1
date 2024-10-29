
<#
.DESCRIPTION
  Generated New and Baseline APIView tokens for the changed swagger files in the PR.
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
param (
    [Parameter(Mandatory = $true)]
    [string]$TempDirectory,
    [Parameter(Mandatory = $true)]
    [string]$ArtiFactsStagingDirectory,
    [Parameter(Mandatory = $true)]
    [string]$APIViewArtifactsDirectoryName
)

. "$PSScriptRoot/ChangedFiles-Functions.ps1"
. "$PSScriptRoot/Logging-Functions.ps1"

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

      LogDebug " $command $arguments"
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

$SourceCommitId = $(git rev-parse HEAD^)
$TargetCommitId = $(git rev-parse HEAD)

# Get Changed Swagger Files
LogDebug " Getting changed swagger files in PR, between $SourceCommitId and $TargetCommitId"
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