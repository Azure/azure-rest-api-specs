# AI Search

> see https://aka.ms/autorest

This is the AutoRest configuration file for AI Search.

---

## Getting Started

To build the SDK for AI Search, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration

### Basic Information

These are the global settings for the AI Search API.

``` yaml
# common
openapi-type: data-plane
tag: package-2025-11-01-preview
```

### Tag: package-2025-11-01-preview

These settings apply only when `--tag=package-2025-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-01-preview'
input-file:
  - preview/2025-11-01-preview/search.json
suppressions:
  - code: LroExtension
    from: search.json
    reason: Legacy swagger file
  - code: DISCRIMINATOR_VALUE_NOT_FOUND
    reason: Multi-Level Discrimination
```

### Suppression
``` yaml
directive:
  - suppress: INVALID_TYPE
```