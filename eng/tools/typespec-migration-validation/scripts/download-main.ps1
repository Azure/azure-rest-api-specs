param(
  [Parameter(Mandatory = $true)]
  [string]$swaggerPath
)

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
      Write-Host "Initializing sparse clone for repo: $repoUrl"
      git clone --no-checkout --filter=tree:0 $repoUrl .
      if ($LASTEXITCODE) { exit $LASTEXITCODE }
      git sparse-checkout init
      if ($LASTEXITCODE) { exit $LASTEXITCODE }
      Remove-Item .git/info/sparse-checkout -Force
    }

    Write-Host "Updating sparse checkout file with directory: $swaggerFolder"
    Add-Content .git/info/sparse-checkout $swaggerFolder
    git sparse-checkout reapply
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    Write-Host "Checking out commit: $latestCommitId"
    git checkout $latestCommitId
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    return Join-Path $cloneDir $swaggerFolder
  }
  finally {
    Pop-Location
  }
}

# Get latest commit id from main branch
$latestCommitId = git ls-remote "https://github.com/Azure/azure-rest-api-specs.git" main | Select-String -Pattern "refs/heads/main" | ForEach-Object { $_.ToString().Split("`t")[0] }
Write-Host "Latest commit id from main branch: $latestCommitId"

$swaggerFolder = ""
$swaggerPath = $swaggerPath.Replace("\", "/")
if ($swaggerPath -match ".*/specification/([a-z]*)/resource-manager/(.*)/(stable|preview)/([a-z0-9-]+)/(.*).json") {
  $swaggerFolder = "specification/$($matches[1])/resource-manager/$($matches[2])/$($matches[3])/$($matches[4])/"
  Write-Host "Swagger folder: $swaggerFolder"
}
else {
  Write-Host "Please provide the path of the swagger that generated from your TypeSpec."
  exit 1
}

$swaggerInMain = Download-Swagger-InMain $swaggerFolder $latestCommitId

Write-Host "Your next command: npx tsmv $swaggerInMain $swaggerPath {outputFolder}"

