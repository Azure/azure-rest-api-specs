# DesktopVirtualization

> see https://aka.ms/autorest

This is the AutoRest configuration file for Desktop Virtualization.

---

## Getting Started

To build the SDK for DesktopVirtualizationClient, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the DesktopVirtualizationClient API.

```yaml
openapi-type: arm
tag: package-preview-2025-04-01-preview
```

### Tag: package-preview-2025-04-01-preview

These settings apply only when `--tag=package-preview-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04-01-preview'
input-file:
  - preview/2025-04-01-preview/desktopvirtualization.json
suppressions:
  - code: RequiredPropertiesMissingInResourceModel
    from: desktopvirtualization.json
    reason: Discussed in the ARM API office hour and get approved. Even Common type for operation result don't have the related properties. The rule seems conflict with the contract. https://github.com/Azure/azure-rest-api-specs/blob/main/specification/common-types/resource-management/v5/types.json#L270 and also https://github.com/Azure/azure-openapi-validator/pull/767#issuecomment-2732917683. There is a fix for this and is waiting for the rollout.
    where:
        - $.definitions.ResourceProviderOperationListResult
  - code: PutResponseCodes
    from: desktopvirtualization.json
    reason: Discussed in the ARM API office hour and get approved. Our service are currently returning the 200 status code not 201, and this is already in the stable version.
    where:
        - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}'].*
        - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].*
  - code: BodyTopLevelProperties
    from: desktopvirtualization.json
    reason: Our service design forces this behavior -> The response in this new API aligns with an existing API (/sessionHostManagements/default/sessionHostUpdateStatuses/default). Those 2 APIs are tightly related and will be in the same public version, so we would want to make sure they share a similar pattern.
    where:
      - $.definitions.SessionHostManagementProvisioningStatus
  - code: RequiredPropertiesMissingInResourceModel
    from: desktopvirtualization.json
    reason: Our service design forces this behavior -> The response in this new API aligns with an existing API (/sessionHostManagements/default/sessionHostUpdateStatuses/default). Those 2 APIs are tightly related and will be in the same public version, so we would want to make sure they share a similar pattern.
    where:
      - $.definitions.SessionHostManagementProvisioningStatus
```

### Tag: package-preview-2025-03-01-preview

These settings apply only when `--tag=package-preview-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03-01-preview'
input-file:
  - preview/2025-03-01-preview/desktopvirtualization.json
suppressions:
  - code: BodyTopLevelProperties
    from: desktopvirtualization.json
    reason: Our service design forces this behavior -> The response in this new API aligns with an existing API (/sessionHostManagements/default/sessionHostUpdateStatuses/default). Those 2 APIs are tightly related and will be in the same public version, so we would want to make sure they share a similar pattern.
    where:
      - $.definitions.SessionHostManagementProvisioningStatus
  - code: RequiredPropertiesMissingInResourceModel
    from: desktopvirtualization.json
    reason: Our service design forces this behavior -> The response in this new API aligns with an existing API (/sessionHostManagements/default/sessionHostUpdateStatuses/default). Those 2 APIs are tightly related and will be in the same public version, so we would want to make sure they share a similar pattern.
    where:
      - $.definitions.SessionHostManagementProvisioningStatus
```

### Tag: package-preview-2024-11-01-preview

These settings apply only when `--tag=package-preview-2024-11-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01-preview'
input-file:
  - preview/2024-11-01-preview/desktopvirtualization.json
```

### Tag: package-preview-2024-08

These settings apply only when `--tag=package-preview-2024-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-08'
input-file:
  - preview/2024-08-08-preview/desktopvirtualization.json
suppressions:
  - code: PutResponseCodes
    from: desktopvirtualization.json
    reason: Discussed in the ARM API office hour and get approved. Our service are currently returning the 200 status code not 201, and this is already in the stable version.
    where:
        - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/privateEndpointConnections/{privateEndpointConnectionName}'].*
        - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].*
```

### Tag: package-preview-2024-04

These settings apply only when `--tag=package-preview-2024-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-04'
input-file:
  - preview/2024-04-08-preview/desktopvirtualization.json
suppressions:
  - code: AvoidAdditionalProperties
    from: desktopvirtualization.json
    reason: False positive -> additionalProperties showing in the nested object properties, not at the top level. E.g. "object.vmTags.additionalProperties" and not "object.additionalProperties". We cannot manually exclude using where clauses because of an active bug on this rule. When this is fixed, we should be able to add a (single) where clause.
  - code: XmsPageableForListCalls
    from: desktopvirtualization.json
    reason: False positive -> we have a singleton element in the collection, per recommendation from ARM API review, meaning that we will never return a collection hence no need for such list annotations. Learn more about this (approved) scenario @  ARM RPC Guidance https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-contracts.md#singleton-resources
    where:
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHostManagements/default'].*
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHostManagements/default/sessionHostUpdateStatuses/default'].*
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHostConfigurations/default'].*
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/activeSessionHostConfigurations/default'].*
  - code: EvenSegmentedPathForPutOperation
    from: desktopvirtualization.json
    reason: False positive -> we have a singleton element in the collection, per recommendation from ARM API review, meaning that we won't have an "even" number of segments. Learn more about this (approved) scenario @  ARM RPC Guidance https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-contracts.md#singleton-resources
    where:
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHostManagements/default']
      - $.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/hostPools/{hostPoolName}/sessionHostConfigurations/default']
```

