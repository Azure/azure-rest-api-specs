# ContainerRegistry
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry.



---
## Getting Started 
To build the SDK for ContainerRegistry, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the ContainerRegistry API.

``` yaml
openapi-type: arm
tag: package-2017-10
```
 
### Tag: package-2017-10

These settings apply only when `--tag=package-2017-10` is specified on the command line.

``` yaml $(tag) == 'package-2017-10'
input-file:
- Microsoft.ContainerRegistry/2017-10-01/containerregistry.json
```
 
### Tag: package-2017-06-preview

These settings apply only when `--tag=package-2017-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-06-preview'
input-file:
- Microsoft.ContainerRegistry/2017-06-01-preview/containerregistry.json
```
 
### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.ContainerRegistry/2017-03-01/containerregistry.json
```
 
### Tag: package-2016-06-preview

These settings apply only when `--tag=package-2016-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-06-preview'
input-file:
- Microsoft.ContainerRegistry/2016-06-27-preview/containerregistry.json
```


---
# Code Generation


## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated using AutoRest.1.0.0-Nightly20170212 with commit 3b0b26b4b6e3bc5e7cf3610b0866d310abb5b814
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.ContainerRegistry
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/ContainerRegistry/Management.ContainerRegistry/Generated
  clear-output-folder: true
```
