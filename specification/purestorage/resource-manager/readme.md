# PureStorage.Block

> see https://aka.ms/autorest

This is the AutoRest configuration file for PureStorage.Block.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the PureStorage.Block.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-11-01
```

### Tag: package-2024-11-01

These settings apply only when `--tag=package-2024-11-01` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01'
input-file:
  - PureStorage.Block/stable/2024-11-01/purestorage.json

suppressions:
 - code: PathContainsResourceType
   reason: The resource provider name 'PureStorage.Block' cannot have 'Microsoft' in it as it is a Azure Native ISV service`.
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - PureStorage.Block/preview/2024-10-01-preview/purestorage.json

suppressions:
 - code: PathContainsResourceType
   reason: The resource provider name 'PureStorage.Block' cannot have 'Microsoft' in it as it is a Azure Native ISV service`.
```

### Tag: package-2024-11-01-preview

These settings apply only when `--tag=package-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-11-01-preview'
input-file:
  - PureStorage.Block/preview/2024-11-01-preview/purestorage.json

suppressions:
 - code: PathContainsResourceType
   reason: The resource provider name 'PureStorage.Block' cannot have 'Microsoft' in it as it is a Azure Native ISV service`.
```
