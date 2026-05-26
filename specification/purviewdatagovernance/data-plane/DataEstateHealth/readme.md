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

## UX consumer status (informational)

The following UX repositories consume Data Estate Health endpoints. As of the latest review,
all UX calls against the current spec endpoints use api-version `2024-02-01-preview`. The spec
in this folder is published at `2025-10-01-preview` (matching the service's V3 label in
`ServiceVersion.cs`). UX teams should plan migration.

| UX repository | api-version used today for current spec endpoints |
| --- | --- |
| UX-Extension-DataEstateHealth | `2024-02-01-preview` (all DEH spec calls) |
| UX-Extension-Catalog | `2024-02-01-preview` (for `/actions/query`, `/settings/storageConfig`, `/settings/storageConfig/connectivity`, `/settings/mpe*`, `/analytics/schedule*`) |
| UX-Extension-DataQuality | `2024-02-01-preview` (for `/actions/query`, `GET /settings/storageConfig`) |

Note: The older `2023-10-01-preview` default in some UX repos only applies to endpoints that
are no longer part of this spec (e.g. score endpoints removed in earlier cleanups, and
`/reports`, `/datasets/{id}/refreshes`, `/token` which are not in this spec).

---

## Configuration

### Basic Information

These are the global settings for the Azure Purview Data Estate Health API.

``` yaml
openapi-type: data-plane
tag: package-2025-10-01-preview
```

### Tag: package-2025-10-01-preview

These settings apply only when `--tag=package-2025-10-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-10-01-preview'
input-file:
  - preview/2025-10-01-preview/DataEstateHealthApiService.json
```
