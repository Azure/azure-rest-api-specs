# Security Center
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Security.



---
## Getting Started 
To build the SDK for Security, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Security API.

``` yaml
openapi-type: arm
tag: package-composite-v1
```


### Tag: package-composite-v1

These settings apply only when `--tag=package-composite-v1` is specified on the command line.

``` yaml $(tag) == 'package-composite-v1'
input-file:
- Microsoft.Security/preview/2017-08-01-preview/security.json
- Microsoft.Security/preview/2015-06-01-preview/security.json
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
  namespace: Microsoft.Azure.Management.Security
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/Security/Management.Security/Generated
  clear-output-folder: true
```