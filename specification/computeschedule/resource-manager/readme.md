# computeschedule

> see https://aka.ms/autorest

This is the AutoRest configuration file for computeschedule.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the computeschedule.

```yaml
openapi-subtype: rpaas
openapi-type: arm
tag: package-2025-05-01

```

### Tag: package-2026-04-15-preview

These settings apply only when `--tag=package-2026-04-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-04-15-preview'
input-file:
  - Microsoft.ComputeSchedule/preview/2026-04-15-preview/computeschedule.json
suppressions:  
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionFlexPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionFlexPayload.properties.resourceOverrides.items
  - code: RemovedAdditionalProperties
    reason: Changing from Record<unknown> to strongly-typed BulkVMConfiguration to follow ARM compliance and perform validation for these properties.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: RemovedAdditionalProperties
    reason: Changing from Record<unknown> to strongly-typed BulkVMConfiguration to follow ARM compliance and perform validation for these properties.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: PostResponseCodes
    reason: ScheduledActions Disable and Enable endpoints are synchronous POST returning 200 with no body (OkResponse). These LRO rules do not apply. Keeping 200 for backward compatibility with existing API versions.
    from: computeschedule.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeSchedule/scheduledActions/{scheduledActionName}/disable"].post
  - code: PostResponseCodes
    reason: ScheduledActions Disable and Enable endpoints are synchronous POST returning 200 with no body (OkResponse). These LRO rules do not apply. Keeping 200 for backward compatibility with existing API versions.
    from: computeschedule.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeSchedule/scheduledActions/{scheduledActionName}/enable"].post
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json

```

### Tag: package-2026-03-01-preview

These settings apply only when `--tag=package-2026-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-03-01-preview'
input-file:
  - Microsoft.ComputeSchedule/preview/2026-03-01-preview/computeschedule.json
suppressions:  
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionFlexPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionFlexPayload.properties.resourceOverrides.items
  - code: PostResponseCodes
    reason: ScheduledActions Disable and Enable endpoints are synchronous POST returning 200 with no body (OkResponse). These LRO rules do not apply. Keeping 200 for backward compatibility with existing API versions.
    from: computeschedule.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeSchedule/scheduledActions/{scheduledActionName}/disable"].post
  - code: PostResponseCodes
    reason: ScheduledActions Disable and Enable endpoints are synchronous POST returning 200 with no body (OkResponse). These LRO rules do not apply. Keeping 200 for backward compatibility with existing API versions.
    from: computeschedule.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeSchedule/scheduledActions/{scheduledActionName}/enable"].post
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json

```

### Tag: package-2026-01-01-preview

These settings apply only when `--tag=package-2026-01-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-01-01-preview'
input-file:
  - Microsoft.ComputeSchedule/preview/2026-01-01-preview/computeschedule.json
suppressions:  
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json
  

```

### Tag: package-2025-04-15-preview

These settings apply only when `--tag=package-2025-04-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-04-15-preview'
input-file:
  - Microsoft.ComputeSchedule/preview/2025-04-15-preview/computeschedule.json
suppressions:  
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json

```

### Tag: package-2025-05-01

These settings apply only when `--tag=package-2025-05-01` is specified on the command line.

```yaml $(tag) == 'package-2025-05-01'
input-file:
  - Microsoft.ComputeSchedule/stable/2025-05-01/computeschedule.json
suppressions:  
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.baseProfile
  - code: AvoidAdditionalProperties
    reason: Record unknown because we are a passthrough API to compute and we can't take dependency on VirtualMachine properties for updating with version change.
    from: computeschedule.json
    where: $.definitions.ResourceProvisionPayload.properties.resourceOverrides.items
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json

```

### Tag: package-2024-10-01

These settings apply only when `--tag=package-2024-10-01` is specified on the command line.

```yaml $(tag) == 'package-2024-10-01'
input-file:
  - Microsoft.ComputeSchedule/stable/2024-10-01/computeschedule.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json
```


### Tag: package-2024-08-15-preview

These settings apply only when `--tag=package-2024-08-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-08-15-preview'
input-file:
  - Microsoft.ComputeSchedule/preview/2024-08-15-preview/computeschedule.json
suppressions:
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for settings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.settings
  - code: AvoidAdditionalProperties
    reason: This field is using the existing compute context for protectedSettings where this field is a free-form JSON object.
    from: computeschedule.json
    where: $.definitions.BulkActionVmExtensionProperties.properties.protectedSettings
  - code: DefinitionsPropertiesNamesCamelCase
    reason: The property correlationid is part of the existing API contract and cannot be renamed without a breaking change.
    from: computeschedule.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```
## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)


## CSharp 

See configuration in [readme.csharp.md](./readme.csharp.md)
