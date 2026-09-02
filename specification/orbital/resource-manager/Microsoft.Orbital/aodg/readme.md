# orbital

> see https://aka.ms/autorest

This is the AutoRest configuration file for orbital.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the orbital digital ground.

```yaml
openapi-type: arm
tag: package-2024-03-01
```

### Tag: package-2024-03-01

These settings apply only when `--tag=package-2024-03-01` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01'
input-file:
  - stable/2024-03-01/aodg.json
```

### Tag: package-2024-03-01-preview

These settings apply only when `--tag=package-2024-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-03-01-preview'
input-file:
  - preview/2024-03-01-preview/aodg.json
```