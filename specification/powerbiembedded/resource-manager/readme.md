# PowerBI
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for PowerBI.



---
## Getting Started 
To build the SDK for PowerBI, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the PowerBI API.

``` yaml
openapi-type: arm
tag: package-2016-01
```


### Tag: package-2016-01

These settings apply only when `--tag=package-2016-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-01'
input-file:
- Microsoft.PowerBI/2016-01-29/powerbiembedded.json
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
  namespace: Microsoft.Azure.Management.PowerBIEmbedded
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/PowerBIEmbedded/Management.PowerBIEmbedded/Generated
  clear-output-folder: true
```