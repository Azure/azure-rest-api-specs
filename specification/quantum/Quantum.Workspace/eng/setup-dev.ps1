# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

# Install and use Node v20
#nvm install 20 2>&1 | Write-Host
#nvm use 20 2>&1 | Write-Host

# Install AutoRest and some validation tools
npm install -g autorest@latest 2>&1 | Write-Host
npm install -g oav@latest 2>&1 | Write-Host
npm install -g @azure/oad@latest 2>&1 | Write-Host
npm install -g @azure/avocado@latest 2>&1 | Write-Host
npm install -g @azure-tools/typespec-client-generator-cli

# Install TypeSpec compiler and VS Code extension
npm install -g @typespec/compiler@latest 2>&1 | Write-Host
tsp code install 2>&1 | Write-Host

# Install azure-rest-api-specs common dependencies
try
{
    # go to the root of the azure-rest-api-specs repo
    Push-Location (Join-Path $PSScriptRoot "../../../../")
    npm ci 2>&1 | Write-Host
}
finally
{
    Pop-Location
}
