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

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2023-05-01/operations.json
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

### Tag: package-preview-2023-05

These settings apply only when `--tag=package-preview-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-05'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2023-05-01/operations.json
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

### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-11-01/operations.json
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

### Tag: package-2022-07

These settings apply only when `--tag=package-2022-07` is specified on the command line.

```yaml $(tag) == 'package-2022-07'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-07-01/operations.json
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

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-04'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-03-01/operations.json
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

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-03-01/operations.json
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

### Tag: package-preview-2022-01-15

These settings apply only when `--tag=package-preview-2022-01-15` is specified on the command line..

``` yaml $(tag) == 'package-preview-2022-01-15'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/operations.json
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

### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/operations.json
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

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/operations.json
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

