# playwrighttesting

## Deprecation Notice

**This API specification has been deprecated and will no longer be maintained after March 8, 2026**. This specification will only receive security fixes until **March 8, 2026**. To receive updates on new features and non-security bug fixes, migrate to the replacement API specification at [loadtestservice/resource-manager/Microsoft.LoadTestService/playwright](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/loadtestservice/resource-manager/Microsoft.LoadTestService/playwright). Refer to the [migration guide](https://aka.ms/mpt/migration-guidance) for guidance on upgrading.

> see https://aka.ms/autorest

This is the AutoRest configuration file for playwrighttesting.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the playwrighttesting.

```yaml
title: PlaywrightTestingClient
description: Azure Playwright testing management service
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-12-01
```

### Tag: package-2024-12-01

These settings apply only when `--tag=package-2024-12-01` is specified on the command line.

```yaml $(tag) == 'package-2024-12-01'
input-file:
  - Microsoft.AzurePlaywrightService/stable/2024-12-01/playwrighttesting.json
suppressions:
  - code: ResourceNameRestriction
    from: playwrighttesting.json
    reason: We have enums defined for quota resource names which doesn't support string pattern validation.
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Microsoft.AzurePlaywrightService/preview/2024-08-01-preview/playwrighttesting.json
suppressions:
  - code: ResourceNameRestriction
    from: playwrighttesting.json
    reason: We have enums defined for quota resource names which doesn't support string pattern validation.
```

### Tag: package-2024-01-01-preview

These settings apply only when `--tag=package-2024-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-01-01-preview'
input-file:
  - Microsoft.AzurePlaywrightService/preview/2024-01-01-preview/playwrighttesting.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Microsoft.AzurePlaywrightService/preview/2023-10-01-preview/playwrighttesting.json
```

---