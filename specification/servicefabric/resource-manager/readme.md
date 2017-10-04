# ServiceFabricClient
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ServiceFabricClient.



---
## Getting Started 
To build the SDK for ServiceFabricClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ServiceFabricClient API.

``` yaml
openapi-type: arm
tag: package-2017-07
```


### Tag: package-2016-09

These settings apply only when `--tag=package-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-2016-09'
input-file:
- Microsoft.ServiceFabric/2016-09-01/servicefabric.json
```

### Tag: package-2017-07

These settings apply only when `--tag=package-2017-07` is specified on the command line.

``` yaml $(tag) == 'package-2017-07'
input-file:
- Microsoft.ServiceFabric/2017-07-01-preview/servicefabric.json
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
  namespace: Microsoft.Azure.Management.ServiceFabric
  output-folder: $(csharp-sdks-folder)/ServiceFabric/Management.ServiceFabric/Generated
  clear-output-folder: true
```