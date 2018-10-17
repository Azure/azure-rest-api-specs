# C# Subscription

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.


These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# Settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION  
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(profile)
namespace: Microsoft.Azure.Management.Subscription
output-folder: $(csharp-sdks-folder)/Subscription/Management.Subscription/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.Subscription.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
   - tag: package-2018-03-preview
     ApiVersionName: Api2018_03_01
```

```yaml $(profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(profile).Subscription
output-folder: $(csharp-sdks-folder)/$(profile)/Subscription/Management.Subscription/Generated
batch:
  - tag: package-2017-11-preview
```