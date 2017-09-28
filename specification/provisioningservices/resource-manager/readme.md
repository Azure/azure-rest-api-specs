# Provisioning Services
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Provisioning Services.



---
## Getting Started 
To build the SDK for ProvisioningServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the API.

``` yaml
openapi-type: arm
tag: package-2017-08
```

### Tag: package-2017-08

These settings apply only when `--tag=package-2017-08` is specified on the command line.

``` yaml $(tag) == 'package-2017-08'
input-file:
- Microsoft.Devices/2017-08-21-preview/iotdps.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.IotHub
  output-folder: $(csharp-sdks-folder)/ProvisioningServices/Management.ProvisioningServices/Generated
  clear-output-folder: true
```
