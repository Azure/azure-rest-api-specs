import "./main.tsp";
import "./models.tsp";
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

// C# clientName decorators for backward compatibility with old SDK type names

// CS0234 fixes: rename types to match old C# SDK names
@@clientName(Microsoft.AzureStackHCI.ProvisioningState,
  "HciProvisioningState",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PerNodeState, "PerNodeArcState", "csharp");
@@clientName(Microsoft.AzureStackHCI.AccessLevel,
  "HciClusterAccessLevel",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeviceConfiguration,
  "HciEdgeDeviceConfiguration",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeviceState, "HciEdgeDeviceState", "csharp");
@@clientName(Microsoft.AzureStackHCI.HciOsProfile, "HciOSProfile", "csharp");
@@clientName(Microsoft.AzureStackHCI.SwitchDetail,
  "HciEdgeDeviceSwitchDetail",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ComplianceStatus,
  "HciClusterComplianceStatus",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionInstanceView,
  "HciExtensionInstanceView",
  "csharp"
);

// CS0051 fixes: rename internal types to old public names + make them public
@@clientName(Microsoft.AzureStackHCI.State, "HciUpdateState", "csharp");
@@clientName(Microsoft.AzureStackHCI.RebootRequirement,
  "HciNodeRebootRequirement",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.AvailabilityType,
  "HciAvailabilityType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Step, "HciUpdateStep", "csharp");

@@access(Microsoft.AzureStackHCI.State, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.RebootRequirement, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.AvailabilityType, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.Step, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.ExtensionProfile, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.ExtensionInstanceView, Access.public, "csharp");

// Additional type renames for backward compat
@@clientName(Microsoft.AzureStackHCI.NicDetail, "HciEdgeDeviceNicDetail", "csharp");
@@clientName(Microsoft.AzureStackHCI.PackageVersionInfo,
  "HciPackageVersionInfo",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HealthState, "HciHealthState", "csharp");
@@clientName(Microsoft.AzureStackHCI.PrecheckResult, "HciPrecheckResult", "csharp");

// CS0542 fix: KubernetesVersionProperties.version flattens to property named
// same as enclosing type KubernetesVersion
@@clientName(Microsoft.AzureStackHCI.KubernetesVersionProperties.version,
  "kubernetesVersionValue",
  "csharp"
);

// CS0108 fix: UpdateRun.name hides ResourceData.Name
@@clientName(Microsoft.AzureStackHCI.UpdateRun.name, "updateRunName", "csharp");
