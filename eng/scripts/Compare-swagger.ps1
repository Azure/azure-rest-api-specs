. $PSScriptRoot/ChangedFiles-Functions.ps1
. $PSScriptRoot/../common/scripts/logging.ps1

function Get-AddedConfigurationFiles($latestCommitId, $currentCommitId) {
    return (Get-ChangedFiles $latestCommitId $currentCommitId "cdmrtuxb").Where({ 
        $_.EndsWith("tspconfig.yaml")
    })
}

function Download-Swagger-InMain($serviceName, $latestCommitId) {
    # sparce checkout its resource-manager swagger folder, later we also add the data-plane folder
    $repoUrl = "https://github.com/Azure/azure-rest-api-specs"
    $repoRoot = Resolve-Path (Join-Path $PSScriptRoot ".." "..")
    $cloneDir = Join-Path $repoRoot "sparse-spec" $serviceName
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

        return Join-Path $cloneDir "specification/$serviceName/resource-manager/"
    }
    finally {
        Pop-Location
    }
}

function Get-Swagger($readme) {
    $tag = Get-Content -Path $readme | Select-String -Pattern "^tag: "
    if ($tag.Count -gt 1) {
        throw "There are multiple tags in the readme file. Please remove the extra ones"
    }
    $tag = $tag[0].ToString().Split(": ")[1]

    # Find out yaml block starting with the tag
    $block = Extract-YamlBlock $readme $tag
    return $block
}

function Extract-YamlBlock($readmeFilePath, $tag) {
    # Read the content of the readme file
    $content = Get-Content -Path $readmeFilePath

    # Initialize variables
    $isInBlock = $false
    $yamlBlock = @()

    # Loop through each line in the file
    foreach ($line in $content) {
        if ($line -match '^```\s*yaml\s*\$\(tag\)\s*==.*' + $tag + '.*') {
            $isInBlock = $true
            continue
        }
        if ($isInBlock -and $line -match '^```\s*') {
            $isInBlock = $false
            break
        }
        if ($isInBlock) {
            $yamlBlock += $line
        }
    }

    return $yamlBlock
}

# Get latest commit id from main branch
# $latestCommitId = git ls-remote origin main | Select-String -Pattern "refs/heads/main" | ForEach-Object { $_.ToString().Split("`t")[0] }
# These two commits seems different in the PR, so I hardcode it for now
$latestCommitId = "cccd214128449efff36c3a73b7275c72f0e63d0a"
Write-Host "Latest commit id from main branch: $latestCommitId"

# Get current head commit id
$currentCommitId = git rev-parse HEAD
Write-Host "Current commit id: $currentCommitId"

# [Maybe we just use tag] If there is any added tspconfig.yaml file and existing readme file, then it is a migration PR
# Why I choose this criterion is because I want to differiate it from 
# 1. TypeSpec exists before and this PR is just to change the existing TypeSpec
# 2. Customers don't delete any existing swagger files or don't change any existing readme
# 3. The generated swagger file has the same name as before 
# 4. This is a new service starting from TypeSpec
# I also considered "if previous swagger doesn't have auto-generated x-typespec-generated and current swagger has it", but if user doesn't change the readme file, how do we know which one is the current swagger?
$addedConfigurationFiles = Get-AddedConfigurationFiles $latestCommitId $currentCommitId
if ($addedConfigurationFiles.Count -gt 0) {
    Write-Host "This is a migration PR. Check api by comparison tool"

    $serviceName = ""
    $addedConfigurationFiles | ForEach-Object {
        $name = $_.Split("/")[1]
        if ($serviceName -ne "" -and $serviceName -ne $name) {
            throw "You can only migrate for one service in one PR"
        }
        $serviceName = $name
    }
    
    Write-Host "Service name: $serviceName"

    $swaggerInMain = Download-Swagger-InMain $serviceName $latestCommitId
    $readmeInMain = Join-Path $swaggerInMain "readme.md"
    $swaggerFilesInMain = Get-Swagger $readmeInMain
    $swaggerPathInMain = @()
    for ($index = 1; $index -lt $swaggerFilesInMain.Count; $index++) {
        $swaggerFile = $swaggerFilesInMain[$index]
        $swaggerFile = $swaggerFile.Substring($swaggerFile.IndexOf("Microsoft"))
        $swaggerPath = Join-Path $swaggerInMain $swaggerFile

        $swaggerPathInMain += $swaggerPath
    }
    $swaggerPathInMain = $swaggerPathInMain -join " "
    Write-Host "Swagger files in main: $swaggerPathInMain"

    # [Problem] It's possible that customers don't change anything in readme.md. Here parsing the readme file in HEAD might be a problem.
    # We make sure they change the readme file in the PR by TypeSpec validation ?? Seems not.
    # Or is it allowed to delete the reamdme file in the migration PR?
    # We add a check that the swagger in the readme should be the same as the one in the tspconfig?
    $readmeInHead = Resolve-Path -Path (Join-Path $PSScriptRoot ".." ".." "specification" $serviceName "resource-manager" "readme.md")
    $swaggerFileInHead = Get-Swagger $readmeInHead
    $swaggerPathInHead = Join-Path (Split-Path -Path $readmeInHead) $swaggerFileInHead[1].Substring($swaggerFileInHead[1].IndexOf("Microsoft"))
    Write-Host "Swagger file in head: $swaggerPathInHead"

    $repoRoot = Resolve-Path (Join-Path $PSScriptRoot ".." "..")
    Push-Location $repoRoot
    npm install
    npx tsp-client compare -lfs $swaggerPathInMain -rhs $swaggerPathInHead
    Pop-Location
}
