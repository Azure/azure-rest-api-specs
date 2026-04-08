import "./main.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
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
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryMgmtClient", "python");

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
@@clientName(Namespace, "DeviceRegistryNamespace", "csharp");
@@clientName(NamespaceProperties,
  "DeviceRegistryNamespaceProperties",
  "csharp"
);
@@clientName(NamespaceAsset, "DeviceRegistryNamespaceAsset", "csharp");
@@clientName(NamespaceAssetProperties,
  "DeviceRegistryNamespaceAssetProperties",
  "csharp"
);
@@clientName(NamespaceDevice, "DeviceRegistryNamespaceDevice", "csharp");
@@clientName(NamespaceDeviceProperties,
  "DeviceRegistryNamespaceDeviceProperties",
  "csharp"
);
@@clientName(NamespaceDiscoveredAsset,
  "DeviceRegistryNamespaceDiscoveredAsset",
  "csharp"
);
@@clientName(NamespaceDiscoveredAssetProperties,
  "DeviceRegistryNamespaceDiscoveredAssetProperties",
  "csharp"
);
@@clientName(NamespaceDiscoveredDevice,
  "DeviceRegistryNamespaceDiscoveredDevice",
  "csharp"
);
@@clientName(NamespaceDiscoveredDeviceProperties,
  "DeviceRegistryNamespaceDiscoveredDeviceProperties",
  "csharp"
);
@@clientName(ErrorDetails, "DeviceRegistryErrorDetails", "csharp");
@@clientName(NamespaceAssetStatus,
  "DeviceRegistryNamespaceAssetStatus",
  "csharp"
);
@@clientName(NamespaceAssetStatusDataset,
  "DeviceRegistryNamespaceAssetStatusDataset",
  "csharp"
);
@@clientName(NamespaceAssetStatusEvent,
  "DeviceRegistryNamespaceAssetStatusEvent",
  "csharp"
);
@@clientName(NamespaceAssetStatusEventGroup,
  "DeviceRegistryNamespaceAssetStatusEventGroup",
  "csharp"
);
@@clientName(NamespaceAssetStatusManagementAction,
  "DeviceRegistryNamespaceAssetStatusManagementAction",
  "csharp"
);
@@clientName(NamespaceAssetStatusManagementGroup,
  "DeviceRegistryNamespaceAssetStatusManagementGroup",
  "csharp"
);
@@clientName(NamespaceAssetStatusStream,
  "DeviceRegistryNamespaceAssetStatusStream",
  "csharp"
);
@@clientName(NamespaceMessageSchemaReference,
  "DeviceRegistryNamespaceMessageSchemaReference",
  "csharp"
);
@@clientName(StatusConfig, "DeviceRegistryStatusConfig", "csharp");
@@clientName(StatusError, "DeviceRegistryStatusError", "csharp");
@@clientName(NamespaceMigrateRequest, "NamespaceMigrateContent", "csharp");
@@clientName(BillingContainer.etag, "ETag", "csharp");
@@clientName(MqttDestinationQos, "MqttDestinationQo", "csharp");

// JavaScript Client configuration
@@clientName(Microsoft.DeviceRegistry,
  "DeviceRegistryManagementClient",
  "javascript"
);

// JavaScript SDK: use update-specific models for PoliciesV1.update to exclude
// server-side read-only and create-only fields (e.g. provisioningState, keyType, subject, etc.)
@added(Versions.v2026_03_01_preview)
@removed(Versions.v2026_04_01)
@doc("The updatable certificate configuration forCertificateConfiguration PolicyV1.")
model CertificateConfigurationUpdate {
  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration?: CertificateAuthorityConfiguration;

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration: LeafCertificateConfiguration;
}

@doc("The updatable properties of the PolicyV1.")
@added(Versions.v2025_11_01_preview)
@removed(Versions.v2026_04_01)
model PolicyUpdateProperties {
  @doc("The certificate configuration.")
  certificate?: CertificateConfigurationUpdate;
}

@doc("The type used for update operations of the PolicyV1.")
model PolicyUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: PolicyUpdateProperties;
}

@@alternateType(Microsoft.DeviceRegistry.Policies.update::parameters.properties,
  PolicyUpdate,
  "javascript"
);
