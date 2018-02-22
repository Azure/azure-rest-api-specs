# Addons
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Addons RP.



---
## Getting Started 
To build the SDK for Addons, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Addons API.

``` yaml
openapi-type: arm
tag: package-2017-05
```


### Tag: package-2017-05

These settings apply only when `--tag=package-2017-05` is specified on the command line.

``` yaml $(tag) == 'package-2017-05'
input-file:
- Microsoft.Addons/preview/2017-05-15/Addons.json
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
  namespace: Microsoft.Azure.Management.Addons
  output-folder: $(csharp-sdks-folder)/Addons/Management.Addons/Generated
  clear-output-folder: true
```
