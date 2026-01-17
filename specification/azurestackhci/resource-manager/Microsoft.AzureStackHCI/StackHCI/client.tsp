import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

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
