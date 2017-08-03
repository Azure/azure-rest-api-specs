# ContainerInstance
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerInstance.



---
## Getting Started 
To build the SDK for ContainerInstance, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ContainerInstance API.

``` yaml
openapi-type: arm
tag: package-2017-08-preview
```


### Tag: package-2017-08-preview

These settings apply only when `--tag=package-2017-08-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-08-preview'
input-file:
- Microsoft.ContainerInstance/2017-08-01-preview/containerInstance.json
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
  namespace: Microsoft.Azure.Management.ContainerInstance
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/ContainerInstance/Management.ContainerInstance/Generated
  clear-output-folder: true
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  namespace: azure.mgmt.containerinstance
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
```
