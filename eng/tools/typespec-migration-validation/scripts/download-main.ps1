param(
  [string]$swaggerPath,
  [string]$callValidation = $false
)

. $PSScriptRoot/../../../scripts/ChangedFiles-Functions.ps1
function Download-Swagger-InMain($swaggerFolder, $latestCommitId) {
  # sparce checkout its resource-manager swagger folder, later we also add the data-plane folder
  $repoUrl = "https://github.com/Azure/azure-rest-api-specs"
  $repoRoot = git rev-parse --show-toplevel
  $cloneDir = Join-Path $repoRoot "sparse-spec"
  if (!(Test-Path $cloneDir)) {
    New-Item -Path $cloneDir -ItemType Directory | Out-Null
  }

  Push-Location $cloneDir
  try {
    if (!(Test-Path ".git")) {
      git clone --no-checkout --filter=tree:0 $repoUrl . | Out-Null
      if ($LASTEXITCODE) { exit $LASTEXITCODE }
      git sparse-checkout init | Out-Null
      if ($LASTEXITCODE) { exit $LASTEXITCODE }
      Remove-Item .git/info/sparse-checkout -Force
    }

    Add-Content .git/info/sparse-checkout $swaggerFolder
    git sparse-checkout reapply | Out-Null
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    git checkout $latestCommitId | Out-Null
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    return Join-Path $cloneDir $swaggerFolder
  }
  finally {
    Pop-Location
  }
}

if ($swaggerPath -eq "") {
  # Get all changed swagger files
  $changedSwaggers = Get-ChangedSwaggerFiles
  if ($changedSwaggers.Count -eq 0) {
    Write-Host "No swagger files changed."
    exit 0
  }

  $changedSwaggers | ForEach-Object {
    try {
      $content = Get-Content $_ -Raw
      $jsonContent = $content | ConvertFrom-Json

      # Check if the swagger is TypeSpec generated
      if ($null -ne $jsonContent.info -and $jsonContent.info.'x-typespec-generated' -ne $null){
        $swaggerPath = $_
      }
    }
    catch {
      Write-Warning "Failed to parse JSON from $_. Error: $($_.Exception.Message)"
      continue
    }
  }
}

if ($swaggerPath -eq "") {
  Write-Host "No TypeSpec generated swagger file found."
  exit 1
}

# Get latest commit id from main branch
$latestCommitId = git ls-remote "https://github.com/Azure/azure-rest-api-specs.git" main | Select-String -Pattern "refs/heads/main" | ForEach-Object { $_.ToString().Split("`t")[0] }

$swaggerFolder = ""
$swaggerPath = $swaggerPath.Replace("\", "/")
if ($swaggerPath -match "specification/([a-z]*)/resource-manager/(.*)/(stable|preview)/([a-z0-9-]+)/(.*).json") {
  $swaggerFolder = "specification/$($matches[1])/resource-manager/$($matches[2])/$($matches[3])/$($matches[4])/"
}
else {
  Write-Host "Please provide the path of the swagger that generated from your TypeSpec."
  exit 1
}

$swaggerInMain = Download-Swagger-InMain $swaggerFolder $latestCommitId

$repoRoot = git rev-parse --show-toplevel
if ($swaggerPath.StartsWith("specification")) {
  $swaggerPath = Join-Path $repoRoot $swaggerPath
}

if ($callValidation -eq $true) {
  npx tsmv $swaggerInMain $swaggerPath
}
else {
  Write-Host "Your next command: npx tsmv $swaggerInMain $swaggerPath {outputFolder}"
}

