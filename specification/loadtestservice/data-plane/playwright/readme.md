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
openapi-type: data-plane
tag: package-2025-07-01-preview
```

### Tag: package-2025-07-01-preview
These settings apply only when `--tag=2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - preview/2025-07-01-preview/playwright.json
suppressions:
  - code: ValidResponseCodeRequired
    from: playwright.json
    reason: Need 302 response code as a product requirement to redirect the client for script execution on remote browsers provided by the service.
    where:
      - $.paths["/playwrightworkspaces/{workspaceId}/browsers"].get.responses
```
---