# Microsoft Fabric

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft Fabric.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft Fabric.

```yaml
openapi-type: arm
openapi-subtype: providerHub
tag: package-2024-06-01
```

### Tag: package-2024-06-01

These settings apply only when `--tag=package-2024-06-01` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01'
input-file:
  - Microsoft.Fabric/stable/2024-06-01/privatelinkserviceforfabric.json
```