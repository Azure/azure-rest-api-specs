# Get latest commit id from main branch
$latestCommitId = git ls-remote origin main | Select-String -Pattern "refs/heads/main" | ForEach-Object { $_.ToString().Split("`t")[0] }
Write-Host "Latest commit id from main branch: $latestCommitId"

# I hardcode the project to KeyVault as it is a prototype
$serviceName = "keyvault"

# sparce checkout its resource-manager swagger folder, later we also add the data-plane folder
$repoUrl = "https://github.com/Azure/azure-rest-api-specs"
$directory = Resolve-Path (Join-Path $PSScriptRoot ".." "..")
$cloneDir = Join-Path $directory "sparse-spec" $serviceName
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

    Write-Host "Updating sparse checkout file with directory: specification/$serviceName/resource-manager"
    Add-Content .git/info/sparse-checkout "specification/$serviceName/resource-manager/"
    git sparse-checkout reapply
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    Write-Host "Checking out commit: $latestCommitId"
    git checkout $latestCommitId
    if ($LASTEXITCODE) { exit $LASTEXITCODE }
}
finally {
    Pop-Location
}

# Run tsp-compare
$lfs = Join-Path $cloneDir "specification/$serviceName/resource-manager/" "readme.md"
$rhs = Join-Path "specification/$serviceName/resource-manager/" "readme.md"
Write-Host "LFS: $lfs"
Write-Host "RHS: $rhs"

# It's easy for cutomers not to change anything in readme.md and not to delete any previous swagger
# So we need to check if the readme.md is changed

$readmeChanged = git diff --name-only $latestCommitId HEAD | Select-String -Pattern "readme.md"
if (!$readmeChanged) {
    throw "You need to change the readme.md file to have the generated swagger files"
}

Push-Location $directory
npm install
npx tsp-client compare -lfs $lfs -rhs $rhs 
Pop-Location
