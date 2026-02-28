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

// ==================== Resource type renames (prepend-rp-prefix) ====================
@@clientName(Microsoft.AzureStackHCI.Cluster, "HciCluster", "csharp");
@@clientName(Microsoft.AzureStackHCI.Extension, "ArcExtension", "csharp");
@@clientName(Microsoft.AzureStackHCI.EdgeDevice, "HciEdgeDevice", "csharp");
@@clientName(Microsoft.AzureStackHCI.HciEdgeDevice,
  "HciArcEnabledEdgeDevice",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciEdgeDeviceProperties,
  "HciArcEnabledEdgeDeviceProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSetting,
  "HciClusterDeploymentSetting",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Offer, "HciClusterOffer", "csharp");
@@clientName(Microsoft.AzureStackHCI.Publisher,
  "HciClusterPublisher",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SecuritySetting,
  "HciClusterSecuritySetting",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Sku, "HciSku", "csharp");
@@clientName(Microsoft.AzureStackHCI.Update, "HciClusterUpdate", "csharp");
@@clientName(Microsoft.AzureStackHCI.UpdateRun,
  "HciClusterUpdateRun",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.UpdateSummaries,
  "HciClusterUpdateSummary",
  "csharp"
);

// ==================== Model/enum type renames ====================
// From prepend-rp-prefix
@@clientName(Microsoft.AzureStackHCI.ProvisioningState,
  "HciProvisioningState",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterDesiredProperties,
  "HciClusterDesiredProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterNode, "HciClusterNode", "csharp");
@@clientName(Microsoft.AzureStackHCI.ClusterReportedProperties,
  "HciClusterReportedProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.AvailabilityType,
  "HciAvailabilityType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HealthState, "HciHealthState", "csharp");
@@clientName(Microsoft.AzureStackHCI.PackageVersionInfo,
  "HciPackageVersionInfo",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PrecheckResult,
  "HciPrecheckResult",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PrecheckResultTags,
  "HciPrecheckResultTags",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SkuMappings, "HciSkuMappings", "csharp");
@@clientName(Microsoft.AzureStackHCI.StatusLevelTypes,
  "HciStatusLevelType",
  "csharp"
);

// From rename-mapping: Extension → Arc prefix
@@clientName(Microsoft.AzureStackHCI.ExtensionInstanceView,
  "HciExtensionInstanceView",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionInstanceViewStatus,
  "ArcExtensionInstanceViewStatus",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionManagedBy,
  "ArcExtensionManagedBy",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionAggregateState,
  "ArcExtensionAggregateState",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionUpgradeParameters,
  "ArcExtensionUpgradeContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionPatchParameters,
  "ArcExtensionPatchContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DefaultExtensionDetails,
  "ArcDefaultExtensionDetails",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PasswordCredential,
  "ArcPasswordCredential",
  "csharp"
);

// From rename-mapping: Cluster-related renames
@@clientName(Microsoft.AzureStackHCI.Status, "HciClusterStatus", "csharp");
@@clientName(Microsoft.AzureStackHCI.ArcIdentityResponse,
  "ArcIdentityResult",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterIdentityResponse,
  "HciClusterIdentityResult",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DiagnosticLevel,
  "HciClusterDiagnosticLevel",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ImdsAttestation,
  "ImdsAttestationState",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.UploadCertificateRequest,
  "HciClusterCertificateContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterPatch, "HciClusterPatch", "csharp");
@@clientName(Microsoft.AzureStackHCI.ConnectivityStatus,
  "HciClusterConnectivityStatus",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.OperationType,
  "HciClusterOperationType",
  "csharp"
);

// From rename-mapping: Update-related renames
@@clientName(Microsoft.AzureStackHCI.PerNodeState, "PerNodeArcState", "csharp");
@@clientName(Microsoft.AzureStackHCI.RebootRequirement,
  "HciNodeRebootRequirement",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Severity, "UpdateSeverity", "csharp");
@@clientName(Microsoft.AzureStackHCI.State, "HciUpdateState", "csharp");
@@clientName(Microsoft.AzureStackHCI.Step, "HciUpdateStep", "csharp");
@@clientName(Microsoft.AzureStackHCI.UpdatePrerequisite,
  "HciClusterUpdatePrerequisite",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.UpdateSummariesPropertiesState,
  "HciClusterUpdateState",
  "csharp"
);

// From rename-mapping: Deployment renames
@@clientName(Microsoft.AzureStackHCI.DeploymentConfiguration,
  "HciClusterDeploymentConfiguration",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentData,
  "HciClusterDeploymentInfo",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentMode,
  "EceDeploymentMode",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings,
  "HciClusterDeploymentSecuritySettings",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentStep,
  "HciClusterDeploymentStep",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentCluster,
  "HciDeploymentCluster",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.InfrastructureNetwork,
  "DeploymentSettingInfrastructureNetwork",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.IpPools,
  "DeploymentSettingIPPools",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.NetworkController,
  "DeploymentSettingNetworkController",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Observability,
  "DeploymentSettingObservability",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PhysicalNodes,
  "DeploymentSettingPhysicalNodes",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.QosPolicyOverrides,
  "DeploymentSettingQosPolicyOverrides",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ScaleUnits,
  "DeploymentSettingScaleUnits",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Storage,
  "DeploymentSettingStorage",
  "csharp"
);

// From rename-mapping: EdgeDevice/Security renames
@@clientName(Microsoft.AzureStackHCI.EdgeDeviceProperties,
  "HciEdgeDeviceProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeviceConfiguration,
  "HciEdgeDeviceConfiguration",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeviceState,
  "HciEdgeDeviceState",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.NicDetail,
  "HciEdgeDeviceNicDetail",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ReportedProperties,
  "HciEdgeDeviceReportedProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SwitchDetail,
  "HciEdgeDeviceSwitchDetail",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SwitchExtension,
  "HciEdgeSwitchExtension",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ValidateRequest,
  "HciEdgeDeviceValidateContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ValidateResponse,
  "HciEdgeDeviceValidateResult",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.AccessLevel,
  "HciClusterAccessLevel",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ComplianceAssignmentType,
  "HciClusterComplianceAssignmentType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ComplianceStatus,
  "HciClusterComplianceStatus",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciOsProfile, "HciOSProfile", "csharp");

// From rename-mapping: RemoteSupport/LogCollection renames
@@clientName(Microsoft.AzureStackHCI.LogCollectionRequestProperties,
  "LogCollectionContentProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.LogCollectionRequest,
  "LogCollectionContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.RemoteSupportRequestProperties,
  "RemoteSupportContentProperties",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.RemoteSupportRequest,
  "RemoteSupportContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.EceSecrets, "EceSecret", "csharp");
@@clientName(Microsoft.AzureStackHCI.SoftwareAssuranceChangeRequest,
  "SoftwareAssuranceChangeContent",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionPatch,
  "ArcExtensionPatch",
  "csharp"
);

// ==================== Property renames ====================
@@clientName(Microsoft.AzureStackHCI.ClusterReportedProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SecurityComplianceStatus.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PackageVersionInfo.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SoftwareAssuranceProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);

@@clientName(Microsoft.AzureStackHCI.DeploymentStep.startTimeUtc,
  "StartOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentStep.endTimeUtc,
  "EndOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.hvciProtection,
  "IsHvciProtectionEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.drtmProtection,
  "IsDrtmProtectionEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.driftControlEnforced,
  "IsDriftControlEnforced",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.credentialGuardEnforced,
  "IsCredentialGuardEnforced",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.smbSigningEnforced,
  "IsSmbSigningEnforced",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.smbClusterEncryption,
  "IsSmbClusterEncryptionEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.sideChannelMitigationEnforced,
  "IsSideChannelMitigationEnforced",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.bitlockerBootVolume,
  "IsBitlockerBootVolumeEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.bitlockerDataVolumes,
  "AreBitlockerDataVolumesEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.DeploymentSecuritySettings.wdacEnforced,
  "IsWdacEnforced",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Observability.streamingDataClient,
  "IsStreamingDataClientEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Observability.euLocation,
  "IsEULocation",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.Observability.episodicDataUpload,
  "IsEpisodicDataUploadEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.SwitchExtension.extensionEnabled,
  "IsExtensionEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionPatchParameters.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.NicDetail.ip4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciNicDetail.ip4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.RemoteSupportProperties.expirationTimeStamp,
  "ExpireOn",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.RemoteSupportRequestProperties.expirationTimeStamp,
  "ExpireOn",
  "csharp"
);

// ==================== Accessibility overrides ====================
@@access(Microsoft.AzureStackHCI.State, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.RebootRequirement, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.AvailabilityType, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.Step, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.ExtensionProfile, Access.public, "csharp");
@@access(Microsoft.AzureStackHCI.ExtensionInstanceView,
  Access.public,
  "csharp"
);

// ==================== Property casing renames (backward compat) ====================
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingHostNetwork.enableStorageAutoIp,
  "EnableStorageAutoIP",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciEdgeDeviceHostNetwork.enableStorageAutoIp,
  "EnableStorageAutoIP",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.PhysicalNodes.ipv4Address, "IPv4Address", "csharp");
@@clientName(Microsoft.AzureStackHCI.DeploymentSettingStorageAdapterIPInfo.ipv4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciEdgeDeviceStorageAdapterIPInfo.ipv4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.QosPolicyOverrides.bandwidthPercentage_SMB,
  "BandwidthPercentageSmb",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.QosPolicyOverrides.priorityValue8021Action_SMB,
  "PriorityValue8021ActionSmb",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterNode.osDisplayVersion,
  "OSDisplayVersion",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ClusterNode.osName, "OSName", "csharp");
@@clientName(Microsoft.AzureStackHCI.ClusterNode.osVersion, "OSVersion", "csharp");
@@clientName(Microsoft.AzureStackHCI.InfrastructureNetwork.ipPools, "IPPools", "csharp");
@@clientName(Microsoft.AzureStackHCI.PrecheckResult.targetResourceID,
  "TargetResourceId",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.HciReportedProperties.osProfile,
  "OSProfile",
  "csharp"
);

// ==================== Enum value casing renames ====================
@@clientName(Microsoft.AzureStackHCI.EceSecrets.AzureStackLCMUserCredential,
  "AzureStackLcmUserCredential",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.EceSecrets.DefaultARBApplication,
  "DefaultArbApplication",
  "csharp"
);

// ==================== Property name renames (backward compat) ====================
@@clientName(Microsoft.AzureStackHCI.ExtensionParameters.type,
  "ArcExtensionType",
  "csharp"
);
@@clientName(Microsoft.AzureStackHCI.ExtensionParameters.autoUpgradeMinorVersion,
  "ShouldAutoUpgradeMinorVersion",
  "csharp"
);

// ==================== Misc fixes ====================
// CS0542 fix: KubernetesVersionProperties.version flattens to property named
// same as enclosing type KubernetesVersion
@@clientName(Microsoft.AzureStackHCI.KubernetesVersionProperties.version,
  "kubernetesVersionValue",
  "csharp"
);

// CS0102 fix: Step.lastUpdatedTimeUtc → LastUpdatedOn collides with
// UpdateRunProperties.lastUpdatedTime → LastUpdatedOn (generator naming bug)
// Fix: rename UpdateRunProperties.lastUpdatedTime to LastCompletedOn (matches old SDK name)
@@clientName(Microsoft.AzureStackHCI.UpdateRunProperties.lastUpdatedTime,
  "LastCompletedOn",
  "csharp"
);

// CS0108 fix: UpdateRun.name hides ResourceData.Name
@@clientName(Microsoft.AzureStackHCI.UpdateRun.name, "updateRunName", "csharp");

// ==================== Type overrides (uuid format) ====================
// Old autorest.md had -|uuid format override for these string properties
@@alternateType(Microsoft.AzureStackHCI.ClusterReportedProperties.clusterId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterProperties.cloudId,
  Azure.Core.uuid,
  "csharp"
);
// ClusterProperties identity/AAD fields
@@alternateType(Microsoft.AzureStackHCI.ClusterProperties.aadClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterProperties.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterProperties.aadApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterProperties.aadServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ClusterPatchProperties identity/AAD fields
@@alternateType(Microsoft.AzureStackHCI.ClusterPatchProperties.aadClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterPatchProperties.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
// ClusterIdentityResponseProperties
@@alternateType(Microsoft.AzureStackHCI.ClusterIdentityResponseProperties.aadClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterIdentityResponseProperties.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterIdentityResponseProperties.aadServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ClusterIdentityResponseProperties.aadApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ArcSettingProperties
@@alternateType(Microsoft.AzureStackHCI.ArcSettingProperties.arcApplicationClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcSettingProperties.arcApplicationTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcSettingProperties.arcServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcSettingProperties.arcApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ArcIdentityResponseProperties
@@alternateType(Microsoft.AzureStackHCI.ArcIdentityResponseProperties.arcApplicationClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcIdentityResponseProperties.arcApplicationTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcIdentityResponseProperties.arcServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.ArcIdentityResponseProperties.arcApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// PerNodeState
@@alternateType(Microsoft.AzureStackHCI.PerNodeState.arcNodeServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
// Location: string -> azureLocation for backward compatibility
@@alternateType(Microsoft.AzureStackHCI.Update.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.UpdateRun.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(Microsoft.AzureStackHCI.UpdateSummaries.location,
  Azure.Core.azureLocation,
  "csharp"
);
