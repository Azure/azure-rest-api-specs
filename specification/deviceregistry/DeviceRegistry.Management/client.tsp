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
@@clientName(AssetEndpointProfileProperties,
  "DeviceRegistryAssetEndpointProfileProperties",
  "csharp"
);
@@clientName(DataPoint, "DeviceRegistryDataPoint", "csharp");
@@clientName(DataPointBase, "DeviceRegistryDataPointBase", "csharp");
@@clientName(Dataset, "DeviceRegistryDataset", "csharp");
@@clientName(DiscoveredAsset, "DeviceRegistryDiscoveredAsset", "csharp");
@@clientName(DiscoveredAssetProperties,
  "DeviceRegistryDiscoveredAssetProperties",
  "csharp"
);
@@clientName(DiscoveredAssetEndpointProfile,
  "DeviceRegistryDiscoveredAssetEndpointProfile",
  "csharp"
);
@@clientName(Event, "DeviceRegistryEvent", "csharp");
@@clientName(EventBase, "DeviceRegistryEventBase", "csharp");
@@clientName(Format, "DeviceRegistrySchemaFormat", "csharp");
@@clientName(Schema, "DeviceRegistrySchema", "csharp");
@@clientName(SchemaProperties, "DeviceRegistrySchemaProperties", "csharp");
@@clientName(SchemaRegistry, "DeviceRegistrySchemaRegistry", "csharp");
@@clientName(SchemaRegistryProperties,
  "DeviceRegistrySchemaRegistryProperties",
  "csharp"
);
@@clientName(SchemaType, "DeviceRegistrySchemaType", "csharp");
@@clientName(SchemaVersion, "DeviceRegistrySchemaVersion", "csharp");
@@clientName(SchemaVersionProperties,
  "DeviceRegistrySchemaVersionProperties",
  "csharp"
);
@@clientName(BillingContainer, "DeviceRegistryBillingContainer", "csharp");
@@clientName(ExtendedLocation, "DeviceRegistryExtendedLocation", "csharp");
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(TopicRetainType, "DeviceRegistryTopicRetainType", "csharp");
@@clientName(ProvisioningState, "DeviceRegistryProvisioningState", "csharp");
@@clientName(Authentication, "DeviceRegistryUserAuthentication", "csharp");
@@clientName(Authentication, "DeviceRegistryUserAuthentication", "csharp");
@@clientName(Topic, "DeviceRegistryMqttTopic", "csharp");
@@clientName(UsernamePasswordCredentials,
  "DeviceRegistryUsernamePasswordCredentials",
  "csharp"
);
@@clientName(X509Credentials, "DeviceRegistryX509Credentials", "csharp");
