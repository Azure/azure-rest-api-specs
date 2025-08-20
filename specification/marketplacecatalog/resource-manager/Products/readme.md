# Marketplace Discovery Authenticated Products

> see https://aka.ms/autorest
This is the AutoRest configuration file for marketplaceproducts.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the marketplacecatalog.

```yaml
openapi-type: arm
tag: package-2025-05-01
```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - stable/2025-05-01/openapi.json

suppressions:
- code: BodyTopLevelProperties
  from: openapi.json
  reason: Existing fields in current APIs
- code: ParametersInPointGet
  from: openapi.json
  reason: Required query parameters for proxy 
- code: GetCollectionResponseSchema
  from: openapi.json
  reason: We returned a more detailed response that can't be aggregated in the listing API
```