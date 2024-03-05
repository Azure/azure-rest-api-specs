# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

try
{
    Push-Location (Join-Path $PSScriptRoot "../")
    nvm install 20
    nvm use 20
    npm install -g @typespec/compiler@latest
    tsp install
    # from https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/ci-fix.md
    try
    {
        npx tsc # emits and error but that's fine
    }
    catch {}
    npm install -g oav@latest
    npm install -g @azure/oad@latest
    npm install -g @azure/avocado@latest
    npm install -g prettier@latest
    npm install -g autorest@latest
}
finally
{
    Pop-Location
}
