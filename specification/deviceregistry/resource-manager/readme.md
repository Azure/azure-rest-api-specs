# Azure Device Registry

> see https://aka.ms/autorest

## Getting Started

To build the SDKs for Azure Device Registry, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Device Registry.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2026-11-02
```

```yaml
modelerfour:
  flatten-models: false
```

### Tag: package-preview-2026-11-02

These settings apply only when `--tag=package-preview-2026-11-02` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-11-02'
input-file:
  - Microsoft.DeviceRegistry/preview/2026-11-02-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetExecuteActionRequest.properties.payload
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceObservability.properties.endpoints
    reason: Endpoint keys are customer-supplied endpoint names and therefore cannot be predefined; each value is strongly typed as an ObservabilityEndpoint. All endpoints in this repository follow this dictionary pattern.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Management.properties.endpoints
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceProvisioning.properties.endpoints
      - $.definitions.NamespaceUpdating.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: endpoints are a customer defined property bag of any key but well defined value types.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AgentInfo.properties.compatibilityProperties
      - $.definitions.TargetDevices.properties.compatProperties
    reason: Free-form compatibility properties reported by the device update agent; keys are not known ahead of time.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.UpdateDeviceAttributeProperties
      - $.definitions.UserDeviceAttributeProperties
    reason: Customer-defined opaque bag; arbitrary value types must be accepted.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
  - code: XMSSecretInResponse
    from:
      - deviceregistry.json
    where:
      - $.definitions.GroupListMembersRequest.properties.skipToken
      - $.definitions.GroupListMembersResult.properties.skipToken
      - $.definitions.JobRunResultListResponse.properties.skipToken
      - $.definitions.JobRunResultsRequest.properties.skipToken
    reason: skipToken is an opaque pagination continuation token used to page group members, not a credential or secret.
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: PatchBodyParametersSchema is suppressed for deviceregistry.json in this tag. The blocking finding is the required property OutboundIdentity.type. outboundIdentity is replaced as a whole in a PATCH (it is not merged into the existing value), so when the object is supplied type is required to disambiguate SystemAssigned vs UserAssigned. Omitting outboundIdentity preserves the current value, so PATCH remains a valid partial update. A where selector is not used because the rule reports this through a resolved $ref path that a where clause cannot reliably match. The remaining PATCH-body findings (method and retain default values) are inherited unchanged from prior GA versions.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from:
      - deviceregistry.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/asyncOperationStatuses/{operationId}"].get.parameters[2].$ref
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/operationStatuses/{operationId}"].get.parameters[2].$ref
    reason: The only remaining v5 common-types reference is LocationParameter on the operation-status routes emitted by the shared TypeSpec ARM library; all service-defined types use v6. This matches the parameter used by prior shipped versions.
  - code: AvoidNestedProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.CertificatePolicyUpdateProperties.properties.certificate
    reason: The nested certificate configuration object is an intentional grouping of related settings; current ARM guidance discourages x-ms-client-flatten, so the nested shape is preferred.
  - code: EnumInsteadOfBoolean
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceObservability.properties.enabled
    reason: enabled is a genuine boolean toggle for namespace observability with documented tri-state PATCH semantics (omitted preserves the current value; true and false explicitly set it). An enum would not improve clarity.
```

### Tag: package-preview-2026-11-01

These settings apply only when `--tag=package-preview-2026-11-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-11-01'
input-file:
  - Microsoft.DeviceRegistry/preview/2026-11-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetExecuteActionRequest.properties.payload
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Management.properties.endpoints
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceProvisioning.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: endpoints are a customer defined property bag of any key but well defined value types.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: PatchBodyParametersSchema is suppressed for deviceregistry.json in this tag. The blocking finding is the required property OutboundIdentity.type. outboundIdentity is replaced as a whole in a PATCH (it is not merged into the existing value), so when the object is supplied type is required to disambiguate SystemAssigned vs UserAssigned. Omitting outboundIdentity preserves the current value, so PATCH remains a valid partial update. A where selector is not used because the rule reports this through a resolved $ref path that a where clause cannot reliably match. The remaining PATCH-body findings (method and retain default values) are inherited unchanged from prior GA versions.
  - code: LatestVersionOfCommonTypesMustBeUsed
    from:
      - deviceregistry.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/asyncOperationStatuses/{operationId}"].get.parameters[2].$ref
      - $.paths["/subscriptions/{subscriptionId}/providers/Microsoft.DeviceRegistry/locations/{location}/operationStatuses/{operationId}"].get.parameters[2].$ref
    reason: The only remaining v5 common-types reference is LocationParameter on the operation-status routes emitted by the shared TypeSpec ARM library; all service-defined types use v6. This matches the parameter used by prior shipped versions.
  - code: AvoidNestedProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.CertificatePolicyUpdateProperties.properties.certificate
    reason: The nested certificate configuration object is an intentional grouping of related settings; current ARM guidance discourages x-ms-client-flatten, so the nested shape is preferred.
```

### Tag: package-2026-04

These settings apply only when `--tag=package-2026-04` is specified on the command line.

```yaml $(tag) == 'package-2026-04'
input-file:
  - Microsoft.DeviceRegistry/stable/2026-04-01/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceAssetProperties.properties.eventGroups
      - $.definitions.NamespaceAssetUpdateProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.eventGroups
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Management.properties.endpoints
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetExecuteActionRequest.properties.payload
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Management.properties.endpoints
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2026-03

These settings apply only when `--tag=package-preview-2026-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2026-03'
input-file:
  - Microsoft.DeviceRegistry/preview/2026-03-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceAssetProperties.properties.eventGroups
      - $.definitions.NamespaceAssetUpdateProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.eventGroups
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2025-11

These settings apply only when `--tag=package-preview-2025-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-11'
input-file:
  - Microsoft.DeviceRegistry/preview/2025-11-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceAssetProperties.properties.eventGroups
      - $.definitions.NamespaceAssetUpdateProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.eventGroups
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-2025-10

These settings apply only when `--tag=package-2025-10` is specified on the command line.

```yaml $(tag) == 'package-2025-10'
input-file:
  - Microsoft.DeviceRegistry/stable/2025-10-01/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.NamespaceAssetProperties.properties.eventGroups
      - $.definitions.NamespaceAssetUpdateProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.eventGroups
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.eventGroups
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: These are customer defined properties with variables keys but well defined value structure.
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2025-07

These settings apply only when `--tag=package-preview-2025-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-07'
input-file:
  - Microsoft.DeviceRegistry/preview/2025-07-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

```yaml $(tag) == 'package-2024-11'
input-file:
  - Microsoft.DeviceRegistry/stable/2024-11-01/deviceregistry.json
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - Microsoft.DeviceRegistry/preview/2024-09-01-preview/deviceregistry.json
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-11-01-preview/deviceregistry.json
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
```
