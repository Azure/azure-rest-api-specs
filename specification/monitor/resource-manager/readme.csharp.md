# C# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for DNS.

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp) && !$(multiapi) && !$(csharp-profile)
csharp:
  azure-arm: true
  payload-flattening-threshold: 1
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Monitor
  output-folder: $(csharp-sdks-folder)/monitor/Microsoft.Azure.Management.Monitor/src/Generated
  clear-output-folder: true
```

### Profile: hybrid_2019_03_01

These settings apply only when `--csharp-profile=hybrid_2019_03_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2019_03_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).Monitor
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/Monitor/Management.Monitor/Generated

batch:
 - tag: profile-hybrid-2019-03-01
 ```