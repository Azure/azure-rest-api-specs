# Commerce Admin
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Commerce Admin.

---
## Getting Started 
To build the SDK for Commerce Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the Commerce API.

``` yaml
title: FabricAdminClient
description: Fabric Admin Client
openapi-type: arm
tag: package-2016-05-01
```

### Tag: package-2016-05-01

These settings apply only when `--tag=package-2016-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-05-01'
input-file:
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/Fabric.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/EdgeGateway.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/EdgeGatewayPool.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/FabricLocation.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/FileShare.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/InfraRole.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/InfraRoleInstance.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/IpPool.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/LogicalNetwork.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/StoragePool.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/StorageSystem.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/Volume.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/LogicalSubnet.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/MacAddressPool.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/Operations.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/ScaleUnit.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/ScaleUnitNode.json"
    - "Microsoft.Fabric.Admin/2016-05-01/swagger/SlbMuxInstance.json"
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
  namespace: Microsoft.AzureStack.Fabric.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Fabric/Fabric.Admin/Generated
  clear-output-folder: true
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

### Tag: package-2016-05-01 and python

These settings apply only when `--tag=package-2016-05-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2016-05-01' && $(python)
namespace: azure.mgmt.fabric.admin.v2016_05_01
```
