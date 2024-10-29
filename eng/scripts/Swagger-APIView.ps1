param (
    [Parameter(Mandatory = $true)]
    [string]$TempDirectory,
    [Parameter(Mandatory = $true)]
    [string]$ArtiFactsDirectory
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
    New-Item -ItemType Directory -Path $tempWorkingDirectoryPath

    Set-Location -Path $tempWorkingDirectoryPath

    try {
      # Generate Swagger APIView tokens
      $command = "& dotnet swaggerAPIParser --readme $readMeFile --package-name $resourceProvider --use-tag-for-output"

      if ($Tag) {
          $command += " --tag $Tag"
      }
        
      Invoke-Expression $command
      $generatedAPIViewTokenFile = Get-ChildItem -Path $tempWorkingDirectoryPath -File | Select-Object -First 1
      $readMeTag = $generatedAPIViewTokenFile.BaseName

      LogSuccess " Generated '$Type' APIView Token File using file, '$readMeFile' and tag '$readMeTag'"

      $apiViewTokensFilePath = [System.IO.Path]::Combine($TokenDirectory, "$resourceProvider.$Type.json")
      Move-Item -Path $generatedAPIViewTokenFile.FullName -Destination $apiViewTokensFilePath -Force
      return $readMeTag
    } catch {
      LogError " Failed to generate '$Type' APIView Tokens using '$readMeFile' for '$resourceProvider'"
      throw
    } finally {
      if (Test-Path -Path $tempWorkingDirectoryPath) {
        Remove-Item -Path $tempWorkingDirectoryPath -Recurse -Force
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

LogGroupStart " Pullrequest has changes in these swagger files."
$changedSwaggerFiles | ForEach-Object {
  LogInfo " $_"
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

LogGroupStart " Swagger APIView Tokens will be generated for the following configuration files."
$readmeFile | ForEach-Object {
  LogInfo " $_"
}
LogGroupEnd

$currentBranch = git rev-parse --abbrev-ref HEAD

# Generate Swagger APIView Tokens
foreach ($readMeFile in $swaggerReadMeFiles) {
    $resourceProvider = Get-ResourceProviderFromReadMePath -ReadMeFilePath $readMeFile
    $tokenDirectory = [System.IO.Path]::Combine($ArtiFactsDirectory, $resourceProvider)
    New-Item -ItemType Directory -Path $tokenDirectory

    LogDebug " Generating APIView Tokens using '$readMeFile' for '$resourceProvider'"

    # Generate New APIView Token using default tag on base branch
    git checkout $SourceCommitId
    $defaultTag = Invoke-SwaggerAPIViewParser -Type "New" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory

    # Generate BaseLine APIView Token using same tag on target branch
    get chekout $TargetCommitId
    Invoke-SwaggerAPIViewParser -Type "Baseline" -ReadMeFilePath $readMeFile -ResourceProvider $resourceProvider -TokenDirectory $tokenDirectory -Tag $defaultTag | Out-Null
}

git checkout $currentBranch