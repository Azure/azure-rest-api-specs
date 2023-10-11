# Azure AI Vision - Image Analysis

> see https://aka.ms/autorest

This is the AutoRest configuration file for Azure AI Vision - Image Analysis.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure AI Vision - Image Analysis.

```yaml
openapi-type: data-plane
tag: package-2023-04-01-preview
```

### Tag: package-2023-04-01-preview

These settings apply only when `--tag=package-2023-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-01-preview'
input-file:
  - preview/2023-04-01-preview/ImageAnalysis.json
```

### Tag: package-2023-04-01-preview (generated)

These settings apply only when `--tag=release_2023_04_01-preview_autogen` is specified on the command line.

``` yaml $(tag) == 'release_2023_04_01-preview_autogen'
input-file: 
  - preview/2023-04-01-preview/generated.json
```

---
