# kubernetesconfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for Flux KubernetesConfiguration.

## Getting Started

To build the SDKs for Flux KubernetesConfiguration, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the KubernetesConfiguration.

``` yaml
title: FluxConfigurationClient
description: KubernetesConfiguration Flux Client
openapi-type: arm
tag: package-2025-04
```

---

### Tag: package-2025-04

These settings apply only when `--tag=package-2025-04` is specified on the command line.

``` yaml $(tag) == 'package-2025-04'
input-file:
  - stable/2025-04-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```
---

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

``` yaml $(tag) == 'package-2024-11'
input-file:
  - stable/2024-11-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```

### Tag: package-2023-05

These settings apply only when `--tag=package-2023-05` is specified on the command line.

``` yaml $(tag) == 'package-2023-05'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2023-05-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```


### Tag: package-2022-11

These settings apply only when `--tag=package-2022-11` is specified on the command line.

``` yaml $(tag) == 'package-2022-11'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-11-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```

### Tag: package-2022-07

These settings apply only when `--tag=package-2022-07` is specified on the command line.

```yaml $(tag) == 'package-2022-07'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-07-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```

### Tag: package-2022-03

These settings apply only when `--tag=package-2022-03` is specified on the command line.

``` yaml $(tag) == 'package-2022-03'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2022-03-01/fluxconfiguration.json
suppressions:
  - code: OperationsAPIImplementation
    from: fluxconfiguration.json
    reason: Operations API is implemented as a separate service.
  - code: ResourceNameRestriction
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, pattern validation exists in RP.
  - code: DeleteResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, force delete does synchronous delete and returns 200.
  - code: LroLocationHeader
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible, 202 operations return Azure-Async-Operation header.
  - code: AvoidAdditionalProperties
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
  - code: PatchResponseCodes
    from: fluxconfiguration.json
    reason: Existing service contract needs to be backward compatible.
```

---

## Suppression

``` yaml
directive:
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
    from: extensions.json
  - suppress: TopLevelResourcesListBySubscription
    reason: 'Microsoft.KubernetesConfiguration is a proxy resource provider under Microsoft.Kubernetes'
    from: extensions.json
  - suppress: TopLevelResourcesListBySubscription
    reason: 'Microsoft.KubernetesConfiguration is a proxy resource provider under Microsoft.Kubernetes'
    from: extensionTypes.json
  - suppress: BodyTopLevelProperties
    where: $.definitions.Extension.properties
    from: extensions.json
    reason: |-
      https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-contracts.md#system-metadata-for-all-azure-resources

      The systemData should be top level element based on the new requirement: 
      {
        "id": "/subscriptions/{id}/resourceGroups/{group}/providers/{rpns}/{type}/{name}",
        "name": "{name}",
        "type": "{resourceProviderNamespace}/{resourceType}",
        "location": "North US",
        "systemData":{
            "createdBy": "<string>",
            "createdByType": "<User|Application|ManagedIdentity|Key>",
            "createdAt": "<date-time>",
            "lastModifiedBy": "<string>",
            "lastModifiedByType": "<User|Application|ManagedIdentity|Key>",
            "lastModifiedAt": "<date-time>"
        },
        "tags": {
          "key1": "value 1",
          "key2": "value 2"
        },
        "kind": "resource kind",
        "properties": {
          "comment": "Resource defined structure"
        }
      }
```


## Suppression

``` yaml
directive:
  - suppress: TopLevelResourcesListBySubscription
    reason: 'Microsoft.KubernetesConfiguration is a proxy resource provider under Microsoft.Kubernetes'
    from: kubernetesconfiguration.json
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
    from: extensions.json
  - suppress: TopLevelResourcesListBySubscription
    reason: 'Microsoft.KubernetesConfiguration is a proxy resource provider under Microsoft.Kubernetes'
    from: extensions.json
  - suppress: LongRunningResponseStatusCode
    reason: The validation tools do not properly recognize 202 as a supported response code.
    from: fluxconfiguration.json
  - suppress: TopLevelResourcesListBySubscription
    from: fluxconfiguration.json
    reason: 'Microsoft.KubernetesConfiguration is a proxy resource provider under Microsoft.Kubernetes and Microsoft.ContainerServices'
  - suppress: BodyTopLevelProperties
    where: $.definitions.Extension.properties
    from: extensions.json
    reason: |-
      https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-contracts.md#system-metadata-for-all-azure-resources

      The systemData should be top level element based on the new requirement: 
      {
        "id": "/subscriptions/{id}/resourceGroups/{group}/providers/{rpns}/{type}/{name}",
        "name": "{name}",
        "type": "{resourceProviderNamespace}/{resourceType}",
        "location": "North US",
        "systemData":{
            "createdBy": "<string>",
            "createdByType": "<User|Application|ManagedIdentity|Key>",
            "createdAt": "<date-time>",
            "lastModifiedBy": "<string>",
            "lastModifiedByType": "<User|Application|ManagedIdentity|Key>",
            "lastModifiedAt": "<date-time>"
        },
        "tags": {
          "key1": "value 1",
          "key2": "value 2"
        },
        "kind": "resource kind",
        "properties": {
          "comment": "Resource defined structure"
        }
      }
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_kubernetesconfiguration']
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
