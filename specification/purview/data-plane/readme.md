# Purview

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview.



---
## Getting Started
To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information
These are the global settings for the Purview API.

``` yaml
openapi-type: data-plane
tag: package-2018-12-01-preview
title: AzurePurviewScanningClient
```


### Tag: package-2018-12-01-preview

These settings apply only when `--tag=package-2018-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2018-12-01-preview'
input-file:
- Azure.Data.Purview.Scanning/preview/2018-12-01-preview/scanningService.json
modelerfour:
  lenient-model-deduplication: true
```

---
# Code Generation

## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
output-folder: $(csharp-sdks-folder)/Purview/ScanningClient/Generated
add-credentials: true
sync-methods: all
license-header: MICROSOFT_MIT_NO_VERSION
namespace: Microsoft.Azure.Purview.ScanningClient
clear-output-folder: true
```

## Python

See configuration in [readme.python.md](./readme.python.md)