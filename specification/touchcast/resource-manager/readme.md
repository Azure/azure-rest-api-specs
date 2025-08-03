# Touchcast.CogCache RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for touchcast service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the touchcast service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-05-02-preview
```

```yaml
modelerfour:
  flatten-models: false
```

### Tag: package-2025-05-02-preview

These settings apply only when `--tag=package-2025-05-02-preview` is specified on the command line. 

```yaml $(tag) == 'package-2025-05-02-preview'
input-file:
  - Touchcast.CogCache/preview/2025-05-02-preview/openapi.json
```

