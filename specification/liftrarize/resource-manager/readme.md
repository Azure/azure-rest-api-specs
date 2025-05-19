# LiftrBasic.SampleRP RP

> see https://aka.ms/autorest

This is the AutoRest configuration file for ArizeAi service.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the ArizeAi service.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-10-01
```
### Tag:  package-2024-10-01

These settings apply only when `--tag=package-2024-10-01` is specified on the command line. 

```yaml $(tag) == 'package-2024-10-01'
input-file:
  - ArizeAi.ObservabilityEval/stable/2024-10-01/openapi.json
```

### Tag:  package-2024-10-01-preview

These settings apply only when `--tag=package-2024-10-01-preview` is specified on the command line. 

```yaml $(tag) == 'package-2024-10-01-preview'
input-file:
  - ArizeAi.ObservabilityEval/preview/2024-10-01-preview/openapi.json
```
