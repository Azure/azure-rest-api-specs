# Backup Admin

> see https://aka.ms/autorest

This is the AutoRest configuration file for Backup Admin.

---
## Getting Started
To build the SDK for Backup Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Backup Admin API.

``` yaml
title: BackupAdminClient
description: Backup Admin Client
openapi-type: arm
tag: package-2016-05-01
```

### Tag: package-2016-05-01

These settings apply only when `--tag=package-2016-05-01` is specified on the command line.

``` yaml $(tag) == 'package-2016-05-01'
input-file:
    - Microsoft.Backup.Admin/preview/2016-05-01/Backup.json
    - Microsoft.Backup.Admin/preview/2016-05-01/BackupLocations.json
    - Microsoft.Backup.Admin/preview/2016-05-01/Backups.json
```

---
# Code Generation

## C#

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Backup.Admin
  payload-flattening-threshold: 1
  output-folder: Generated
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
namespace: azure.mgmt.backup.admin.v2015_06_01_preview
```
