# Inference Service Resource Provider (RP)

> see https://aka.ms/autorest

This is the AutoRest configuration file for Inference Service.

---

## Getting Started

To build the SDK for Inference Service, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Inference Service API.

``` yaml
title: InferenceServiceManagementClient
openapi-type: arm
tag: package-preview-2026-01-15-preview
```

### Tag: package-preview-2026-01-15-preview

These settings apply only when `--tag=package-preview-2026-01-15-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-01-15-preview'
input-file:
  - preview/2026-01-15-preview/InferenceService.json
```
