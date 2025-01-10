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
tag: package-2024-11
```

---

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
input-file:
  - stable/2024-11-01/operations.json
suppressions:
  - code: OperationsApiSchemaUsesCommonTypes
    from: operations.json
    reason: Existing service contract needs to be backward compatible.  
  - code: OperationsApiTenantLevelOnly
    from: operations.json
    reason: Existing service contract needs to be backward compatible.  
  - code: ResourceNameRestriction
    from: operations.json
    reason: Existing service contract needs to be backward compatible.  
  - code: OperationsApiResponseSchema
    from: operations.json
    reason: Existing service contract needs to be backward compatible.            
```

