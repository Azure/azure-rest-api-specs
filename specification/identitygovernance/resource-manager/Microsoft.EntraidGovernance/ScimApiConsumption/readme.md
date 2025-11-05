# identitygovernance

> see https://aka.ms/autorest

This is the AutoRest configuration file for identitygovernance.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the identitygovernance.

```yaml
openapi-type: arm
openapi-subtype: rpaas
title: ScimApiConsumption
tag: package-2025-10-17-preview
```

### Tag: package-2025-10-17-preview

These settings apply only when `--tag=package-2025-10-17-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-10-17-preview'
input-file:
  - preview/2025-10-17-preview/scimopenapi.json
```