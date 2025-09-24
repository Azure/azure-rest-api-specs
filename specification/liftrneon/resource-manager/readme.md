# Neon.Postgres RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for neon service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the neon service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-23-preview
```

### Tag: package-2025-06-23-preview

These settings apply only when `--tag=package-2025-06-23-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-06-23-preview'
input-file:
  - Neon.Postgres/preview/2025-06-23-preview/neon.json
suppressions:
  - code: NestedResourcesMustHaveListOperation
    reason: The GET operation for path "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Neon.Postgres/organizations/{organizationName}/projects/{projectName}/branches/{branchName}/neonRoles" returns a list of NeonRole. There isn't a point GET for this operation.
    where:
      - $.definitions["NeonRole"]
  - code: NestedResourcesMustHaveListOperation
    reason: The GET operation for path "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Neon.Postgres/organizations/{organizationName}/projects/{projectName}/branches/{branchName}/neonDatabase" returns a list of NeonDatabase. There isn't a point GET for this operation.
    where:
      - $.definitions["NeonDatabase"]
  - code: NestedResourcesMustHaveListOperation
    reason: The GET operation for path "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Neon.Postgres/organizations/{organizationName}/projects/{projectName}/branches/{branchName}/endpoint" returns a list of endpoints. There isn't a point GET for this operation.
    where:
      - $.definitions["Endpoint"]
```

### Tag: package-2025-03-01

These settings apply only when `--tag=package-2025-03-01` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01'
input-file:
  - Neon.Postgres/stable/2025-03-01/neon.json
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - Neon.Postgres/preview/2025-03-01-preview/neon.json
```

### Tag: package-2024-12-22-preview

These settings apply only when `--tag=package-2024-12-22-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-12-22-preview'
input-file:
  - Neon.Postgres/preview/2024-12-22-preview/neon.json
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Neon.Postgres/preview/2024-08-01-preview/neon.json
```
