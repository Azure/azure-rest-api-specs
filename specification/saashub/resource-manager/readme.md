# SaaSHub

> see https://aka.ms/autorest

This is the AutoRest configuration file for SaaSHub.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the SaaSHub.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-07-01-preview
```

### Tag: package-2023-01-01-preview

These settings apply only when `--tag=package-2023-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-01-01-preview'
title: SaaSHubResourcesClient
description: SaaSHub Resource Client
input-file:
  - Microsoft.SaaSHub/preview/2023-01-01-preview/saasHub.json
  - Microsoft.SaaSHub/preview/2023-01-01-preview/saasHubOperations.json
```

### Tag: package-2024-09-30-preview

These settings apply only when `--tag=package-2024-09-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-30-preview'
title: SaaSHubResourcesClient
description: SaaSHub Resource Client
input-file:
  - Microsoft.SaaSHub/preview/2023-01-01-preview/saasHub.json
  - Microsoft.SaaSHub/preview/2023-01-01-preview/saasHubOperations.json
  - Microsoft.SaaSHub/preview/2024-09-30-preview/openapi.json
suppressions:
  - code: TenantLevelAPIsNotAllowed
    reason: Microsoft.SaaSHub/saasResource is tenant level resource/API and is approved by ARM team
```

### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
title: SaaSHubResourcesClient
description: SaaSHub Resource Client
input-file:
  - Microsoft.SaaSHub/preview/2025-07-01-preview/openapi.json
suppressions:
  - code: TenantLevelAPIsNotAllowed
    reason: Microsoft.SaaSHub/saasResource is tenant level resource/API and is approved by ARM team
```
