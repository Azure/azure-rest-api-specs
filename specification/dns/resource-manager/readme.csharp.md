# C# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  clear-output-folder: true
```

### Profile: hybrid_2018_03_01

These settings apply only when `--csharp-profile=hybrid_2018_03_01` is specified on the command line.

```yaml $(csharp-profile)=='hybrid_2018_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Dns
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Dns/Management.Dns/Generated

batch:
  - tag: package-2016-04

skip-simplifier-on-namespace: 
  - System.Net
```

### Profile: profile_2017_03_09

These settings apply only when `--csharp-profile=profile_2017_03_09` is specified on the command line.

``` yaml $(csharp-profile)=='profile_2017_03_09'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Dns
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Dns/Management.Dns/Generated

batch:
  - tag: package-2016-04

skip-simplifier-on-namespace: 
  - System.Net
```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Dns
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Dns/Management.Dns/Generated

batch:
  - tag: profile-hybrid-2019-03-01

skip-simplifier-on-namespace: 
  - System.Net
```