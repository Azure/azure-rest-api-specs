## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(profile)
  namespace: Microsoft.Azure.Management.Security
  output-folder: $(csharp-sdks-folder)/securitycenter/Microsoft.Azure.Management.SecurityCenter/src/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.Security.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-composite-v1
    ApiVersionName: package_composite_v1

  - tag: package-composite-v2
    ApiVersionName: package_composite_v2
```