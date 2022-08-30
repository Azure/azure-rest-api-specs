# Fabric Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Fabric Admin.

---
## Getting Started
To build the SDK for Fabric Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Fabric API.

``` yaml
title: FabricAdminClient
description: Fabric Admin Client
openapi-type: arm
tag: package-2022-03-01
```

### Tag: package-2016-05-01

These settings apply only when `--tag=package-2016-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-05-01'
input-file:
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ApplicationOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ComputeOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StoragePool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageSystem.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/Volume.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json"
```

### Tag: package-2018-10-01

These settings apply only when `--tag=package-2018-10-01` is specified on the command line.

``` yaml $(tag) == 'package-2018-10-01'
input-file:
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ApplicationOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ComputeOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StoragePool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageSystem.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2018-10-01/Drive.json"
    - "Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json"
    - "Microsoft.Fabric.Admin/preview/2018-10-01/Volume.json"
```

### Tag: package-2019-05-01

These settings apply only when `--tag=package-2019-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2019-05-01'
input-file:
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ApplicationOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/Drive.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/Volume.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/NasCluster.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ComputeOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnit.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnitNode.json"
```

### Tag: package-2022-03-01

These settings apply only when `--tag=package-2022-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-03-01'
input-file:
    - "Microsoft.Fabric.Admin/preview/2016-05-01/ApplicationOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json"
    - "Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/Drive.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/Volume.json"
    - "Microsoft.Fabric.Admin/preview/2019-05-01/NasCluster.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ComputeOperationResults.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnit.json"
    - "Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnitNode.json"
    - "Microsoft.Fabric.Admin/stable/2022-03-01/FabricLocation.json"
```

## Suppression
``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: FabricLocation.json
    where: $.definitions.FabricLocationModel.properties.externalDNSIPAddress01      
    reason: externalDNSIPAddress01 is a customized name, no camel case restriction needed.
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: FabricLocation.json
    where: $.definitions.FabricLocationModel.properties.externalDNSIPAddress02      
    reason: externalDNSIPAddress02 is a customized name, no camel case restriction needed.
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
  namespace: Microsoft.AzureStack.Management.Fabric.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```

## Multi-API/Profile support for AutoRest v3 generators 

AutoRest V3 generators require the use of `--tag=all-api-versions` to select api files.

This block is updated by an automatic script. Edits may be lost!

``` yaml $(tag) == 'all-api-versions' /* autogenerated */
# include the azure profile definitions from the standard location
require: $(this-folder)/../../../../profiles/readme.md

# all the input files across all versions
input-file:
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ApplicationOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ComputeOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StoragePool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StorageSystem.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/Volume.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/Drive.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/Volume.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/Drive.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/Volume.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/NasCluster.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnit.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2020-10-01/ScaleUnitNode.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2020-10-01/ComputeOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/stable/2022-03-01/FabricLocation.json
```

If there are files that should not be in the `all-api-versions` set, 
uncomment the  `exclude-file` section below and add the file paths.

``` yaml $(tag) == 'all-api-versions'
#exclude-file: 
#  - $(this-folder)/Microsoft.Example/stable/2010-01-01/somefile.json
```
