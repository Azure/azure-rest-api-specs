# Azure Purview Catalog

> This service has been migrated to TypeSpec. For the latest specification, see the TypeSpec project at `../PurviewDataCatalog/`.

> see https://aka.ms/autorest

This is the legacy AutoRest configuration file for Purview Catalog.

**Note: This service has been migrated to TypeSpec. For active development and the latest API  
specification, please refer to the TypeSpec project located at `../PurviewDataCatalog/`.**

## TypeSpec Project

The current TypeSpec specification is located at:

- **Main TypeSpec files**: `../PurviewDataCatalog/`
- **Configuration**: `../PurviewDataCatalog/tspconfig.yaml`
- **Models**: `../PurviewDataCatalog/models.tsp`
- **Routes**: `../PurviewDataCatalog/routes.tsp`

To compile the TypeSpec specification:

```bash
cd ../PurviewDataCatalog
npx tsp compile .
```

---

## Legacy AutoRest Configuration (Deprecated)

The following configuration is maintained for backward compatibility but is deprecated.

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
  - Microsoft.Purview.UnifiedCatalog/preview/2025-06-16-preview/CatalogApiService.json
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
  output-folder: $(csharp-sdks-folder)/purview/Microsoft.Azure.Purview.UnifiedCatalog/src/Generated
  clear-output-folder: true
```
