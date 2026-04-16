# Azure Purview Data Estate Health

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Data Estate Health.

## TypeSpec Project

The TypeSpec specification is located in this directory.

To compile the TypeSpec specification:

```bash
npx tsp compile .
```

---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Data Estate Health API.

``` yaml
openapi-type: data-plane
tag: package-dataaccess-2025-11-01-preview
```

### Tag: package-dataaccess-2025-11-01-preview

These settings apply only when `--tag=package-dataaccess-2025-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-dataaccess-2025-11-01-preview'
input-file:
  - preview/2025-11-01-preview/DataEstateHealthApiService.json
```
