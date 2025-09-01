# This script copies an api version and optionally generates the swagger. 
# Sample run .\CopyApiVersion.ps1 -tspDirectoryName "Dashboard.Management" -sourceApiVersion 2020-09-01-preview -targetApiVersion 2022-12-01-preview -generateSwagger $true
param(
    [Parameter(Mandatory=$true)]
    [string]$tspDirectoryName,
    [Parameter(Mandatory=$true)]
    [string]$sourceApiVersion,
    [Parameter(Mandatory=$true)]
    [string]$targetApiVersion,
    [bool] $runNpmCi = $false,
    [bool] $generateSwagger = $false
    )

function EditExampleJson {
    param(
        [string]$exampleFile,
        [string]$sourceApiVersion,
        [string]$targetApiVersion
    )

    $content = Get-Content $exampleFile
    if( $content -match $sourceApiVersion) {
        $modifiedContent = $content -replace $sourceApiVersion, $targetApiVersion
        Set-Content -Path $exampleFile -Value $modifiedContent
    }
}

function EditMainTspFile {
    param(
        [string]$tspServiceDirectoryPath,
        [string]$targetApiVersion
    )

    $mainTspFile = Join-Path $tspServiceDirectoryPath "main.tsp"
    $mainTspContent = Get-Content $mainTspFile -Raw

    $versionVariableName = "v$($targetApiVersion -replace "-", "_")"
    $addApiVersion = "
  /**
   * The $targetApiVersion API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  $($versionVariableName): `"$targetApiVersion`",
}"
    # Find the last index of "}"
    $lastIndex = $mainTspContent.LastIndexOf("}")

    # Split the content into two parts: before the last "}" and after
    $beforeLastBrace = $mainTspContent.Substring(0, $lastIndex)
    $afterLastBrace = $mainTspContent.Substring($lastIndex + 1)
    if([string]::IsNullOrWhiteSpace($afterLastBrace)){
        $afterLastBrace = ""
    }

    # Concatenate the first part, the addApiVersion string, and the second part
    $modifiedContent = $beforeLastBrace + $addApiVersion + $afterLastBrace

    # Write the modified content back to the file
    Set-Content -Path $mainTspFile -Value $modifiedContent
}

# Create example directory
$tspDirectoryRootPath = Join-Path -Path $PSScriptRoot -ChildPath ".." -Resolve
$tspServiceDirectoryPath = Join-Path $tspDirectoryRootPath $tspDirectoryName -Resolve
$tspExamplesDirectory = Join-Path $tspServiceDirectoryPath "examples" -Resolve

$sourceExamplesDirectory = Join-Path $tspExamplesDirectory $sourceApiVersion -Resolve
$targetExamplesDirectory = Join-Path $tspExamplesDirectory $targetApiVersion

# Create target example directory
if (-not (Test-Path $targetExamplesDirectory)) {
    Write-Host "Creating directory $targetExamplesDirectory"
    New-Item -ItemType Directory -Path $targetExamplesDirectory | Out-Null
}

Write-Host "Copying examples from $sourceExamplesDirectory to $targetExamplesDirectory"
Copy-Item -Path "$sourceExamplesDirectory\*" -Destination $targetExamplesDirectory -Recurse -Force

# Edit Example file
Write-Host "Editing example files api versions"
Get-ChildItem -Path $targetExamplesDirectory -Recurse -Filter "*.json" | ForEach-Object {
    EditExampleJson -exampleFile $_.FullName -sourceApiVersion $sourceApiVersion -targetApiVersion $targetApiVersion
}

# Edit main.tsp
Write-Host "Editing main.tsp file"
EditMainTspFile -tspServiceDirectoryPath $tspServiceDirectoryPath -targetApiVersion $targetApiVersion

# # Generate Swagger
if( $runNpmCi) {
    Write-Host "Running npm ci"
    & npm ci
}
if( $generateSwagger) {
    Write-Host "Generating Swagger files for $tspDirectoryName"

    & npx tsv $tspServiceDirectoryPath
}