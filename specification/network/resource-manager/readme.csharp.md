# C# Network

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common Settings

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common Settings
``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.Network
output-folder: $(csharp-sdks-folder)/Network/Management.Network/Generated
```

## MultiApi settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(multiApi)
namespace: Microsoft.Azure.Management.Network.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2017-10
    ApiVersionName: Api2017_10_01

  - tag: package-2015-06split
    ApiVersionName: Api2016_06_15
```