# PowerBIDedicated
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for PowerBIDedicated.



---
## Getting Started 
To build the SDK for PowerBIDedicated, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the PowerBIDedicated API.

``` yaml
openapi-type: arm
tag: package-2017-10-01
```


### Tag: package-2017-10-01

These settings apply only when `--tag=package-2017-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-01'
input-file:
- Microsoft.PowerBIdedicated/2017-10-01/powerbidedicated.json
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
  namespace: Microsoft.Azure.Management.PowerBIDedicated
  output-folder: $(csharp-sdks-folder)/PowerBIDedicated/Management.PowerBIDedicated/Generated
  clear-output-folder: true
```

