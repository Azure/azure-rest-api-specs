# Attestation
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Attestation.



---
## Getting Started 
To build the SDK for Attestation, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Attestation API.

``` yaml
openapi-type: arm
tag: package-2018-09
```

### Tag: package-2018-09

These settings apply only when `--tag=package-2018-09` is specified on the command line.

``` yaml $(tag) == 'package-2018-09'
input-file:
- Microsoft.Attestation/2018-09-01-preview/attestation.json
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
  namespace: Microsoft.Azure.Management.Attestation
  output-folder: $(csharp-sdks-folder)/attestation/Microsoft.Azure.Management.Attestation/src/Generated
  clear-output-folder: true
```


