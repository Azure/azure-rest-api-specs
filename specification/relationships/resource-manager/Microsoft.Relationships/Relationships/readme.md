# relationships

> see https://aka.ms/autorest

This is the AutoRest configuration file for relationships.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the relationships.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2026-08-01
```

### Tag: package-2026-08-01

These settings apply only when `--tag=package-2026-08-01` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01'
input-file:
  - stable/2026-08-01/relationships.json
```

### Tag: package-2026-03-01-preview

These settings apply only when `--tag=package-2026-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01-preview'
input-file:
  - preview/2026-03-01-preview/relationships.json
```

### Tag: package-2023-09-01-preview

These settings apply only when `--tag=package-2023-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-preview'
input-file:
  - preview/2023-09-01-preview/relationships.json
```
