# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

# Regenerate the Python SDK client from the private swagger

$VerbosePreference = 'Continue'

try
{
    Push-Location (Join-Path $PSScriptRoot "../")

    $outputDirectory = Join-Path (Resolve-Path .) "/output/"
    New-Item -ItemType Directory -Force -Path $outputDirectory *> $null
    Push-Location "./output"
    try
    {
        $tempDirectory = Join-Path (Resolve-Path .) "/temp/"
        Remove-Item -Path $tempDirectory -Recurse -Force *> $null
        New-Item -ItemType Directory -Force -Path $tempDirectory *> $null

        $pythonClientDirectory = Join-Path (Resolve-Path .) "/clients/python/"
        Remove-Item -Path $pythonClientDirectory -Recurse -Force *> $null
        New-Item -ItemType Directory -Force -Path $pythonClientDirectory *> $null

        # Get-ChildItem -Path "../" -Include *.tsp,*.json -Recurse | ForEach-Object { 
        #     Copy-Item -Path $_.FullName -Destination $tempDirectory
        # }

        Copy-Item "../common/" $tempDirectory -Force -Recurse
        Copy-Item "../operations/" $tempDirectory -Force -Recurse
        Copy-Item "../*.tsp" $tempDirectory -Force -Recurse
        Copy-Item "../tspconfig.yaml" $tempDirectory -Force -Recurse

        $tempCheckoutDirectory = Join-Path (Resolve-Path .) "/temp-checkout/"
        Remove-Item -Path $tempCheckoutDirectory -Recurse -Force *> $null
        New-Item -ItemType Directory -Force -Path $tempCheckoutDirectory *> $null
        Push-Location $tempCheckoutDirectory
        try
        {
            $sdkRepo = "azure-sdk-for-python"
            git clone --no-checkout --depth 1 --filter=blob:none --single-branch --branch=main  "https://github.com/Azure/$sdkRepo.git"
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
            tsp compile . --emit=@azure-tools/typespec-python --options "@azure-tools/typespec-python.emitter-output-dir=$pythonClientDirectory"
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
}
finally
{
    Pop-Location
}

