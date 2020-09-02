# Compute

> see https://aka.ms/autorest

This is the AutoRest configuration file for Compute.


The compute RP comprises of small services where each service has its own tag.
Hence, each sub-service has its own swagger spec.

All of them are tied together using this configuration and are packaged together into one compute client library.
This makes it easier for customers to download one (NuGet/npm/pip/maven/gem) compute client library package rather than installing individual packages for each sub service.


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
tag: package-2020-06-30

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
      - $.definitions.ProximityPlacementGroupUpdate
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
      - $.definitions.DedicatedHostGroupUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.DedicatedHostUpdate
    suppress:
      - RequiredPropertiesMissingInResourceModel
  - where:
      - $.definitions.DiskEncryptionSetParameters
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
      - $.definitions.Gallery
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.GalleryImage
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.GalleryImageVersion
    suppress:
      - TrackedResourcePatchOperation
  - where:
      - $.definitions.VirtualMachineImageResource
    suppress:
      - TrackedResourceGetOperation
  - where:
      - $.definitions.AdditionalCapabilities.properties.ultraSSDEnabled
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskProperties.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskUpdateProperties.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskProperties.properties.diskIOPSReadOnly
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DiskUpdateProperties.properties.diskIOPSReadOnly
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.DataDisk.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.VirtualMachineScaleSetDataDisk.properties.diskIOPSReadWrite
    suppress:
      - DefinitionsPropertiesNamesCamelCase
  - where:
      - $.definitions.ContainerService
    suppress:
      - TrackedResourcePatchOperation
    reason:
      - ACS service is deprecated so a PATCH endpoint won't be implemented

```
### Tag: package-2020-06-30

These settings apply only when `--tag=package-2020-06-30` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-30'
input-file:
- Microsoft.Compute/stable/2020-06-01/compute.json
- Microsoft.Compute/stable/2020-06-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2020-06-30/disk.json
- Microsoft.Compute/stable/2019-12-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-06-30-only

These settings apply only when `--tag=package-2020-06-30-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-30-only'
input-file:
- Microsoft.Compute/stable/2020-06-30/disk.json
```

### Tag: package-2020-06-01

These settings apply only when `--tag=package-2020-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01'
input-file:
- Microsoft.Compute/stable/2020-06-01/compute.json
- Microsoft.Compute/stable/2020-06-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2020-05-01/disk.json
- Microsoft.Compute/stable/2019-12-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-06-01-only

These settings apply only when `--tag=package-2020-06-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-06-01-only'
input-file:
- Microsoft.Compute/stable/2020-06-01/compute.json
- Microsoft.Compute/stable/2020-06-01/runCommands.json
```

### Tag: package-2020-05-01

These settings apply only when `--tag=package-2020-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01'
input-file:
- Microsoft.Compute/stable/2019-12-01/compute.json
- Microsoft.Compute/stable/2019-12-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2020-05-01/disk.json
- Microsoft.Compute/stable/2019-12-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2020-05-01-only

These settings apply only when `--tag=package-2020-05-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2020-05-01-only'
input-file:
- Microsoft.Compute/stable/2020-05-01/disk.json
```

### Tag: package-2019-12-01

These settings apply only when `--tag=package-2019-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-12-01'
input-file:
- Microsoft.Compute/stable/2019-12-01/compute.json
- Microsoft.Compute/stable/2019-12-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2019-11-01/disk.json
- Microsoft.Compute/stable/2019-12-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-12-01-only

These settings apply only when `--tag=package-2019-12-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-12-01-only'
input-file:
- Microsoft.Compute/stable/2019-12-01/compute.json
- Microsoft.Compute/stable/2019-12-01/runCommands.json
- Microsoft.Compute/stable/2019-12-01/gallery.json
```

### Tag: package-2019-11-01

These settings apply only when `--package-2019-11-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01'
input-file:
- Microsoft.Compute/stable/2019-07-01/compute.json
- Microsoft.Compute/stable/2019-07-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2019-11-01/disk.json
- Microsoft.Compute/stable/2019-07-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-11-01-only

These settings apply only when `--package-2019-11-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01-only'
input-file:
- Microsoft.Compute/stable/2019-11-01/disk.json
```

### Tag: package-2019-07

These settings apply only when `--tag=package-2019-07` is specified on the command line.

``` yaml $(tag) == 'package-2019-07'
input-file:
- Microsoft.Compute/stable/2019-07-01/compute.json
- Microsoft.Compute/stable/2019-07-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2019-07-01/disk.json
- Microsoft.Compute/stable/2019-07-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-07-01

