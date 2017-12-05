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
tag: package-2017-10-preview
```


### Tag: package-2017-10-preview

These settings apply only when `--tag=package-2017-10-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-10-preview'
input-file:
- Microsoft.ContainerInstance/2017-10-01-preview/containerInstance.json
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
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml $(python)
python-mode: create
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  namespace: azure.mgmt.containerinstance
  package-name: azure-mgmt-containerinstance
  clear-output-folder: true
```
``` yaml $(python) && $(python-mode) == 'update'
python:
  no-namespace-folders: true
  output-folder: $(python-sdks-folder)/azure-mgmt-containerinstance/azure/mgmt/containerinstance
```
``` yaml $(python) && $(python-mode) == 'create'
python:
  basic-setup-py: true
  output-folder: $(python-sdks-folder)/azure-mgmt-containerinstance
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: containerinstance
  clear-output-folder: true
```

### Tag: package-2017-08-preview and go

These settings apply only when `--tag=package-2017-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/containerinstance/mgmt/2017-08-01-preview/containerinstance
```
