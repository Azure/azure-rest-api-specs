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

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.KeyVault
output-folder: $(csharp-sdks-folder)/keyvault/Microsoft.Azure.Management.KeyVault/src/Generated
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

### Profile: hybrid_2018_03_01

These settings apply only when `--csharp-profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).KeyVault
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/KeyVault/Management.KeyVault/Generated

batch:
  - tag: package-2016-10
  - tag: package-2015-06
```

### Profile: profile_2017_03_09

These settings apply only when `--csharp-profile=profile_2017_03_09` is specified on the command line.

``` yaml $(csharp-profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).KeyVault
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/KeyVault/Management.KeyVault/Generated

batch:
 - tag: package-2016-10
 ```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).KeyVault
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/KeyVault/Management.KeyVault/Generated

batch:
 - tag: profile-hybrid-2019-03-01
 ```