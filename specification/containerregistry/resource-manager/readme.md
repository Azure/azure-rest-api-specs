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

## Python

These settings apply only when `--python` is specified on the command line.

```yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-containerregistry
  clear-output-folder: true
  no-namespace-folders: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-2017-10
  - tag: package-2017-03
```

### Tag: package-2017-10 and python

These settings apply only when `--tag=package-2017-10 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-10' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2017_10_01
  output-folder: $(python-sdks-folder)/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_10_01
```

### Tag: package-2017-03 and python

These settings apply only when `--tag=package-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-2017-03' && $(python)
python:
  namespace: azure.mgmt.containerregistry.v2017_03_01
  output-folder: $(python-sdks-folder)/azure-mgmt-containerregistry/azure/mgmt/containerregistry/v2017_03_01
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: containerregistry
  clear-output-folder: true
```

### Tag: package-2017-10 and go

These settings apply only when `--tag=package-2017-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10' && $(go)
output-folder: $(go-sdk-folder)/services/containerregistry/mgmt/2017-10-01/containerregistry
```

### Tag: package-2017-06-preview and go

These settings apply only when `--tag=package-2017-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/containerregistry/mgmt/2017-06-01-preview/containerregistry
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03' && $(go)
output-folder: $(go-sdk-folder)/services/containerregistry/mgmt/2017-03-01/containerregistry
```

### Tag: package-2016-06-preview and go

These settings apply only when `--tag=package-2016-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-06' && $(go)
output-folder: $(go-sdk-folder)/services/containerregistry/mgmt/2016-06-27-preview/containerregistry
```
