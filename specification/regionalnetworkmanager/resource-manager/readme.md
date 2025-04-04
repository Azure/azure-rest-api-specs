# Microsoft.RegionalNetworkManager

> see https://aka.ms/autorest

This is the AutoRest configuration file for RNM.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the RNM.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-04-02-preview
```

### Tag: package-2025-04-02-preview

These settings apply only when `--tag=package-2025-04-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-02-preview'
input-file:
  - Microsoft.RegionalNetworkManager/preview/2025-04-02-preview/regionalnetworkmanager.json
```
