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
tag: package-preview-2025-08
```

### Tag: package-preview-2025-08

These settings apply only when `--tag=package-preview-2025-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-08'
input-file:
  - Microsoft.DeviceRegistry/preview/2025-08-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
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
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredDeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
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
    reason: attributes is a customer-defined property of any shape and custom keys for other properties
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - Microsoft.DeviceRegistry/preview/2024-10-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDevicePropertiesUpdate.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetPropertiesUpdate.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

## Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - Microsoft.DeviceRegistry/preview/2024-07-01-preview/deviceregistry.json

suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DevicePropertiesUpdate.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DevicePropertiesUpdate.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: The property is generated by TypeSpec compiler
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-10-01-preview/deviceregistry.json

suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DevicePropertiesUpdate.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DevicePropertiesUpdate.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-09-01-preview/asset.json
  - Microsoft.DeviceRegistry/preview/2023-09-01-preview/assetendpointprofile.json
  - Microsoft.DeviceRegistry/preview/2023-09-01-preview/deviceregistry.json
```

### Tag: package-2023-08-01-preview

These settings apply only when `--tag=package-2023-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-08-01-preview'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-08-01-preview/asset.json
  - Microsoft.DeviceRegistry/preview/2023-08-01-preview/assetendpointprofile.json
  - Microsoft.DeviceRegistry/preview/2023-08-01-preview/deviceregistry.json
```

### Tag: package-2023-06-21-preview

These settings apply only when `--tag=package-2023-06-21-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-06-21-preview'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-06-21-preview/asset.json
  - Microsoft.DeviceRegistry/preview/2023-06-21-preview/assetendpointprofile.json
  - Microsoft.DeviceRegistry/preview/2023-06-21-preview/deviceregistry.json
```

### Tag: package-2022-05-21-preview

These settings apply only when `--tag=package-2022-05-21-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-05-21-preview'
input-file:
  - Microsoft.DeviceRegistry/preview/2022-05-21-preview/deviceregistry.json
```
