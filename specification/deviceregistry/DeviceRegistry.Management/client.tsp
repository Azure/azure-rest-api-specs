import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DeviceRegistry;

@@access(OperationStatus.get, Access.internal, "csharp");

@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryMgmt", "python");

@@clientName(Asset, "DeviceRegistryAsset", "csharp");
@@clientName(AssetStatus, "DeviceRegistryAssetStatus", "csharp");
@@clientName(AssetStatusDataset, "DeviceRegistryAssetStatusDataset", "csharp");
@@clientName(AssetStatusError, "DeviceRegistryAssetStatusError", "csharp");
@@clientName(AssetStatusEvent, "DeviceRegistryAssetStatusEvent", "csharp");
@@clientName(AssetEndpointProfile,
  "DeviceRegistryAssetEndpointProfile",
  "csharp"
);
@@clientName(DiscoveredAsset, "DeviceRegistryDiscoveredAsset", "csharp");
@@clientName(DiscoveredAssetEndpointProfile,
  "DeviceRegistryDiscoveredAssetEndpointProfile",
  "csharp"
);
@@clientName(SchemaRegistry, "DeviceRegistrySchemaRegistry", "csharp");
@@clientName(Schema, "DeviceRegistrySchema", "csharp");
@@clientName(SchemaVersion, "DeviceRegistrySchemaVersion", "csharp");
@@clientName(BillingContainer, "DeviceRegistryBillingContainer", "csharp");
@@clientName(ExtendedLocation, "DeviceRegistryExtendedLocation", "csharp");
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(ProvisioningState, "DeviceRegistryProvisioningState", "csharp");
@@clientName(Authentication, "DeviceRegistryUserAuthentication", "csharp");
@@clientName(Authentication, "DeviceRegistryUserAuthentication", "csharp");
@@clientName(Topic, "DeviceRegistryMqttTopic", "csharp");
