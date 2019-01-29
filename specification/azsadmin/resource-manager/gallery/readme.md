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
    - Microsoft.Gallery.Admin/preview/2015-04-01/Gallery.json
    - Microsoft.Gallery.Admin/preview/2015-04-01/GalleryItem.json
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
  output-folder: $(csharp-sdks-folder)/Generated
  clear-output-folder: true
```
