# Microsoft.Dsts

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.Dsts.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft.Dsts.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-04-30-preview
```

### Tag: package-2024-04-30-preview

These settings apply only when `--tag=package-2024-04-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-30-preview'
input-file:
  - Microsoft.Dsts/[[ReleaseState]]/2024-04-30-preview/Microsoft.Dsts.json
```

---
