# C# Web

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

## Common settings
These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.WebSites
output-folder: $(csharp-sdks-folder)/WebSites/Management.WebSites/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(MultiApi)
namespace: Microsoft.Azure.Management.WebSites.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
#For WebSite 2016-08-01, you use the below tag
  - tag: package-2016-09
    ApiVersionName: Api2016_08_01
```