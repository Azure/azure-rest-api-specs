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

``` yaml $(csharp) && !$(multiapi) && !$(profile)
namespace: Microsoft.Azure.Management.KeyVault
output-folder: $(csharp-sdks-folder)/KeyVault/Management/Management.KeyVault/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.KeyVault.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2016-10
    ApiVersionName: Api2016_10_01
```

```yaml $(profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(profile).KeyVault
output-folder: $(csharp-sdks-folder)/$(profile)/KeyVault/Management.KeyVault/Generated

batch:
  - tag: package-2016-10
  - tag: package-2015-06
```

``` yaml $(profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(profile).KeyVault
output-folder: $(csharp-sdks-folder)/$(profile)/KeyVault/Management.KeyVault/Generated

batch:
 - tag: package-2016-10
 ```