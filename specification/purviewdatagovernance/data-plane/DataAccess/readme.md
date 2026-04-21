# Azure Purview Data Access

> see https://aka.ms/autorest

This is the AutoRest configuration file for Purview Data Access.

## TypeSpec Project

The TypeSpec specification is located in this directory.

To compile the TypeSpec specification:

```bash
npx tsp compile .
```

---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Data Access API.

``` yaml
openapi-type: data-plane
tag: package-2023-10-01-preview
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - preview/2023-10-01-preview/DataAccessApiService.json
```
