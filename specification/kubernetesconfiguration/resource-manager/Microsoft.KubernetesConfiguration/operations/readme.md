# kubernetesconfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for KubernetesConfiguration.

## Getting Started

To build the SDKs for Operations in KubernetesConfiguration, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the operations in KubernetesConfiguration.

``` yaml
title: OperationsClient
description: Operations Client
openapi-type: arm
tag: package-2025-04
```

---

### Tag: package-2025-04

These settings apply only when `--tag=package-2025-04` is specified on the command line.

``` yaml $(tag) == 'package-2025-04'
input-file:
  - stable/2025-04-01/operations.json
suppressions:
  - code: OperationsApiTenantLevelOnly
    from: operations.json
    reason: User RP limitation
  - code: OperationsApiResponseSchema
    from: operations.json
    reason: Cluster-scoped async operations endpoint uses custom schema for operation status tracking, not standard operations catalog
  - code: OperationsApiSchemaUsesCommonTypes
    from: operations.json
    reason: Cluster-scoped async operations endpoint uses custom schema for operation status tracking, not standard operations catalog
```

---

### Tag: package-2025-03

These settings apply only when `--tag=package-2025-03` is specified on the command line.

``` yaml $(tag) == 'package-2025-03'
input-file:
  - stable/2025-03-01/operations.json
suppressions:
  - code: OperationsApiTenantLevelOnly
    from: operations.json
    reason: User RP limitation
  - code: OperationsApiResponseSchema
    from: operations.json
    reason: Cluster-scoped async operations endpoint uses custom schema for operation status tracking, not standard operations catalog
  - code: OperationsApiSchemaUsesCommonTypes
    from: operations.json
    reason: Cluster-scoped async operations endpoint uses custom schema for operation status tracking, not standard operations catalog
```

---

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
input-file:
  - stable/2024-11-01/operations.json
suppressions:
  - code: OperationsApiTenantLevelOnly
    from: operations.json
    reason: User RP limitation
```

