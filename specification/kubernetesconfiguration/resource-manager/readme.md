# kubernetesconfiguration

> see https://aka.ms/autorest

This is the AutoRest configuration file for KubernetesConfiguration.

## Getting Started

To build the SDKs for KubernetesConfiguration, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the KubernetesConfiguration.

``` yaml
title: SourceControlConfigurationClient
description: KubernetesConfiguration Client
openapi-type: arm
tag: package-preview-2022-01
```

---


### Tag: package-preview-2022-01

These settings apply only when `--tag=package-preview-2022-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-01'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/extensionTypes.json
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/extensions.json
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/fluxconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/kubernetesconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2022-01-01-preview/operations.json
```
### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2021-09-01/extensions.json
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

### Tag: package-preview-2021-11

These settings apply only when `--tag=package-preview-2021-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-11'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/extensions.json
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/extensionTypes.json
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/kubernetesconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/fluxconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2021-11-01-preview/operations.json
```

### Tag: package-2021-09

These settings apply only when `--tag=package-2021-09` is specified on the command line.

``` yaml $(tag) == 'package-2021-09'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2021-09-01/extensions.json
```

### Tag: package-preview-2021-05

These settings apply only when `--tag=package-preview-2021-05` is specified on the command line.

``` yaml $(tag) == 'package-preview-2021-05'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2021-05-01-preview/extensions.json
  - Microsoft.KubernetesConfiguration/preview/2021-05-01-preview/extensionTypes.json
  - Microsoft.KubernetesConfiguration/preview/2021-05-01-preview/kubernetesconfiguration.json
```

### Tag: package-2021-03

These settings apply only when `--tag=package-2021-03` is specified on the command line.

``` yaml $(tag) == 'package-2021-03'
input-file:
  - Microsoft.KubernetesConfiguration/stable/2021-03-01/kubernetesconfiguration.json
```

### Tag: package-preview-2020-10

These settings apply only when `--tag=package-preview-2020-10` is specified on the command line.

``` yaml $(tag) == 'package-preview-2020-10'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2020-10-01-preview/kubernetesconfiguration.json
```

### Tag: package-2020-07-01-preview

These settings apply only when `--tag=package-2020-07-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-07-01-preview'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2020-07-01-preview/kubernetesconfiguration.json
  - Microsoft.KubernetesConfiguration/preview/2020-07-01-preview/extensions.json
```

### Tag: package-2019-11-01-preview

These settings apply only when `--tag=package-2019-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2019-11-01-preview'
input-file:
  - Microsoft.KubernetesConfiguration/preview/2019-11-01-preview/kubernetesconfiguration.json
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

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-powershell
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_kubernetesconfiguration']
  - repo: azure-resource-manager-schemas
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
