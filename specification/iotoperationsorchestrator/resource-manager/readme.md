# IoTOperationsOrchestrator

> see https://aka.ms/autorest

This is the AutoRest configuration file for IoTOperationsOrchestrator.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the IoTOperationsOrchestrator.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2023-10-04-preview
```

### Tag: package-2023-10-04-preview

These settings apply only when `--tag=package-2023-10-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-04-preview'
input-file:
  - Microsoft.IoTOperationsOrchestrator/preview/2023-10-04-preview/openapi.json
```
