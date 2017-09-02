# ServerManagement
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServerManagement.



---
## Getting Started 
To build the SDK for ServerManagement, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ServerManagement API.

``` yaml
openapi-type: arm
tag: package-2016-07-preview
```


### Tag: package-2016-07-preview

These settings apply only when `--tag=package-2016-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-07-preview'
input-file:
- Microsoft.ServerManagement/2016-07-01-preview/servermanagement.json
```
 
### Tag: package-2015-07-preview

These settings apply only when `--tag=package-2015-07-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-07-preview'
input-file:
- Microsoft.ServerManagement/2015-07-01-preview/servermanagement.json
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
  namespace: Microsoft.Azure.Management.ServerManagement
  output-folder: $(csharp-sdks-folder)/ServerManagement/Management.ServerManagement/Generated
  clear-output-folder: true
```