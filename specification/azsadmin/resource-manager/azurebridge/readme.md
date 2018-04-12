# AzureBridge Admin
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureBridge Admin.

---
## Getting Started 
To build the SDK for AzureBridge Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the AzureBridge API.

``` yaml
title: AzureBridgeAdminClient
description: AzureBridge Admin Client
openapi-type: arm
tag: package-2015-06-01-preview
```

### Tag: package-2015-06-01-preview

These settings apply only when `--tag=package-2015-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview'
input-file:
    - Microsoft.AzureBridge.Admin/2016-01-01/AzureBridge.json
    - Microsoft.AzureBridge.Admin/2016-01-01/DownloadedProduct.json
    - Microsoft.AzureBridge.Admin/2016-01-01/Product.json
    - Microsoft.AzureBridge.Admin/2016-01-01/Activation.json
```

---
# Code Generation

## C# 

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.AzureBridge.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/AzureBridge/AzureBridge.Admin/Generated
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

### Tag: package-2015-06-01-preview and python

These settings apply only when `--tag=package-2015-06-01-preview --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-06-01-preview' && $(python)
namespace: azure.mgmt.azurebridge.admin.v2015_06_01_preview
```
