# Microsoft Playwright Service

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft Playwright Service.

## Getting Started

To build the SDKs for Microsoft Playwright Service API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for Microsoft Playwright Service.

```yaml
title: PlaywrightServiceClient
description: Microsoft Playwright Service Client
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-07-01-preview
```

### Tag: package-2025-07-01-preview
These settings apply only when `--tag=2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - preview/2025-07-01-preview/playwright.json
```

``` yaml
modelerfour:
  flatten-models: false
```
---