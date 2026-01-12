# MongoDB.Atlas RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for LiftrMongoDB service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Suppression

``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    from: openapi.json
    where: $.paths["/providers/MongoDB.Atlas/operations"]
    reason: MongoDB.Atlas namespace is business requirement.
  - suppress: PathResourceProviderNamePascalCase
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/providers/MongoDB.Atlas/organizations"]
    reason: MongoDB.Atlas namespace is business requirement.
  - suppress: PathResourceProviderNamePascalCase
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/MongoDB.Atlas/organizations"]
    reason: MongoDB.Atlas namespace is business requirement.
  - suppress: PathResourceProviderNamePascalCase
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/MongoDB.Atlas/organizations/{organizationName}"]
    reason: MongoDB.Atlas namespace is business requirement.
  - suppress: AvoidAnonymousTypes
    from: openapi.json
    reason: Typespec generated definitions contain anonymous types.
```

### Basic Information

These are the global settings for the LiftrMongoDB service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-06-01
```

### Tag: package-2025-06-01

These settings apply only when `--tag=package-2025-06-01` is specified on the command line.

```yaml $(tag) == 'package-2025-06-01'
input-file:
  - MongoDB.Atlas/stable/2025-06-01/openapi.json
```

### Tag: package-2024-11-18-preview

These settings apply only when `--tag=package-2024-11-18-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-18-preview'
input-file:
  - MongoDB.Atlas/preview/2024-11-18-preview/openapi.json
```
