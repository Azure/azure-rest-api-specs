# Azure Purview Catalog

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Unified Catalog.

## TypeSpec Project

The current TypeSpec specification is located at:

- **Main TypeSpec files**: `../Azure.Analytics.Purview.UnifiedCatalog/`
- **Configuration**: `../Azure.Analytics.Purview.UnifiedCatalog/tspconfig.yaml`

To compile the TypeSpec specification:

```bash
cd ../Azure.Analytics.Purview.UnifiedCatalog
npx tsp compile .
```

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