These settings apply only when `--tag=package-2019-07-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-07-01'
input-file:
- Microsoft.Compute/stable/2019-03-01/compute.json
- Microsoft.Compute/stable/2019-03-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2019-07-01/disk.json
- Microsoft.Compute/stable/2019-07-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-07-01-only

These settings apply only when `--tag=package-2019-07-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-07-01-only'
input-file:
- Microsoft.Compute/stable/2019-07-01/compute.json
- Microsoft.Compute/stable/2019-07-01/disk.json
- Microsoft.Compute/stable/2019-07-01/gallery.json
- Microsoft.Compute/stable/2019-07-01/runCommands.json
```

### Tag: package-2019-03-01

These settings apply only when `--tag=package-2019-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-01'
input-file:
- Microsoft.Compute/stable/2019-03-01/compute.json
- Microsoft.Compute/stable/2019-03-01/runCommands.json
- Microsoft.Compute/stable/2019-04-01/skus.json
- Microsoft.Compute/stable/2019-03-01/disk.json
- Microsoft.Compute/stable/2019-03-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2019-04-01-only

These settings apply only when `--tag=package-2019-04-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-04-01-only'
input-file:
- Microsoft.Compute/stable/2019-04-01/skus.json
```

### Tag: package-2019-03-01-only

These settings apply only when `--tag=package-2019-03-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2019-03-01-only'
input-file:
- Microsoft.Compute/stable/2019-03-01/compute.json
- Microsoft.Compute/stable/2019-03-01/runCommands.json
- Microsoft.Compute/stable/2019-03-01/gallery.json
- Microsoft.Compute/stable/2019-03-01/disk.json
```

### Tag: package-2018-10-01-Disks

These settings apply only when `--tag=package-2018-10-01-Disks` is specified on the command line.

``` yaml $(tag) == 'package-2018-10-01-Disks'
input-file:
- Microsoft.Compute/stable/2018-10-01/compute.json
- Microsoft.Compute/stable/2018-10-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-09-30/disk.json
- Microsoft.Compute/stable/2018-06-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-10-01'
input-file:
- Microsoft.Compute/stable/2018-10-01/compute.json
- Microsoft.Compute/stable/2018-10-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-06-01/disk.json
- Microsoft.Compute/stable/2018-06-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-10-01-only

These settings apply only when `--tag=package-2018-10-01-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-10-01-only'
input-file:
- Microsoft.Compute/stable/2018-10-01/compute.json
- Microsoft.Compute/stable/2018-10-01/runCommands.json
```

### Tag: package-2018-09-30-only

These settings apply only when `--tag=package-2018-09-30-only` is specified on the command line.

``` yaml $(tag) == 'package-2018-09-30-only'
input-file:
- Microsoft.Compute/stable/2018-09-30/disk.json
```

### Tag: package-2018-06-exclude-gallery

These settings apply only when `--tag=package-2018-06-exclude-gallery` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-exclude-gallery'
input-file:
- Microsoft.Compute/stable/2018-06-01/compute.json
- Microsoft.Compute/stable/2018-06-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-06-01/disk.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-06

These settings apply only when `--tag=package-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-2018-06'
input-file:
- Microsoft.Compute/stable/2018-06-01/compute.json
- Microsoft.Compute/stable/2018-06-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-06-01/disk.json
- Microsoft.Compute/stable/2018-06-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-2018-06-01

These settings apply only when `--tag=package-2018-06-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-06-01'
input-file:
- Microsoft.Compute/stable/2018-04-01/compute.json
- Microsoft.Compute/stable/2018-04-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-06-01/disk.json
- Microsoft.Compute/stable/2018-06-01/gallery.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
```

### Tag: package-compute-only-2018-06

These settings apply only when `--tag=package-compute-only-2018-06` is specified on the command line.

``` yaml $(tag) == 'package-compute-only-2018-06'
input-file:
- Microsoft.Compute/stable/2018-06-01/compute.json
- Microsoft.Compute/stable/2018-06-01/runCommands.json
- Microsoft.Compute/stable/2018-06-01/gallery.json
- Microsoft.Compute/stable/2018-06-01/disk.json
```

### Tag: package-2018-04-01

