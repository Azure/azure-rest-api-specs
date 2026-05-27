# AzureResilienceManagement

> see https://aka.ms/autorest

This is the AutoRest configuration file for AzureResilienceManagement.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the AzureResilienceManagement.

```yaml
title: AzureResilienceManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-04-01-preview
```

### Tag: package-2026-04-01-preview

These settings apply only when `--tag=package-2026-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-01-preview'
input-file:
  - preview/2026-04-01-preview/openapi.json
```

### Tag: package-2026-03-01-preview

These settings apply only when `--tag=package-2026-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01-preview'
input-file:
  - preview/2026-03-01-preview/openapi.json
```

### Tag: package-2025-02-01-preview

These settings apply only when `--tag=package-2025-02-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01-preview'
input-file:
  - preview/2025-02-01-preview/openapi.json
```

### Suppression

```yaml

suppressions:
    - code: AvoidAdditionalProperties
      from: openapi.json
      reason: Passed as script parameters to downstream RP - Runbook of Microsoft.Automation
      where: $.definitions.RecoveryGroupCustomRunbookAction.properties.parameters

    - code: AvoidAnonymousTypes
      from: openapi.json
      reason: This is being reported in pre-defined Azure.ResourceManager.CommonTypes.ManagedServiceIdentityUpdate

    - code: TenantLevelAPIsNotAllowed
      from: openapi.json
      reason: Resiliency scenarios are modelled around a SG (Service Group), which is a Tenant level resource.

    - code: XMSSecretInResponse
      from: openapi.json
      where: $.definitions.ServiceGroupTenantParameters.properties.skipToken
      reason: skipToken is the standard Azure OData paging continuation token ($skipToken), not a secret. The linter flags it due to the Token substring in the name; the property carries opaque pagination state and is not sensitive.
```
