# Nexus Identity

> see https://aka.ms/autorest

This is the AutoRest configuration file for Nexus Identity.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Nexus Identity.

```yaml
openapi-type: arm
tag: package-2024-02-15-preview
```

### Tag: package-2024-02-15-preview

These settings apply only when `--tag=package-2024-02-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-15-preview'
input-file:
  - stable/2024-02-15-preview/identityset.json
  - stable/2024-02-15-preview/identityController.json
  
```
