
# ChangeSafety

> see https://aka.ms/autorest

This is the AutoRest configuration file for ChangeSafety.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Validation.

```yaml
openapi-type: arm
tag: package-2025-01-15-preview
openapi-subtype: providerHub
```

### Tag: package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - preview/2024-10-01-preview/validation.json
```

### Tag: package-2025-01-15-preview

These settings apply only when `--tag=package-2025-01-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-01-15-preview'
input-file:
  - preview/2025-01-15-preview/validation.json
```

---