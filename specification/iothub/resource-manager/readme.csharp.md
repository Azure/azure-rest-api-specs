# C# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for IotHub.

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

### Profile: hybrid_2020_09_01

These settings apply only when `--csharp-profile=hybrid_2020_09_01` is specified on the command line.

``` yaml $(csharp-profile)=='hybrid_2020_09_01'
namespace: Microsoft.Azure.Management.Profiles.$(csharp-profile).IotHub
output-folder: $(csharp-sdks-folder)/$(csharp-profile)/EventHubs/Management.IotHub/Generated

batch:
  - tag: profile-hybrid-2020-09-01
```