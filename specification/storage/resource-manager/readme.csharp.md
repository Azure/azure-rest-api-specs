# C# Storage

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common C# Settings

``` yaml !$(MultiApi)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
clear-output-folder: true
payload-flattening-threshold: 2
output-folder: $(csharp-sdks-folder)/Storage/Management.Storage/Generated
namespace: Microsoft.Azure.Management.Storage  
```

## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(MultiApi)
namespace: Microsoft.Azure.Management.Storage.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2016-01
    ApiVersionName: Api2016_01_01

  - tag: package-2015-06
    ApiVersionName: Api2015_06_05
```