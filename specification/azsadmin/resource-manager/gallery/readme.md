# Gallery Admin
    
> see https://aka.ms/autorest

This is the AutoRest configuration file for Gallery Admin.

---
## Getting Started 
To build the SDK for Gallery Admin, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information 
These are the global settings for the Gallery API.

``` yaml
title: GalleryAdminClient
description: Gallery Admin Client
openapi-type: arm
tag: package-2015-04-01
```

### Tag: package-2015-04-01

These settings apply only when `--tag=package-2015-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2015-04-01'
input-file:
    - Microsoft.Gallery.Admin/2015-04-01/Gallery.json
    - Microsoft.Gallery.Admin/2015-04-01/GalleryItem.json
```

---
# Code Generation

## C# 

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.AzureStack.Management.Gallery.Admin
  payload-flattening-threshold: 1
  output-folder: $(csharp-sdks-folder)/Gallery/Gallery.Admin/Generated
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

### Tag: package-2015-04-01 and python

These settings apply only when `--tag=package-2015-04-01 --python` is specified on the command line.

``` yaml $(tag) == 'package-2015-04-01' && $(python)
namespace: azure.mgmt.gallery.admin.v2015_06_01_preview
```
