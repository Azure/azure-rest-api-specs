# ContainerService Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerService Admin.

---
## Getting Started
To build the SDK for ContainerService Admin, simply [Install AutoRest](https://github.com/Azure/autorest/blob/master/docs/install/readme.md) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the ContainerService API.

``` yaml
title: ContainerService AdminClient
description: ContainerService Admin Client
openapi-type: arm
tag: package-2019-11-01
```

``` yaml
input-file:
  - $(this-folder)/Microsoft.ContainerService.Admin/stable/2019-11-01/managedClusters.json
  - $(this-folder)/Microsoft.ContainerService.Admin/stable/2019-11-01/operations.json
  - $(this-folder)/Microsoft.ContainerService.Admin/stable/2019-11-01/quotas.json
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
  namespace: Microsoft.AzureStack.Management.ContainerService.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
