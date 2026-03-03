import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

// === C# backward-compat renames for property type changes ===
// Rename new typed properties to free up original names for backward-compat custom code

// ArcSettingProperties.connectivityProperties: BinaryData -> ArcConnectivityProperties
@@clientName(Microsoft.AzureStackHCI.ArcSettingProperties.connectivityProperties,
  "ArcConnectivityPropertiesConfig",
  "csharp"
);

// ArcSettingsPatchProperties.connectivityProperties: BinaryData -> ArcConnectivityProperties
@@clientName(Microsoft.AzureStackHCI.ArcSettingsPatchProperties.connectivityProperties,
  "ArcConnectivityPropertiesConfig",
  "csharp"
);

// RemoteSupportNodeSettings.arcResourceId: ResourceIdentifier -> string
@@clientName(Microsoft.AzureStackHCI.RemoteSupportNodeSettings.arcResourceId,
  "ArcResourceIdString",
  "csharp"
);

// DeploymentSettingsProperties.arcNodeResourceIds: IList<ResourceIdentifier> -> IList<string>
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingsProperties.arcNodeResourceIds,
  "ArcNodeResourceIdStrings",
  "csharp"
);

// DeploymentSettingsProperties.deploymentMode: property was settable, now read-only or moved
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingsProperties.deploymentMode,
  "EceDeploymentMode",
  "csharp"
);

// ExtensionInstanceView.status: ExtensionInstanceViewStatus -> ArcExtensionInstanceViewStatus
@@clientName(Microsoft.AzureStackHCI.ExtensionInstanceView.status,
  "ArcExtensionStatus",
  "csharp"
);

// UpdateProperties.prerequisites: IList<UpdatePrerequisite> -> IList<HciClusterUpdatePrerequisite>
@@clientName(Microsoft.AzureStackHCI.UpdateProperties.prerequisites,
  "HciClusterPrerequisites",
  "csharp"
);

// UpdateSummariesProperties.state: UpdateSummariesPropertiesState -> HciClusterUpdateState
@@clientName(Microsoft.AzureStackHCI.UpdateSummariesProperties.state,
  "HciClusterUpdateState",
  "csharp"
);

// === Java renames ===
@@clientName(Microsoft.AzureStackHCI.Update, "HciUpdate", "java");
@@clientName(Microsoft.AzureStackHCI.RemoteSupportProperties.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.RemoteSupportRequestProperties.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.PrecheckResult.targetResourceID,
  "targetResourceId",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSmb",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSmb",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingStorageNetworks.storageAdapterIPInfo,
  "storageAdapterIpInfo",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.HciEdgeDeviceStorageNetworks.storageAdapterIPInfo,
  "storageAdapterIpInfo",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingStorageAdapterIPInfo,
  "DeploymentSettingStorageAdapterIpInfo",
  "java"
);
@@clientName(Microsoft.AzureStackHCI.HciEdgeDeviceStorageAdapterIPInfo,
  "HciEdgeDeviceStorageAdapterIpInfo",
  "java"
);

@@clientName(Microsoft.AzureStackHCI, "AzureStackHCIClient", "python");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(EdgeDevice.name,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(DeploymentSetting.name,
  "default",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(SecuritySetting.name,
  "default",
  "python"
);
