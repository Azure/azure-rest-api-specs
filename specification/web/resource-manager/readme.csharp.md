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

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
namespace: Microsoft.Azure.Management.WebSites
output-folder: $(csharp-sdks-folder)/websites/Microsoft.Azure.Management.WebSites/src/Generated
```

## Batch settings
These settings are for batch mode only: (ie, add `--multiapi` to the command line )

``` yaml $(multiapi)
namespace: Microsoft.Azure.Management.WebSites.$(ApiVersionName)
output-folder: $(csharp-sdks-folder)/$(ApiVersionName)/Generated

batch:
#For WebSite 2016-08-01, you use the below tag
  - tag: package-2016-09
    ApiVersionName: Api2016_08_01
  - tag: package-2019-08
    ApiVersionName: Api2019_08_01
```

### Profile: hybrid_2018_03_01

These settings apply only when `--csharp-profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).WebSites
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Websites/Management.Websites/Generated
batch:
  - tag: package-2018-03-01-hybrid-csharp
```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).WebSites
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Websites/Management.Websites/Generated
batch:
  - tag: profile-hybrid-2019-03-01
```