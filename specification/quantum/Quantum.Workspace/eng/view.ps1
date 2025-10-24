# --------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for license information.
# --------------------------------------------------------------------------------------------

try
{
    Push-Location (Join-Path $PSScriptRoot "../")
    $openApi = Get-Content ../data-plane/Microsoft.Quantum/preview/2024-03-01-preview/quantum.json
    $spec = "var spec = $openApi"
    Set-Content ./eng/swagger-ui/spec.js $spec
    ./eng/swagger-ui/swagger-ui.html
}
finally
{
    Pop-Location
}
