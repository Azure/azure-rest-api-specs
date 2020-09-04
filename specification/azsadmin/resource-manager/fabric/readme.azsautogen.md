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
tag: package-2019-05-01
```

``` yaml
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
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/NetworkOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StorageOperationResults.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/Drive.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/Volume.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2019-05-01/NasCluster.json"
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
