# C# Authorization

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# Settings

``` yaml !$(MultiApi)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 1
clear-output-folder: true
namespace: Microsoft.Azure.Management.Authorization
output-folder: $(csharp-sdks-folder)/Authorization/Management.Authorization/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(MultiApi)
namespace: Microsoft.Azure.Management.Authorization.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2015-07
    ApiVersionName: Api2015_07_01
```