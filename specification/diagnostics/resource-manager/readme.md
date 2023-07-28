# Microsoft.Diagnostics

> see https://aka.ms/autorest

This is the AutoRest configuration file for Diagnostics.


## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the codespaces.

---
```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2020-07-01-preview
```

### Tag: package-2020-07-01-preview

These settings apply only when `--tag=package-2020-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-07-01-preview'
input-file:
  - Microsoft.Diagnostics/preview/2020-07-01-preview/diagnostics.json
```

---
```yaml
openapi-type: arm
tag: package-2020-07-01-preview
```

## Suppression

``` yaml
directive:
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code for PATCH API.
    from: diagnostics.json
    where: $.paths["/{scope}/providers/Microsoft.Diagnostics/apollo/{resourceName}"].patch["x-ms-long-running-operation"]
```

# Code Generation
