# MediaServices
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for MediaServices.



---
## Getting Started 
To build the SDK for MediaServices, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the MediaServices API.

``` yaml
openapi-type: arm
tag: package-2015-10
```


### Tag: package-2015-10

These settings apply only when `--tag=package-2015-10` is specified on the command line.

``` yaml $(tag) == 'package-2015-10'
input-file:
- Microsoft.Media/2015-10-01/media.json
```

---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated from commit 3586e2989d502434c4f607dd38d40e46aabede5c
  azure-arm: true
  payload-flattening-threshold: 2
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Media
  output-folder: $(csharp-sdks-folder)/Media/Management.Media/Generated
  clear-output-folder: true
```