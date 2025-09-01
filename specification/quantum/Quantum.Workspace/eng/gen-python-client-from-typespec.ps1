# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

# Regenerate the Python SDK client from the private swagger

Import-Module (Join-Path $PSScriptRoot "./common.psm1")
$outputFolder = "./output/python-from-typespec/"

$outputDirectory = Join-Path (Resolve-Path (Join-Path $PSScriptRoot "../")) $outputFolder
Remove-Item -Path $outputDirectory -Recurse -Force *> $null
New-Item -ItemType Directory -Force -Path $outputDirectory *> $null

$logDirectory = Join-Path $outputDirectory "./logs"
Remove-Item -Path $outputDirectory -Recurse -Force *> $null
New-Item -ItemType Directory -Force -Path $logDirectory *> $null

$tempDirectory = Join-Path $outputDirectory "./temp"
Remove-Item -Path $tempDirectory -Recurse -Force *> $null
New-Item -ItemType Directory -Force -Path $tempDirectory *> $null

$pythonClientDirectory = Join-Path $outputDirectory $outputFolder
Remove-Item -Path $pythonClientDirectory -Recurse -Force *> $null
New-Item -ItemType Directory -Force -Path $pythonClientDirectory *> $null

$typespecFolder = Resolve-Path (Join-Path $PSScriptRoot "..")
Copy-Item "$typespecFolder/common/" $tempDirectory -Force -Recurse
Copy-Item "$typespecFolder/operations/" $tempDirectory -Force -Recurse
Copy-Item "$typespecFolder/*.tsp" $tempDirectory -Force -Recurse
Copy-Item "$typespecFolder/tspconfig.yaml" $tempDirectory -Force -Recurse

$tempCheckoutDirectory = Join-Path $outputDirectory "./temp-checkout/"
Remove-Item -Path $tempCheckoutDirectory -Recurse -Force *> $null
New-Item -ItemType Directory -Force -Path $tempCheckoutDirectory *> $null

Push-Location $tempCheckoutDirectory
try
{
    $sdkRepo = "azure-sdk-for-python"
    git clone `
        --no-checkout `
        --depth 1 `
        --filter=blob:none `
        --single-branch `
        --branch=main `
        "https://github.com/Azure/$sdkRepo.git"
    Push-Location $sdkRepo
    try
    {
        git sparse-checkout init --cone
        git sparse-checkout set eng
        git checkout
        Copy-Item "./eng/emitter-package.json" (Join-Path $tempDirectory "./package.json") -Force -Recurse
        Copy-Item "./eng/emitter-package-lock.json" (Join-Path $tempDirectory "./package-lock.json") -Force -Recurse
    }
    finally
    {
        Pop-Location
    }
}
finally
{
    Pop-Location
}

Push-Location $tempDirectory
try
{
    npm install
    tsp compile . `
        --emit=@azure-tools/typespec-python `
        --options

    Copy-Item "./tsp-output/@azure-tools/typespec-python/azure/quantum/" "../python-client" -Force -Recurse
}
finally
{
    Pop-Location
}
