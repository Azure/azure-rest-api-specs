# Compute
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Compute.


The compute RP comprises of small services where each service has its own tag.
Hence, each sub-service has its own swagger spec. 

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (nuget/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


---
## Getting Started 
To build the SDK for Compute, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration



### Basic Information 
These are the global settings for the Compute API.

``` yaml
title: ComputeManagementClient
description: Compute Client
openapi-type: arm
tag: package-2017-03
```


### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.Compute/2017-03-30/compute.json
- Microsoft.Compute/2017-03-30/disk.json
- Microsoft.Compute/2017-03-30/runCommands.json
- Microsoft.ContainerService/2017-01-31/containerService.json
```

### Tag: package-compute-2017-03

These settings apply only when `--tag=package-compute-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-compute-2017-03'
input-file:
- Microsoft.Compute/2017-03-30/compute.json
- Microsoft.Compute/2017-03-30/disk.json
- Microsoft.Compute/2017-03-30/runCommands.json
```

### Tag: package-container-service-2017-01

These settings apply only when `--tag=package-container-service-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2017-01'
input-file:
- Microsoft.ContainerService/2017-01-31/containerService.json
```

### Tag: package-container-service-2016-09

These settings apply only when `--tag=package-container-service-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2016-09'
input-file:
- Microsoft.ContainerService/2016-09-30/containerService.json
```

### Tag: package-2016-04-preview

These settings apply only when `--tag=package-2016-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-04-preview'
input-file:
- Microsoft.Compute/2016-04-30-preview/compute.json
- Microsoft.Compute/2016-04-30-preview/disk.json
- Microsoft.ContainerService/2017-01-31/containerService.json
```

### Tag: package-compute-2016-04-preview

These settings apply only when `--tag=package-compute-2016-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-04-preview'
input-file:
- Microsoft.Compute/2016-04-30-preview/compute.json
- Microsoft.Compute/2016-04-30-preview/disk.json
```

### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-2016-03'
input-file:
- Microsoft.Compute/2016-03-30/compute.json
- Microsoft.ContainerService/2016-03-30/containerService.json
```

### Tag: package-compute-2016-03

These settings apply only when `--tag=package-compute-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-03'
input-file:
- Microsoft.Compute/2016-03-30/compute.json
```

### Tag: package-container-service-2016-03

These settings apply only when `--tag=package-container-service-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2016-03'
input-file:
- Microsoft.ContainerService/2016-03-30/containerService.json
```

### Tag: package-container-service-2015-11-preview

These setings apply only when `--tag=package-container-service-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2015-11-preview'
input-file:
- Microsoft.ContainerService/2015-11-01-preview/containerService.json
```

### Tag: package-compute-2015-06

These settings apply only when `--tag=package-compute-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-compute-2015-06'
input-file:
- Microsoft.Compute/2015-06-15/compute.json
```

### Tag: package-2015-06-preview

These settings apply only when `--tag=package-2015-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-preview'
input-file:
- Microsoft.Compute/2015-06-15/compute.json
- Microsoft.ContainerService/2015-11-01-preview/containerService.json
```


---
# Code Generation

## C# 

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  # last generated with AutoRest.1.0.0-Nightly20170126
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Management.Compute
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Compute/Management.Compute/Generated
  clear-output-folder: true
```


## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-compute-2017-03 and go

These settings apply only when `--tag=package-compute-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-compute-2017-03' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2017-03-30/compute
```

### Tag: package-container-service-2017-01 and go

These settings apply only when `--tag=package-container-service-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2017-01' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/compute/mgmt/2017-01-31/containerservice
```

### Tag: package-container-service-2016-09 and go

These settings apply only when `--tag=package-container-service-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2016-09' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/compute/mgmt/2016-09-30/containerservice
```

### Tag: package-compute-2016-04-preview and go

These settings apply only when `--tag=package-compute-2016-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-compute-2016-04-preview' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2016-04-30-preview/compute
```

### Tag: package-compute-2016-03 and go

These settings apply only when `--tag=package-compute-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-compute-2016-03' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2016-03-30/compute
```

### Tag: package-container-service-2016-03 and go

These settings apply only when `--tag=package-container-service-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2016-03' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/compute/mgmt/2016-03-30/containerservice
```

### Tag: package-container-service-2015-11-preview and go

These settings apply only when `--tag=package-container-service-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2015-11-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/compute/mgmt/2015-11-01-preview/containerservice
```

### Tag: package-compute-2015-06 and go

These settings apply only when `--tag=package-compute-2015-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-compute-2015-06' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2015-06-15/compute
```


## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  # override the default output folder
  output-folder: $(output-folder)/python
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
```

### Tag: package-compute-2017-03 and python

These settings apply only when `--tag=package-compute-2017-03 --python` is specified on the command line.

``` yaml $(tag) == 'package-compute-2017-03' && $(python)
namespace: azure.mgmt.compute.compute.v2017_03_30
```

### Tag: package-container-service-2017-01 and python

These settings apply only when `--tag=package-container-service-2017-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2017-01' && $(python)
namespace: azure.mgmt.compute.containerservice.v2017_01_31
```

### Tag: package-compute-2016-04-preview and python

These settings apply only when `--tag=package-compute-2016-04-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-04-preview' && $(python)
namespace: azure.mgmt.compute.compute.v2016_04_30_preview
```

### Tag: package-compute-2016-03 and python

These settings apply only when `--tag=package-compute-2016-03 --python` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-03' && $(python)
namespace: azure.mgmt.compute.compute.v2016_03_30
```

### Tag: package-compute-2015-06 and python

These settings apply only when `--tag=package-compute-2015-06 --python` is specified on the command line.

``` yaml $(tag) == 'package-compute-2015-06' && $(python)
namespace: azure.mgmt.compute.compute.v2015_06_15
```