### Tag: package-2024-04

These settings apply only when `--tag=package-2024-04` is specified on the command line.

```yaml $(tag) == 'package-2024-04'
input-file:
  - stable/2024-04-03/desktopvirtualization.json
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2024-03-06-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    from: desktopvirtualization.json
    reason: Pattern restriction will be a breaking change. Update for next stable version. Work item to fix https://microsoft.visualstudio.com/OS/_workitems/edit/47527278
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - preview/2024-01-16-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    from: desktopvirtualization.json
    reason: Pattern restriction will be a breaking change. Update for next stable version. Work item to fix https://microsoft.visualstudio.com/OS/_workitems/edit/47527278
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - preview/2023-11-01-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    from: desktopvirtualization.json
    reason: Pattern restriction will be a breaking change. Update for next stable version. Work item to fix https://microsoft.visualstudio.com/OS/_workitems/edit/47527278
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-04-preview/desktopvirtualization.json
suppressions:
  - code: ResourceNameRestriction
    reason: HostPoolName, ApplicationGroupName, WorkspaceName, ScalingPlanName were already implemented in previous versions of the API and we cannot change naming pattern now.
```

### Tag: package-2023-09

These settings apply only when `--tag=package-2023-09` is specified on the command line.

```yaml $(tag) == 'package-2023-09'
input-file:
  - stable/2023-09-05/desktopvirtualization.json
```

### Tag: package-preview-2022-10

These settings apply only when `--tag=package-preview-2022-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-10'
input-file:
  - preview/2022-10-14-preview/desktopvirtualization.json
```

### Tag: package-2022-09

These settings apply only when `--tag=package-2022-09` is specified on the command line.

```yaml $(tag) == 'package-2022-09'
input-file:
  - stable/2022-09-09/desktopvirtualization.json
```

### Tag: package-preview-2022-04

These settings apply only when `--tag=package-preview-2022-04` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-04'
input-file:
  - preview/2022-04-01-preview/desktopvirtualization.json
```

### Tag: package-preview-2022-02

These settings apply only when `--tag=package-preview-2022-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2022-02'
input-file:
  - preview/2022-02-10-preview/desktopvirtualization.json
```

### Tag: package-preview-2021-09

These settings apply only when `--tag=package-preview-2021-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-09'
input-file:
  - preview/2021-09-03-preview/desktopvirtualization.json
```

### Tag: package-2021-07

These settings apply only when `--tag=package-2021-07` is specified on the command line.

```yaml $(tag) == 'package-2021-07'
input-file:
  - stable/2021-07-12/desktopvirtualization.json
```

### Tag: package-2019-01-23-preview

These settings apply only when `--tag=package-2019-01-23-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-01-23-preview'
input-file:
  - preview/2019-01-23-preview/desktopvirtualization.json
```

### Tag: package-2019-09-24-preview

These settings apply only when `--tag=package-2019-09-24-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-09-24-preview'
input-file:
  - preview/2019-09-24-preview/desktopvirtualization.json
```

### Tag: package-2019-12-10-preview

These settings apply only when `--tag=package-2019-12-10-preview` is specified on the command line.

```yaml $(tag) == 'package-2019-12-10-preview'
input-file:
  - preview/2019-12-10-preview/desktopvirtualization.json
```

### Tag: package-2020-09-21-preview

These settings apply only when `--tag=package-2020-09-21-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-09-21-preview'
input-file:
  - preview/2020-09-21-preview/desktopvirtualization.json
```

### Tag: package-2020-10-19-preview

These settings apply only when `--tag=package-2020-10-19-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-10-19-preview'
input-file:
  - preview/2020-10-19-preview/desktopvirtualization.json
```

### Tag: package-2020-11-02-preview

These settings apply only when `--tag=package-2020-11-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-11-02-preview'
input-file:
  - preview/2020-11-02-preview/desktopvirtualization.json
```

### Tag: package-2020-11-10-preview

```yaml $(tag) == 'package-2020-11-10-preview'
input-file:
  - preview/2020-11-10-preview/desktopvirtualization.json
```

### Tag: package-2021-01-14-preview

```yaml $(tag) == 'package-2021-01-14-preview'
input-file:
  - preview/2021-01-14-preview/desktopvirtualization.json
```

### Tag: package-2021-02-01-preview

```yaml $(tag) == 'package-2021-02-01-preview'
input-file:
  - preview/2021-02-01-preview/desktopvirtualization.json
```

### Tag: package-2021-03-09-preview

```yaml $(tag) == 'package-2021-03-09-preview'
input-file:
  - preview/2021-03-09-preview/desktopvirtualization.json
```

### Tag: package-2021-04-01-preview

```yaml $(tag) == 'package-2021-04-01-preview'
input-file:
  - preview/2021-04-01-preview/desktopvirtualization.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-net
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-node
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_desktop_virtualization']
  - repo: azure-cli-extensions
  - repo: azure-resource-manager-schemas
  - repo: azure-powershell
```

## C#

See configuration in [readme.csharp.md](./readme.csharp.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Java

See configuration in [readme.java.md](./readme.java.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## Node

See configuration in [readme.node.md](./readme.node.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)
