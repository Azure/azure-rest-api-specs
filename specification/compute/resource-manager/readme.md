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
tag: package-2018-04

directive:
  - where:
      - $.definitions.VirtualMachine.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.VirtualMachineScaleSetVM.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.ImageReference.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.ManagedDiskParameters.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.Disk.properties
    suppress:
      - BodyTopLevelProperties
  - where:
      - $.definitions.Snapshot.properties
    suppress:
      - BodyTopLevelProperties

  - where:
      - $.definitions.VirtualMachineScaleSetExtension
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineImage
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ImageReference
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ManagedDiskParameters
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.NetworkInterfaceReference
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetIPConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdateIPConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetNetworkConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdateNetworkConfiguration
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineScaleSetUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.AvailabilitySetUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineExtensionUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.VirtualMachineUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.ImageUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel


  - where:
      - $.definitions.VirtualMachineScaleSetVM
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineExtensionImage
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.RollingUpgradeStatusInfo
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImage
    suppress:
      - TrackedResourcePatchOperation

  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - TrackedResourceGetOperation
      
```
### Tag: package-2018-04

These settings apply only when `--tag=package-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-2018-04'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-12-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-04-01/disk.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-disks-2018-04

These settings apply only when `--tag=package-disks-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-disks-2018-04'
input-file:
- Microsoft.Compute/stable/2018-04-01/disk.json
```

### Tag: package-2017-12

These settings apply only when `--tag=package-2017-12` is specified on the command line.

``` yaml $(tag) == 'package-2017-12'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-12-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2017-03-30/disk.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2017-12

These settings apply only when `--tag=package-compute-2017-12` is specified on the command line.

``` yaml $(tag) == 'package-compute-2017-12'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-12-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2017-03-30/disk.json
```

### Tag: package-compute-only-2017-12

These settings apply only when `--tag=package-compute-only-2017-12` is specified on the command line.

``` yaml $(tag) == 'package-compute-only-2017-12'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-12-01/runCommands.json
```

### Tag: package-skus-2017-09

These settings apply only when `--tag=package-skus-2017-09` is specified on the command line.

``` yaml $(tag) == 'package-skus-2017-09'
input-file:
- Microsoft.Compute/stable/2017-09-01/skus.json
```

### Tag: package-2017-03

These settings apply only when `--tag=package-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-2017-03'
input-file:
- Microsoft.Compute/stable/2017-03-30/compute.json
- Microsoft.Compute/stable/2017-03-30/disk.json
- Microsoft.Compute/stable/2017-03-30/runCommands.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2017-03

These settings apply only when `--tag=package-compute-2017-03` is specified on the command line.

``` yaml $(tag) == 'package-compute-2017-03'
input-file:
- Microsoft.Compute/stable/2017-03-30/compute.json
- Microsoft.Compute/stable/2017-03-30/disk.json
- Microsoft.Compute/stable/2017-03-30/runCommands.json
```

### Tag: package-container-service-2017-01

These settings apply only when `--tag=package-container-service-2017-01` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2017-01'
input-file:
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-container-service-2016-09

These settings apply only when `--tag=package-container-service-2016-09` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2016-09'
input-file:
- Microsoft.ContainerService/stable/2016-09-30/containerService.json
```

### Tag: package-2016-04-preview

These settings apply only when `--tag=package-2016-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-2016-04-preview'
input-file:
- Microsoft.Compute/preview/2016-04-30-preview/compute.json
- Microsoft.Compute/preview/2016-04-30-preview/disk.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-2016-04-preview

These settings apply only when `--tag=package-compute-2016-04-preview` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-04-preview'
input-file:
- Microsoft.Compute/preview/2016-04-30-preview/compute.json
- Microsoft.Compute/preview/2016-04-30-preview/disk.json
```

### Tag: package-2016-03

These settings apply only when `--tag=package-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-2016-03'
input-file:
- Microsoft.Compute/stable/2016-03-30/compute.json
- Microsoft.ContainerService/stable/2016-03-30/containerService.json
```

### Tag: package-compute-2016-03

These settings apply only when `--tag=package-compute-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-compute-2016-03'
input-file:
- Microsoft.Compute/stable/2016-03-30/compute.json
```

### Tag: package-container-service-2016-03

These settings apply only when `--tag=package-container-service-2016-03` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2016-03'
input-file:
- Microsoft.ContainerService/stable/2016-03-30/containerService.json
```

