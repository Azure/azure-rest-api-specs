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

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.Network
output-folder: $(csharp-sdks-folder)/network/Microsoft.Azure.Management.Network/src/Generated
```

## MultiApi settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.Network.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
  - tag: package-2017-10
    ApiVersionName: Api2017_10_01

  - tag: package-2015-06split
    ApiVersionName: Api2016_06_15
```

### Profile: hybrid_2018_03_01

These settings apply only when `--csharp-profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Network
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Network/Management.Network/Generated
batch:
  - tag: package-2017-10
```

### Profile: profile_2017_03_09

These settings apply only when `--csharp-profile=profile_2017_03_09` is specified on the command line.

``` yaml $(csharp-profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Network
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Network/Management.Network/Generated

batch:
 - tag: package-2015-06split
 ```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Network
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Network/Management.Network/Generated

batch:
 - tag: profile-hybrid-2019-03-01
 ```