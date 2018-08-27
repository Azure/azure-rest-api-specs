# C# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings


``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiApi)
namespace: Microsoft.Azure.Management.Compute
output-folder: $(csharp-sdks-folder)/Compute/Management.Compute/Generated
```













## Batch settings
These settings are for batch mode only: (ie, add `--MultiApi` to the command line )

``` yaml $(multiApi)
namespace: Microsoft.Azure.Management.Compute.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2017-03
    ApiVersionName: Api2017_03_30

  - tag: package-2016-03
    ApiVersionName: Api2016_03_30
```