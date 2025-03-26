# AzureZonalNetworkManager

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureZonalNetworkManager.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the AzureZonalNetworkManager.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-03-26-preview
```

### Tag: package-2025-03-26-preview

These settings apply only when `--tag=package-2025-03-26-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-03-26-preview'
input-file:
  - Microsoft.AzureZonalNetworkManager/preview/2025-03-26-preview/openapi.json
```
