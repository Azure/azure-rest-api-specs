# Azure Purview Catalog

> This service has been migrated to TypeSpec. For the latest specification, see the TypeSpec project at `../Azure.Analytics.Purview.UnifiedCatalog/`.

> see https://aka.ms/autorest

This is the legacy AutoRest configuration file for Purview Catalog.

**Note: This service has been migrated to TypeSpec. For active development and the latest API  
specification, please refer to the TypeSpec project located at `../Azure.Analytics.Purview.UnifiedCatalog/`.**

## TypeSpec Project

The current TypeSpec specification is located at:

- **Main TypeSpec files**: `../Azure.Analytics.Purview.UnifiedCatalog/`
- **Configuration**: `../Azure.Analytics.Purview.UnifiedCatalog/tspconfig.yaml`
- **Models**: `../Azure.Analytics.Purview.UnifiedCatalog/models.tsp`
- **Routes**: `../Azure.Analytics.Purview.UnifiedCatalog/routes.tsp`

To compile the TypeSpec specification:

```bash
cd ../Azure.Analytics.Purview.UnifiedCatalog
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
tag: package-2025-09-15-preview
```

### Tag: package-2025-09-15-preview

These settings apply only when `--tag=package-2025-09-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-09-15-preview'
input-file:
  - Azure.Analytics.Purview.UnifiedCatalog/preview/2025-09-15-preview/CatalogApiService.json
```

---

# Code Generation

## C-Sharp

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

``` yaml $(csharp)
csharp:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: Azure.Analytics.Purview.UnifiedCatalog
  add-credentials: true
  output-folder: $(csharp-sdks-folder)/purview/Azure.Analytics.Purview.UnifiedCatalog/src/Generated
  clear-output-folder: true
```