These settings apply only when `--tag=package-2018-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-04-01'
input-file:
- Microsoft.Compute/stable/2018-04-01/compute.json
- Microsoft.Compute/stable/2018-04-01/runCommands.json
- Microsoft.Compute/stable/2017-09-01/skus.json
- Microsoft.Compute/stable/2018-04-01/disk.json
- Microsoft.ContainerService/stable/2017-01-31/containerService.json
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

### Tag: package-compute-2018-04

These settings apply only when `--tag=package-compute-2018-04` is specified on the command line.

``` yaml $(tag) == 'package-compute-2018-04'
input-file:
- Microsoft.Compute/stable/2018-04-01/compute.json
- Microsoft.Compute/stable/2018-04-01/runCommands.json
- Microsoft.Compute/stable/2018-04-01/disk.json
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

These settings apply only when `--tag=package-container-service-2015-11-preview` is specified on the command line.

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
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
    after_scripts:
      - python ./scripts/multiapi_init_gen.py azure-mgmt-compute
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_compute']
  - repo: azure-resource-manager-schemas
    after_scripts:
      - node sdkauto_afterscript.js compute/resource-manager
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Java

These settings apply only when `--java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-libraries-for-java clone>`.

``` yaml $(java)
azure-arm: true
fluent: true
namespace: com.microsoft.azure.management.compute
license-header: MICROSOFT_MIT_NO_CODEGEN
payload-flattening-threshold: 1
output-folder: $(azure-libraries-for-java-folder)/azure-mgmt-compute
```

### Java multi-api

```yaml $(java) && $(multiapi)
batch:
  - tag: package-disks-2018-04
  - tag: package-compute-only-2017-12
  - tag: package-skus-2017-09
  - tag: package-compute-2017-03
```

### Tag: package-disks-2018-04 and java

These settings apply only when `--tag=package-disks-2018-04 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-disks-2018-04' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2018_04_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2018_04_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-compute-only-2017-12 and java

These settings apply only when `--tag=package-compute-only-2017-12 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-compute-only-2017-12' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_12_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_12_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-skus-2017-09 and java

These settings apply only when `--tag=package-skus-2017-09 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-skus-2017-09' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_09_01
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_09_01
regenerate-manager: true
generate-interface: true
```

### Tag: package-compute-2017-03 and java

These settings apply only when `--tag=package-compute-2017-03 --java` is specified on the command line.
Please also specify `--azure-libraries-for-java-folder=<path to the root directory of your azure-sdk-for-java clone>`.

``` yaml $(tag) == 'package-compute-2017-03' && $(java) && $(multiapi)
java:
  namespace: com.microsoft.azure.management.compute.v2017_03_30
  output-folder: $(azure-libraries-for-java-folder)/sdk/compute/mgmt-v2017_03_30
regenerate-manager: true
generate-interface: true
```

### Tag: profile-hybrid-2019-03-01

These settings apply only when `--tag=profile-hybrid-2019-03-01` is specified on the command line.
Creating this tag to pick proper resources from the hybrid profile.

``` yaml $(tag) == 'profile-hybrid-2019-03-01'
input-file:
- Microsoft.Compute/stable/2017-12-01/compute.json
- Microsoft.Compute/stable/2017-03-30/disk.json
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Compute/stable/2020-06-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2020-06-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2019-04-01/skus.json
  - $(this-folder)/Microsoft.Compute/stable/2020-06-30/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2019-12-01/gallery.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - $(this-folder)/Microsoft.Compute/stable/2020-05-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2019-12-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2019-12-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2019-11-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2019-07-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2019-07-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2019-07-01/gallery.json
  - $(this-folder)/Microsoft.Compute/stable/2019-07-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2019-03-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2019-03-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2019-03-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2019-03-01/gallery.json
  - $(this-folder)/Microsoft.Compute/stable/2018-10-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-10-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2017-09-01/skus.json
  - $(this-folder)/Microsoft.Compute/stable/2018-09-30/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/gallery.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2017-12-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2017-12-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/runCommands.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - $(this-folder)/Microsoft.Compute/preview/2016-04-30-preview/compute.json
  - $(this-folder)/Microsoft.Compute/preview/2016-04-30-preview/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2016-03-30/compute.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-03-30/containerService.json
  - $(this-folder)/Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
  - $(this-folder)/Microsoft.Compute/stable/2015-06-15/compute.json

```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```

