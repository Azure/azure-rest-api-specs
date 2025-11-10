# Microsoft.Fpss

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Fpss.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft.Fpss.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-09-29-preview
```

### Tag: package-2025-09-29-preview

These settings apply only when `--tag=package-2025-09-29-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-09-29-preview'
input-file:
  - Microsoft.Fpss/preview/2025-09-29-preview/microsoft-fpss.json
```