### Tag: package-container-service-2015-11-preview

These setings apply only when `--tag=package-container-service-2015-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-container-service-2015-11-preview'
input-file:
- Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
```

### Tag: package-compute-2015-06

These settings apply only when `--tag=package-compute-2015-06` is specified on the command line.

``` yaml $(tag) == 'package-compute-2015-06'
input-file:
- Microsoft.Compute/stable/2015-06-15/compute.json
```

### Tag: package-2015-06-preview

These settings apply only when `--tag=package-2015-06-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-preview'
input-file:
- Microsoft.Compute/stable/2015-06-15/compute.json
- Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
```


---
# Code Generation


## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-compute
  - repo: azure-libraries-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
```


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

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-04
  #- tag: package-2017-12 broken
  - tag: package-2017-03
  - tag: package-container-service-2017-01
  - tag: package-container-service-2016-09
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-container-service-2016-03
  - tag: package-container-service-2015-11-preview
  - tag: package-compute-2015-06
```

### Tag: package-2018-04 and go

These settings apply only when `--tag=package-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-04' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2018-04-01/compute
```

### Tag: package-2017-12 and go

These settings apply only when `--tag=package-2017-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-12' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2017-12-01/compute
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-03' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/compute/mgmt/2017-03-30/compute
```

### Tag: package-container-service-2017-01 and go

These settings apply only when `--tag=package-container-service-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2017-01' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/containerservice/mgmt/2017-01-31/containerservice
```

### Tag: package-container-service-2016-09 and go

These settings apply only when `--tag=package-container-service-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2016-09' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/containerservice/mgmt/2016-09-30/containerservice
```

### Tag: package-compute-2016-04-preview and go

These settings apply only when `--tag=package-compute-2016-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-compute-2016-04-preview' && $(go)
namespace: compute
output-folder: $(go-sdk-folder)/services/preview/compute/mgmt/2016-04-30-preview/compute
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
output-folder: $(go-sdk-folder)/services/containerservice/mgmt/2016-03-30/containerservice
```

### Tag: package-container-service-2015-11-preview and go

These settings apply only when `--tag=package-container-service-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-container-service-2015-11-preview' && $(go)
namespace: containerservice
output-folder: $(go-sdk-folder)/services/preview/containerservice/mgmt/2015-11-01-preview/containerservice
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
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-compute
  no-namespace-folders: true
  clear-output-folder: true
```

### Python multi-api

Generate all API versions currently shipped for this package

```yaml $(python) && $(multiapi)
batch:
  - tag: package-disks-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
  - tag: package-compute-2016-04-preview
  - tag: package-compute-2016-03
  - tag: package-compute-2015-06
```

### Tag: package-disks-2018-04 and python

These settings apply only when `--tag=package-disks-2018-04 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-disks-2018-04' && $(python)
python:
  namespace: azure.mgmt.compute.v2018_04_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2018_04_01
```

### Tag: package-compute-only-2017-12 and python

These settings apply only when `--tag=package-compute-only-2017-12 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_12_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_12_01
```

### Tag: package-skus-2017-09 and python

These settings apply only when `--tag=package-skus-2017-09 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_09_01
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_09_01
```

### Tag: package-compute-2017-03 and python

These settings apply only when `--tag=package-compute-2017-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(python)
python:
  namespace: azure.mgmt.compute.v2017_03_30
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2017_03_30
```

### Tag: package-compute-2016-04-preview and python

These settings apply only when `--tag=package-compute-2016-04-preview --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-04-preview' && $(python)
python:
  namespace: azure.mgmt.compute.v2016_04_30_preview
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2016_04_30_preview
```

### Tag: package-compute-2016-03 and python

These settings apply only when `--tag=package-compute-2016-03 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2016-03' && $(python)
python:
  namespace: azure.mgmt.compute.v2016_03_30
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2016_03_30
```

### Tag: package-compute-2015-06 and python

These settings apply only when `--tag=package-compute-2015-06 --python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.

``` yaml $(tag) == 'package-compute-2015-06' && $(python)
python:
  namespace: azure.mgmt.compute.v2015_06_15
  output-folder: $(python-sdks-folder)/azure-mgmt-compute/azure/mgmt/compute/v2015_06_15
```


## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
java:
  azure-arm: true
  fluent: true
  namespace: com.microsoft.azure.management.compute
  license-header: MICROSOFT_MIT_NO_CODEGEN
  payload-flattening-threshold: 1
  output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-compute
```

