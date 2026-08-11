# edgesites

> see https://aka.ms/autorest

This is the AutoRest configuration file for edge sites.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---
## Suppression

``` yaml
directive:
  - suppress: OperationsAPIImplementation
    from: sites.json
    reason: Microsoft.Edge RP consist of multiple resources which are owned/maintained by different teams, so we follow folder structure for Service Group (explained here https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster?tab=readme-ov-file#folder-structure-for-service-group). We do have operations api exposed from common-location/folder (https://github.com/Azure/azure-rest-api-specs-pr/blob/RPSaaSMaster/specification/edge/resource-manager/Microsoft.Edge/edge/preview/2024-02-01-preview/operations.json#L46C5-L46C43) so every resource need not expose it separately. There has been open issue [Avocado] Support service group folder scenario azure-sdk-tools#6201 for the same.
  - suppress: TenantLevelAPIsNotAllowed
    where:
      - $.paths["/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}"]
    from: sites.json
    reason: Adding tenant level API to enable site creation on service groups, have got the case reviewed from ARM and PAS team as per documentation
  - suppress: AvoidAdditionalProperties
    where:
      - $.definitions.SiteProperties.properties.labels
      - $.definitions.SiteUpdateProperties.properties.labels
    from: sites.json
    reason: labels describe user defined tags to be used on Sites.
  - suppress: ExtensionResourcePathPattern
    where:
      - $.paths["/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites/{siteName}"]
      - $.paths["/providers/Microsoft.Management/serviceGroups/{servicegroupName}/providers/Microsoft.Edge/sites"]
    from: sites.json
    reason:  This approach was necessitated by the current limitations in TypeSpec, which does not support defining parent resources at the tenant level for extension resource types.
```

## Configuration

### Basic Information

These are the global settings for the edgesites.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-01
```

### Tag: package-2025-06-01

These settings apply only when `--tag=package-2025-06-01` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01'
input-file:
  - stable/2025-06-01/sites.json
```

### Tag: package-2025-03-01-preview

These settings apply only when `--tag=package-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/sites.json
```

### Tag: package-2024-02-01-preview

These settings apply only when `--tag=package-2024-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-01-preview'
input-file:
  - preview/2024-02-01-preview/sites.json
```
---

# Code Generation

## Az

See configuration in [readme.az.md](./readme.az.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Java

See configuration in [readme.java.md](./readme.java.md)
