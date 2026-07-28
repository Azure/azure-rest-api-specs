# Napster.CompanionAPI RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for napster service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the napster service.


```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-12-24-preview

```


```yaml
modelerfour:
  flatten-models: false

```

### Tag: package-2025-12-24-preview

These settings apply only when `--tag=package-2025-12-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-12-24-preview'
input-file:
  - Napster.CompanionAPI/preview/2025-12-24-preview/openapi.json
```
## Suppression
``` yaml
directive:
  - suppress: PathResourceProviderNamePascalCase
    from: openapi.json
    reason: This is a specific resource provider name requested by liftr partner.
