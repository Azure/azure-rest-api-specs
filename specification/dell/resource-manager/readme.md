# Dell.Storage

> see https://aka.ms/autorest

This is the AutoRest configuration file for Dell.Storage.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Dell.Storage.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-21

suppressions:
  - code: AvoidAnonymousTypes
    where:
      - $.definitions["LiftrBase.Storage.ManagedServiceIdentityUpdate"].properties.userAssignedIdentities.additionalProperties
    reason: Issue with common-types
```

### Tag: package-2025-03-21-preview

These settings apply only when `--tag=package-2025-03-21-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-21-preview'
input-file:
  - Dell.Storage/preview/2025-03-21-preview/Dell.Storage.json
```

### Tag: package-2025-03-21

These settings apply only when `--tag=package-2025-03-21` is specified on the command line.

```yaml $(tag) == 'package-2025-03-21'
input-file:
  - Dell.Storage/stable/2025-03-21/Dell.Storage.json
```

---
