# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

# Regenerate the Python SDK client from the private swagger

$VerbosePreference = 'Continue'
$outputFolder = "/clients/python-from-swagger"
$packageVersion = "0.0.1"

try
{
    Push-Location (Join-Path $PSScriptRoot "../")
    $autoRestConfig = Resolve-Path "../data-plane/readme.md"

    $outputDirectory = Join-Path (Resolve-Path .) "/output/"
    New-Item -ItemType Directory -Force -Path $outputDirectory *> $null
    Push-Location "./output"
    try
    {
        $pythonClientDirectory = Join-Path (Resolve-Path .) $outputFolder
        Remove-Item -Path $pythonClientDirectory -Recurse -Force *> $null
        New-Item -ItemType Directory -Force -Path $pythonClientDirectory *> $null

        autorest $autoRestConfig `
            --verbose `
            --python `
            --python-mode=pythonSdk `
            --output-folder=$pythonClientDirectory `
            --package-version=$packageVersion `
            *>&1
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

