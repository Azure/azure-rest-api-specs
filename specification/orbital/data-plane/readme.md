# Microsoft Planetary Computer Pro

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft Planetary Computer Pro.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the [Microsoft Planetary Computer Pro].

```yaml
openapi-type: data-plane
openapi-subtype: providerHub
tag: package-2026-04-15
```

### Tag: package-2026-04-15

These settings apply only when `--tag=package-2026-04-15` is specified on the command line.

```yaml $(tag) == 'package-2026-04-15'
input-file:
  - Microsoft.PlanetaryComputer/stable/2026-04-15/openapi.json
```

### Tag: package-2025-04-30-preview

These settings apply only when `--tag=package-2025-04-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-30-preview'
input-file:
  - Microsoft.PlanetaryComputer/preview/2025-04-30-preview/openapi.json
```
