import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DeviceRegistry;

// Java Client configuration
@@clientNamespace(Microsoft.DeviceRegistry,
  "com.azure.resourcemanager.deviceregistry",
  "java"
);

@@clientName(Microsoft.DeviceRegistry,
  "DeviceRegistryManagementClient",
  "java"
);

// Python Client configuration
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryMgmt", "python");

// CSharp Client configuration
@@scope(OperationStatus.get, "!csharp");

@@clientName(Asset, "DeviceRegistryAsset", "csharp");
@@clientName(AssetProperties.enabled, "IsEnabled", "csharp");
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
@@clientName(Authentication, "DeviceRegistryAuthentication", "csharp");
@@clientName(Topic, "DeviceRegistryTopic", "csharp");
@@clientName(UsernamePasswordCredentials,
  "DeviceRegistryUsernamePasswordCredentials",
  "csharp"
);
@@clientName(X509Credentials, "DeviceRegistryX509Credentials", "csharp");

@@alternateType(SchemaRegistryProperties.storageAccountContainerUrl,
  url,
  "csharp"
);
@@alternateType(AssetProperties.manufacturerUri, url, "csharp");
@@alternateType(AssetProperties.documentationUri, url, "csharp");
@@alternateType(BillingContainer.etag, Azure.Core.eTag, "csharp");
@@alternateType(DiscoveredAssetProperties.manufacturerUri, url, "csharp");
@@alternateType(DiscoveredAssetProperties.documentationUri, url, "csharp");
@@alternateType(SchemaRegistryProperties.storageAccountContainerUrl,
  url,
  "csharp"
);

// JavaScript Client configuration
@@clientName(Microsoft.DeviceRegistry,
  "DeviceRegistryManagementClient",
  "javascript"
);
