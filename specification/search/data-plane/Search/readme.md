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
tag: package-2024-07-01
```

### Tag: package-2024-07-01

These settings apply only when `--tag=package-2024-07-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-07-01'
input-file:
- stable/2024-07-01/search.json
suppressions:
  - code: LroExtension 
    from: search.json
    reason: Legacy swagger file
```

### Tag: package-searchindex-2024-07-01

These settings apply only when `--tag=package-searchindex-2024-07-01` is specified on the command line.

``` yaml $(tag) == 'package-searchindex-2024-07-01'
input-file:
- stable/2024-07-01/searchindex.json
suppressions:
  - code: LroExtension 
    from: searchindex.json
    reason: Legacy swagger file
```

### Tag: package-searchservice-2024-07-01

These settings apply only when `--tag=package-searchservice-2024-07-01` is specified on the command line.

``` yaml $(tag) == 'package-searchservice-2024-07-01'
input-file:
- stable/2024-07-01/searchservice.json
suppressions:
  - code: LroExtension 
    from: searchservice.json
    reason: Legacy swagger file
```

### Suppression
``` yaml
directive:
  - suppress: INVALID_TYPE
```
