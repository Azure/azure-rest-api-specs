# C# KeyVault

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.KeyVault
output-folder: $(csharp-sdks-folder)/KeyVault/Management/Management.KeyVault/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(multiApi)
namespace: Microsoft.Azure.Management.KeyVault.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2016-10
    ApiVersionName: Api2016_10_01
```