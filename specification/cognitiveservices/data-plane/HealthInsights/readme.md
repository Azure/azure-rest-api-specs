# Azure Health Insights

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Azure Health Insights SDK.

## Getting Started

To build the SDKs for this API, install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Health Insights SDK.

The current release is `2023-03-01-preview`.

```yaml
openapi-type: data-plane
tag: 2023-03-01-preview
```

### Tag: 2023-03-01-preview

These settings apply only when `--tag=2023-03-01-preview` is specified on the command line.

```yaml $(tag) == '2023-03-01-preview'
input-file:
  - preview/2023-03-01-preview/openapi.json
```

## Suppression
``` yaml
directive:
  - suppress: AvoidAnonymousTypes
    from: openapi.json
    reason: When 'allOf' is used for model composition reflecting inheritance, objects containing added properties have no type meaning
```
