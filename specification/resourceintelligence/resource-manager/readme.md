# Microsoft.ResourceIntelligence

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.ResourceIntelligence.

---

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft.ResourceIntelligence.

``` yaml
openapi-type: arm
tag: package-preview-2023-09
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.ResourceIntelligence/preview/2023-09-01-preview/resourcecopilot.json
```