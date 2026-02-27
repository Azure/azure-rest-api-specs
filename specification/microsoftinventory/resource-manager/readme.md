# microsoftinventory

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Inventory.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the microsoftinventory.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-01-preview
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - Microsoft.Inventory/preview/2025-03-01-preview/microsoftinventory.json
```

### Tag: package-2024-11-01-preview

These settings apply only when `--tag=package-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-preview'
input-file:
  - Microsoft.Inventory/preview/2024-11-01-preview/microsoftinventory.json
```

### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.Inventory/preview/2024-01-01-preview/microsoftinventory.json
suppressions:
  - code: EnumInsteadOfBoolean
    where:
      - $.definitions.AdditionalStateInformation.properties.releaseNonDataRetentionResource
      - $.definitions.AdditionalStateInformation.properties.blockNewResourceCreation
      - $.definitions.ClusterProperties.properties.isClusterInBuildout
    reason: These properties should be booleans, and were set as booleans previously
```

---
