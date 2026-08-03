# ContainerRegistry Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for ContainerRegistry Admin.

---
## Getting Started
To build the SDK for ContainerRegistry Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the ContainerRegistry API.

``` yaml
title: ContainerRegistryAdminClient
description: ContainerRegistry Admin Client
openapi-type: arm
tag: package-2019-11-01
```

``` yaml
input-file:
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/capacity.json
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/configuration.json
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/operations.json
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/quotas.json
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/registries.json
  - $(this-folder)/Microsoft.ContainerRegistry.Admin/preview/2019-11-01-preview/setup.json
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
  namespace: Microsoft.AzureStack.Management.ContainerRegistry.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
