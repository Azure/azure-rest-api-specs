# Storage Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Storage Admin.

---
## Getting Started
To build the SDK for Storage Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Storage API.

``` yaml
title: StorageAdminClient
description: Storage Admin Client
openapi-type: arm
tag: package-2019-08-08
```

``` yaml
input-file:
  - $(this-folder)/Microsoft.Storage.Admin/preview/2019-08-08/storageaccounts.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2019-08-08/quotas.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2019-08-08/settings.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2019-08-08/storage.json
  - $(this-folder)/Microsoft.Storage.Admin/preview/2019-08-08/acquisitions.json
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
  namespace: Microsoft.AzureStack.Management.Storage.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
