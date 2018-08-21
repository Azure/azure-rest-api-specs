# AzureAttestation
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureAttestation RP.



---
## Getting Started 
To build the SDK for AzureAttestation, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the AzureAttestation API.

``` yaml
openapi-type: arm
tag: package-2017-11
```

### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11` is specified on the command line.

``` yaml $(tag) == 'package-2017-11'
input-file:
- Microsoft.AzureAttestation/preview/2017-11-01/AzureAttestation.json
```

---
# Code Generation


---
## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.AzureAttestation
  output-folder: $(csharp-sdks-folder)/AzureAttestation/Management.AzureAttestation/Generated
  clear-output-folder: true
```


