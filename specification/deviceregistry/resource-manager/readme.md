# Azure Device Registry

> see https://aka.ms/autorest

## Getting Started

To build the SDKs for Azure Device Registry, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Device Registry.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2022-05-21-preview
```

### Tag: package-2022-05-21-preview

These settings apply only when `--tag=package-2022-05-21-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-05-21-preview'
input-file:
  - Microsoft.DeviceRegistry/preview/2022-05-21-preview/deviceregistry.json
```
