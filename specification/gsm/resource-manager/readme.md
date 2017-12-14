# gsm
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for gsm RP.



---
## Getting Started 
To build the SDK for gsm, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the gsm API.

``` yaml
openapi-type: arm
tag: package-2018-02
```


### Tag: package-2018-02

These settings apply only when `--tag=package-2018-02` is specified on the command line.

``` yaml $(tag) == 'package-2018-02'
input-file:
- Microsoft.ManagementPartner\2018-02-01\gsm.json
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
  namespace: Microsoft.Azure.Management.GSM
  output-folder: $(csharp-sdks-folder)/GSM/Management.Partner/Generated
  clear-output-folder: true
```
