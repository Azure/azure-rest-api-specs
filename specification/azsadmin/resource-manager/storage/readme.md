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
tag: package-2015-12-01
```

### Tag: package-2015-12-01

These settings apply only when `--tag=package-2015-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-12-01'
input-file:
    - "Microsoft.Storage.Admin/preview/2015-12-01/storage.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/acquisitions.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/blobServices.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/containers.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/farms.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/queueServices.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/quotas.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/shares.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/storageaccounts.json"
    - "Microsoft.Storage.Admin/preview/2015-12-01/tableServices.json"
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
