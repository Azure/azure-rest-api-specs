# Azure Purview Catalog

> see https://aka.ms/autorest
This is the AutoRest configuration file for Purview Catalog.

---

## Getting Started

To build the SDK for Purview, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`
To see additional help and options, run:
> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Catalog API.

``` yaml
openapi-type: data-plane
tag: package-2025-06-16-preview
```

### Tag: package-2025-06-16-preview

These settings apply only when `--tag=package-2025-06-16-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-06-16-preview'
input-file:
  - Microsoft.Purview.Catalog.ApiService/preview/2025-06-16-preview/CatalogApiService.json
```

---

# Code Generation

## C-Sharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Microsoft.Azure.Purview.CatalogClient
  add-credentials: true
  output-folder: $(csharp-sdks-folder)/purview/Microsoft.Azure.Purview.Catalog/src/Generated
  clear-output-folder: true
```
