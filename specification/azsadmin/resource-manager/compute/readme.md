# Compute Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Compute Admin.

---
## Getting Started
To build the SDK for Compute Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Compute API.

``` yaml
title: ComputeAdminClient
description: Compute Admin Client
openapi-type: arm
tag: package-2018-02-09
```

### Tag: package-2018-02-09

These settings apply only when `--tag=package-2018-02-09` is specified on the command line.

``` yaml $(tag) == 'package-2018-02-09'
input-file:
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/Compute.json
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/PlatformImages.json
    - Microsoft.Compute.Admin/preview/2018-02-09/Quotas.json
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/VMExtensions.json
    - Microsoft.Compute.Admin/preview/2018-07-30-preview/Disks.json
    - Microsoft.Compute.Admin/preview/2018-07-30-preview/DiskMigrationJobs.json
```

---
# Code Generation

## C#

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Compute.Admin
  payload-flattening-threshold: 2
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```

# AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml
input-file:  
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/Compute.json
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/PlatformImages.json
    - Microsoft.Compute.Admin/preview/2018-02-09/Quotas.json
    - Microsoft.Compute.Admin/preview/2015-12-01-preview/VMExtensions.json
    - Microsoft.Compute.Admin/preview/2018-07-30-preview/Disks.json
    - Microsoft.Compute.Admin/preview/2018-07-30-preview/DiskMigrationJobs.json
```
