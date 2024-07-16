# C# HybridCompute

> see https://aka.ms/autorest

This is the AutoRest configuration file for HybridCompute.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.HybridCompute
  output-folder: $(csharp-sdks-folder)/HybridCompute/Microsoft.Azure.Management.HybridCompute/src/Generated
  clear-output-folder: true
directive:
  - remove-operation: 
    - Machines_Reconnect
    - Machines_CreateOrUpdate
    - Machines_Update
```
