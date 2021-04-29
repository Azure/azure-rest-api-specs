# C# DPS

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Device Provisioning Service.

## C# common settings

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 1
  client-side-validation: false
  clear-output-folder: true
  namespace: Microsoft.Azure.Management.DeviceProvisioningServices
  output-folder: $(csharp-sdks-folder)/deviceprovisioningservices/Microsoft.Azure.Management.DeviceProvisioningServices/src/Generated
```
