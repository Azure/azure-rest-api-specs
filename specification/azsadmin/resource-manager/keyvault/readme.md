# KeyVault Admin
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for KeyVault Admin.

---
## Getting Started 
To build the SDK for KeyVault Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the KeyVault API.

``` yaml
title: KeyVaultAdminClient
description: KeyVault Admin Client
openapi-type: arm
tag: package-2017-02-01-preview
```

### Tag: package-2017-02-01-preview

These settings apply only when `--tag=package-2017-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2017-02-01-preview'
input-file:
    - Microsoft.KeyVault.Admin/2017-02-01-preview/KeyVault.json
    - Microsoft.KeyVault.Admin/2017-02-01-preview/Quotas.json
```

---
# Code Generation

## C# 

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.KeyVault.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/KeyVault/KeyVault.Admin/Generated
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

### Tag: package-2017-02-01-preview and python

These settings apply only when `--tag=package-2017-02-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2017-02-01-preview' && $(python)
namespace: azure.mgmt.KeyVault.admin.v2015_06_01_preview
```
