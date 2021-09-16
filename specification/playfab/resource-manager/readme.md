# playfab

> see https://aka.ms/autorest

This is the AutoRest configuration file for playfab.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the playfab.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-09-07-preview
```

### Tag: package-2021-09-07-preview

These settings apply only when `--tag=package-2021-09-07-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-07-preview'
input-file:
  - Microsoft.PlayFab/preview/2021-09-07-preview/playfab.json
```

---

# Code Generation
