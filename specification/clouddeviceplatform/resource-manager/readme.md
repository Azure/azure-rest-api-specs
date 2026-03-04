# CloudDevicePlatform

> see https://aka.ms/autorest

This is the AutoRest configuration file for CloudDevicePlatform.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the CloudDevicePlatform.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-01-01-preview
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - Microsoft.CloudDevicePlatform/preview/2024-05-01-preview/openapi.json
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - Microsoft.CloudDevicePlatform/preview/2024-06-01-preview/openapi.json
```

### Tag: package-2026-01-01-preview

These settings apply only when `--tag=package-2026-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01-preview'
input-file:
  - Microsoft.CloudDevicePlatform/preview/2026-01-01-preview/openapi.json
```
