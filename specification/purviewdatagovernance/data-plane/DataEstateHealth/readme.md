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

## API version alignment with UX consumers

This spec is published at `2024-02-01-preview`, which is the api-version that all current
UX consumers actually call against the Data Estate Health service today.

| UX repository | api-version used for current spec endpoints |
| --- | --- |
| UX-Extension-DataEstateHealth | `2024-02-01-preview` (all DEH spec calls; `/reporting/*` streaming endpoints, which are not in this spec, use `2025-10-01-preview`) |
| UX-Extension-Catalog | `2024-02-01-preview` (for `/settings/storageConfig`, `/settings/storageConfig/connectivity`, `/settings/mpe*`, `/analytics/schedule*`) |
| UX-Extension-DataQuality | `2024-02-01-preview` (for `GET /settings/storageConfig`) |

Service code (`ServiceVersion.cs` in the DataEstateHealth ADO repo) defines the following
preview labels: V1 = `2023-10-01-preview`, V2 = `2024-02-01-preview`, V3 = `2025-10-01-preview`.
This spec corresponds to V2, which is the version actively consumed in production. The
V3 label is reserved for future spec updates after the next service-side contract change.

Note: The older `2023-10-01-preview` default in some UX repos only applies to endpoints
that are no longer part of this spec (e.g. score endpoints removed in earlier cleanups,
and `/reports`, `/datasets/{id}/refreshes`, `/token` which are not in this spec).

---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Data Estate Health API.

``` yaml
openapi-type: data-plane
tag: package-2024-02-01-preview
```

### Tag: package-2024-02-01-preview

These settings apply only when `--tag=package-2024-02-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-02-01-preview'
input-file:
  - preview/2024-02-01-preview/DataEstateHealthApiService.json
```
