import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureStackHCI;

@@clientName(Microsoft.AzureStackHCI.Update, "HciUpdate", "java");
@@clientName(RemoteSupportProperties.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(RemoteSupportRequestProperties.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(PrecheckResult.targetResourceID, "targetResourceId", "java");
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "priorityValue8021ActionSmb",
  "java"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "bandwidthPercentageSmb",
  "java"
);
@@clientName(DeploymentSettingStorageNetworks.storageAdapterIPInfo,
  "storageAdapterIpInfo",
  "java"
);
@@clientName(HciEdgeDeviceStorageNetworks.storageAdapterIPInfo,
  "storageAdapterIpInfo",
  "java"
);
@@clientName(DeploymentSettingStorageAdapterIPInfo,
  "DeploymentSettingStorageAdapterIpInfo",
  "java"
);
@@clientName(HciEdgeDeviceStorageAdapterIPInfo,
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
@@clientName(Cluster, "HciCluster", "csharp");
@@clientName(Extension, "ArcExtension", "csharp");
@@clientName(EdgeDevice, "HciEdgeDevice", "csharp");
@@clientName(HciEdgeDevice, "HciArcEnabledEdgeDevice", "csharp");
@@clientName(HciEdgeDeviceProperties,
  "HciArcEnabledEdgeDeviceProperties",
  "csharp"
);
@@clientName(DeploymentSetting, "HciClusterDeploymentSetting", "csharp");
@@clientName(Offer, "HciClusterOffer", "csharp");
@@clientName(Publisher, "HciClusterPublisher", "csharp");
@@clientName(SecuritySetting, "HciClusterSecuritySetting", "csharp");
@@clientName(Sku, "HciSku", "csharp");
@@clientName(Microsoft.AzureStackHCI.Update, "HciClusterUpdate", "csharp");
@@clientName(UpdateRun, "HciClusterUpdateRun", "csharp");
@@clientName(UpdateSummaries, "HciClusterUpdateSummary", "csharp");

// ==================== Model/enum type renames ====================
// From prepend-rp-prefix
@@clientName(ProvisioningState, "HciProvisioningState", "csharp");
@@clientName(ClusterDesiredProperties, "HciClusterDesiredProperties", "csharp");
@@clientName(ClusterNode, "HciClusterNode", "csharp");
@@clientName(ClusterReportedProperties,
  "HciClusterReportedProperties",
  "csharp"
);
@@clientName(AvailabilityType, "HciAvailabilityType", "csharp");
@@clientName(HealthState, "HciHealthState", "csharp");
@@clientName(PackageVersionInfo, "HciPackageVersionInfo", "csharp");
@@clientName(PrecheckResult, "HciPrecheckResult", "csharp");
@@clientName(PrecheckResultTags, "HciPrecheckResultTags", "csharp");
@@clientName(SkuMappings, "HciSkuMappings", "csharp");
@@clientName(StatusLevelTypes, "HciStatusLevelType", "csharp");

// From rename-mapping: Extension → Arc prefix
@@clientName(ExtensionInstanceView, "ArcExtensionInstanceView", "csharp");
@@clientName(ExtensionInstanceViewStatus,
  "ArcExtensionInstanceViewStatus",
  "csharp"
);
@@clientName(ExtensionManagedBy, "ArcExtensionManagedBy", "csharp");
@@clientName(ExtensionAggregateState, "ArcExtensionAggregateState", "csharp");
@@clientName(ExtensionUpgradeParameters,
  "ArcExtensionUpgradeContent",
  "csharp"
);
@@clientName(ExtensionPatchParameters, "ArcExtensionPatchContent", "csharp");
@@clientName(DefaultExtensionDetails, "ArcDefaultExtensionDetails", "csharp");
@@clientName(PasswordCredential, "ArcPasswordCredential", "csharp");

// From rename-mapping: Cluster-related renames
@@clientName(Status, "HciClusterStatus", "csharp");
@@clientName(ArcIdentityResponse, "ArcIdentityResult", "csharp");
@@clientName(ClusterIdentityResponse, "HciClusterIdentityResult", "csharp");
@@clientName(DiagnosticLevel, "HciClusterDiagnosticLevel", "csharp");
@@clientName(ImdsAttestation, "ImdsAttestationState", "csharp");
@@clientName(UploadCertificateRequest,
  "HciClusterCertificateContent",
  "csharp"
);
@@clientName(ClusterPatch, "HciClusterPatch", "csharp");
@@clientName(ConnectivityStatus, "HciClusterConnectivityStatus", "csharp");
@@clientName(OperationType, "HciClusterOperationType", "csharp");

// From rename-mapping: Update-related renames
@@clientName(PerNodeState, "PerNodeArcState", "csharp");
@@clientName(RebootRequirement, "HciNodeRebootRequirement", "csharp");
@@clientName(Severity, "UpdateSeverity", "csharp");
@@clientName(State, "HciUpdateState", "csharp");
@@clientName(Step, "HciUpdateStep", "csharp");
@@clientName(UpdatePrerequisite, "HciClusterUpdatePrerequisite", "csharp");
@@clientName(UpdateSummariesPropertiesState, "HciClusterUpdateState", "csharp");

// From rename-mapping: Deployment renames
@@clientName(DeploymentConfiguration,
  "HciClusterDeploymentConfiguration",
  "csharp"
);
@@clientName(DeploymentData, "HciClusterDeploymentInfo", "csharp");
@@clientName(DeploymentMode, "EceDeploymentMode", "csharp");
@@clientName(DeploymentSecuritySettings,
  "HciClusterDeploymentSecuritySettings",
  "csharp"
);
@@clientName(DeploymentStep, "HciClusterDeploymentStep", "csharp");
@@clientName(DeploymentCluster, "HciDeploymentCluster", "csharp");
@@clientName(InfrastructureNetwork,
  "DeploymentSettingInfrastructureNetwork",
  "csharp"
);
@@clientName(IpPools, "DeploymentSettingIPPools", "csharp");
@@clientName(NetworkController, "DeploymentSettingNetworkController", "csharp");
@@clientName(Observability, "DeploymentSettingObservability", "csharp");
@@clientName(PhysicalNodes, "DeploymentSettingPhysicalNodes", "csharp");
@@clientName(QosPolicyOverrides,
  "DeploymentSettingQosPolicyOverrides",
  "csharp"
);
@@clientName(ScaleUnits, "DeploymentSettingScaleUnits", "csharp");
@@clientName(Storage, "DeploymentSettingStorage", "csharp");

// From rename-mapping: EdgeDevice/Security renames
@@clientName(EdgeDeviceProperties, "HciEdgeDeviceProperties", "csharp");
@@clientName(DeviceConfiguration, "HciEdgeDeviceConfiguration", "csharp");
@@clientName(DeviceState, "HciEdgeDeviceState", "csharp");
@@clientName(NicDetail, "HciEdgeDeviceNicDetail", "csharp");
@@clientName(ReportedProperties, "HciEdgeDeviceReportedProperties", "csharp");
@@clientName(SwitchDetail, "HciEdgeDeviceSwitchDetail", "csharp");
@@clientName(SwitchExtension, "HciEdgeSwitchExtension", "csharp");
@@clientName(ValidateRequest, "HciEdgeDeviceValidateContent", "csharp");
@@clientName(ValidateResponse, "HciEdgeDeviceValidateResult", "csharp");
@@clientName(AccessLevel, "HciClusterAccessLevel", "csharp");
@@clientName(ComplianceAssignmentType,
  "HciClusterComplianceAssignmentType",
  "csharp"
);
@@clientName(ComplianceStatus, "HciClusterComplianceStatus", "csharp");
@@clientName(HciOsProfile, "HciOSProfile", "csharp");

// From rename-mapping: RemoteSupport/LogCollection renames
@@clientName(LogCollectionRequestProperties,
  "LogCollectionContentProperties",
  "csharp"
);
@@clientName(LogCollectionRequest, "LogCollectionContent", "csharp");
@@clientName(RemoteSupportRequestProperties,
  "RemoteSupportContentProperties",
  "csharp"
);
@@clientName(RemoteSupportRequest, "RemoteSupportContent", "csharp");
@@clientName(EceSecrets, "EceSecret", "csharp");
@@clientName(SoftwareAssuranceChangeRequest,
  "SoftwareAssuranceChangeContent",
  "csharp"
);
@@clientName(ExtensionPatch, "ArcExtensionPatch", "csharp");

// ==================== Request → Content renames ====================
@@clientName(ChangeRingRequest, "ChangeRingContent", "csharp");
@@clientName(CheckUpdatesRequest, "CheckUpdatesContent", "csharp");
@@clientName(ClaimDeviceRequest, "ClaimDeviceContent", "csharp");
@@clientName(DownloadRequest, "DownloadContent", "csharp");
@@clientName(ProvisioningRequest, "ProvisioningContent", "csharp");
@@clientName(ReconcileArcSettingsRequest,
  "ReconcileArcSettingsContent",
  "csharp"
);
@@clientName(ReleaseDeviceRequest, "ReleaseDeviceContent", "csharp");
@@clientName(SecretsLocationsChangeRequest,
  "SecretsLocationsChangeContent",
  "csharp"
);
@@clientName(ValidateOwnershipVouchersRequest,
  "ValidateOwnershipVouchersContent",
  "csharp"
);

// ==================== Response → Result rename ====================
@@clientName(ValidateOwnershipVouchersResponse,
  "ValidateOwnershipVouchersResult",
  "csharp"
);

// ==================== Generic type name renames (add Hci prefix) ====================
@@clientName(AssemblyInfo, "HciAssemblyInfo", "csharp");
@@clientName(HardwareProfile, "HciDeploymentHardwareProfile", "csharp");
@@clientName(NetworkAdapter, "HciNetworkAdapter", "csharp");
@@clientName(OsProfile, "HciDeploymentOSProfile", "csharp");
@@clientName(UserDetails, "HciUserDetails", "csharp");
@@clientName(TimeConfiguration, "HciTimeConfiguration", "csharp");
@@clientName(WebProxyConfiguration, "HciWebProxyConfiguration", "csharp");
@@clientName(DnsZones, "HciDnsZones", "csharp");
@@clientName(IpAddressRange, "HciIPAddressRange", "csharp");
@@clientName(JobStatus, "HciJobStatus", "csharp");
@@clientName(SecretType, "HciSecretType", "csharp");
@@clientName(SecretsType, "HciSecretsType", "csharp");
@@clientName(StorageType, "HciStorageType", "csharp");
@@clientName(VolumeType, "HciVolumeType", "csharp");
@@clientName(DeviceDetail, "HciDeviceDetail", "csharp");
@@clientName(IdentityProvider, "HciIdentityProvider", "csharp");
@@clientName(KubernetesVersion, "HciKubernetesVersion", "csharp");
@@clientName(OperationDetail, "HciOperationDetail", "csharp");
@@clientName(SiteDetails, "HciSiteDetails", "csharp");
@@clientName(ProvisioningDetails, "HciProvisioningDetails", "csharp");

// ==================== Property renames ====================
@@clientName(ClusterReportedProperties.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(SecurityComplianceStatus.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(PackageVersionInfo.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(SoftwareAssuranceProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(UpdateSummariesProperties.lastChecked, "LastCheckedOn", "csharp");
@@clientName(UpdateSummariesProperties.lastUpdated, "LastUpdatedOn", "csharp");

@@clientName(DeploymentStep.startTimeUtc, "StartOn", "csharp");
@@clientName(DeploymentStep.endTimeUtc, "EndOn", "csharp");

// ==================== DateTimeOffset property renames (On suffix convention) ====================
// Only for NEW models not in GA 1.2.1 — GA models keep original names to avoid breaking changes
@@clientName(CollectLogJobProperties.fromDate, "CollectionStartOn", "csharp");
@@clientName(CollectLogJobProperties.toDate, "CollectionEndOn", "csharp");
@@clientName(CollectLogJobProperties.lastLogGenerated,
  "LastLogGeneratedOn",
  "csharp"
);
@@clientName(EdgeDeviceJobProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(EdgeDeviceJobProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(HciCollectLogJobProperties.fromDate,
  "CollectionStartOn",
  "csharp"
);
@@clientName(HciCollectLogJobProperties.toDate, "CollectionEndOn", "csharp");
@@clientName(HciCollectLogJobProperties.lastLogGenerated,
  "LastLogGeneratedOn",
  "csharp"
);
@@clientName(HciEdgeDeviceJobProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(HciEdgeDeviceJobProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(HciRemoteSupportJobProperties.expirationTimestamp,
  "ExpireOn",
  "csharp"
);
@@clientName(RemoteSupportJobNodeSettings.createdAt, "CreatedOn", "csharp");
@@clientName(RemoteSupportJobNodeSettings.updatedAt, "UpdatedOn", "csharp");
@@clientName(ReportedProperties.lastSyncTimestamp, "LastSyncedOn", "csharp");
@@clientName(EdgeMachineProperties.lastSyncTimestamp, "LastSyncedOn", "csharp");
@@clientName(EdgeMachineReportedProperties.lastUpdated,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(EdgeMachineJobProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(EdgeMachineJobProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(EdgeMachineRemoteSupportJobProperties.expirationTimestamp,
  "ExpireOn",
  "csharp"
);
@@clientName(EdgeMachineRemoteSupportNodeSettings.createdAt,
  "CreatedOn",
  "csharp"
);
@@clientName(EdgeMachineRemoteSupportNodeSettings.updatedAt,
  "UpdatedOn",
  "csharp"
);
@@clientName(EdgeMachineCollectLogJobProperties.fromDate,
  "CollectionStartOn",
  "csharp"
);
@@clientName(EdgeMachineCollectLogJobProperties.toDate,
  "CollectionEndOn",
  "csharp"
);
@@clientName(EdgeMachineCollectLogJobProperties.lastLogGenerated,
  "LastLogGeneratedOn",
  "csharp"
);
@@clientName(ClusterJobProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(ClusterJobProperties.endTimeUtc, "EndOn", "csharp");

@@clientName(DeploymentSecuritySettings.hvciProtection,
  "IsHvciProtectionEnabled",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.drtmProtection,
  "IsDrtmProtectionEnabled",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.driftControlEnforced,
  "IsDriftControlEnforced",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.credentialGuardEnforced,
  "IsCredentialGuardEnforced",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.smbSigningEnforced,
  "IsSmbSigningEnforced",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.smbClusterEncryption,
  "IsSmbClusterEncryptionEnabled",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.sideChannelMitigationEnforced,
  "IsSideChannelMitigationEnforced",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.bitlockerBootVolume,
  "IsBitlockerBootVolumeEnabled",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.bitlockerDataVolumes,
  "AreBitlockerDataVolumesEnabled",
  "csharp"
);
@@clientName(DeploymentSecuritySettings.wdacEnforced,
  "IsWdacEnforced",
  "csharp"
);
@@clientName(Observability.streamingDataClient,
  "IsStreamingDataClientEnabled",
  "csharp"
);
@@clientName(Observability.euLocation, "IsEULocation", "csharp");
@@clientName(Observability.episodicDataUpload,
  "IsEpisodicDataUploadEnabled",
  "csharp"
);
@@clientName(SwitchExtension.extensionEnabled, "IsExtensionEnabled", "csharp");
@@clientName(ExtensionPatchParameters.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(NicDetail.ip4Address, "IPv4Address", "csharp");
@@clientName(HciNicDetail.ip4Address, "IPv4Address", "csharp");
@@clientName(RemoteSupportProperties.expirationTimeStamp, "ExpireOn", "csharp");
@@clientName(RemoteSupportRequestProperties.expirationTimeStamp,
  "ExpireOn",
  "csharp"
);
@@clientName(Step.lastUpdatedTimeUtc, "LastUpdatedOn", "csharp");
@@clientName(Step.startTimeUtc, "StartOn", "csharp");
@@clientName(Step.endTimeUtc, "EndOn", "csharp");

// ==================== Accessibility overrides ====================
@@access(State, Access.public, "csharp");
@@access(RebootRequirement, Access.public, "csharp");
@@access(AvailabilityType, Access.public, "csharp");
@@access(Step, Access.public, "csharp");
@@access(ExtensionProfile, Access.public, "csharp");
@@access(ExtensionInstanceView, Access.public, "csharp");

// ==================== Usage overrides ====================
// Offer/Sku/Publisher are read-only resources (no PUT/PATCH), so the generator
// treats their properties as output-only (no setters, no public constructor).
// The old GA SDK had setters and public constructors, so we need input+output usage.
@@usage(OfferProperties, Usage.input | Usage.output, "csharp");
@@usage(SkuProperties, Usage.input | Usage.output, "csharp");
@@usage(PublisherProperties, Usage.input | Usage.output, "csharp");
@@usage(Offer, Usage.input | Usage.output, "csharp");
@@usage(Publisher, Usage.input | Usage.output, "csharp");
@@usage(EdgeDevice, Usage.input | Usage.output, "csharp");
@@usage(Sku, Usage.input | Usage.output, "csharp");

// ==================== Property casing renames (backward compat) ====================
@@clientName(DeploymentSettingHostNetwork.enableStorageAutoIp,
  "EnableStorageAutoIP",
  "csharp"
);
@@clientName(HciEdgeDeviceHostNetwork.enableStorageAutoIp,
  "EnableStorageAutoIP",
  "csharp"
);
@@clientName(PhysicalNodes.ipv4Address, "IPv4Address", "csharp");
@@clientName(DeploymentSettingStorageAdapterIPInfo.ipv4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(HciEdgeDeviceStorageAdapterIPInfo.ipv4Address,
  "IPv4Address",
  "csharp"
);
@@clientName(QosPolicyOverrides.bandwidthPercentage_SMB,
  "BandwidthPercentageSmb",
  "csharp"
);
@@clientName(QosPolicyOverrides.priorityValue8021Action_SMB,
  "PriorityValue8021ActionSmb",
  "csharp"
);
@@clientName(ClusterNode.osDisplayVersion, "OSDisplayVersion", "csharp");
@@clientName(ClusterNode.osName, "OSName", "csharp");
@@clientName(ClusterNode.osVersion, "OSVersion", "csharp");
@@clientName(InfrastructureNetwork.ipPools, "IPPools", "csharp");
@@clientName(PrecheckResult.targetResourceID, "TargetResourceId", "csharp");
@@clientName(HciReportedProperties.osProfile, "OSProfile", "csharp");

// ==================== Enum value casing renames ====================
@@clientName(EceSecrets.AzureStackLCMUserCredential,
  "AzureStackLcmUserCredential",
  "csharp"
);
@@clientName(EceSecrets.DefaultARBApplication,
  "DefaultArbApplication",
  "csharp"
);

// ==================== Property name renames (backward compat) ====================
@@clientName(ExtensionParameters.type, "ArcExtensionType", "csharp");
@@clientName(ExtensionParameters.autoUpgradeMinorVersion,
  "ShouldAutoUpgradeMinorVersion",
  "csharp"
);
// PerNodeExtensionState: instanceView → ExtensionInstanceView (old autorest rename)
@@clientName(PerNodeExtensionState.instanceView,
  "ExtensionInstanceView",
  "csharp"
);
// ExtensionInstanceView (ArcExtensionInstanceView): type → ExtensionInstanceViewType
// Avoids CS0542 (member named same as enclosing type after rename)
@@clientName(ExtensionInstanceView.type, "ExtensionInstanceViewType", "csharp");

// ==================== Misc fixes ====================
// CS0542 fix: KubernetesVersionProperties.version flattens to property named
// same as enclosing type KubernetesVersion
@@clientName(KubernetesVersionProperties.version,
  "kubernetesVersionValue",
  "csharp"
);

// CS0102 fix: Step.lastUpdatedTimeUtc → LastUpdatedOn collides with
// UpdateRunProperties.lastUpdatedTime → LastUpdatedOn (generator naming bug)
// Fix: rename UpdateRunProperties.lastUpdatedTime to LastCompletedOn (matches old SDK name)
@@clientName(UpdateRunProperties.lastUpdatedTime, "LastCompletedOn", "csharp");

// CS0108 fix: UpdateRun.name hides ResourceData.Name
@@clientName(UpdateRun.name, "updateRunName", "csharp");

// CS0108 fix: Step.name flattens to Name on HciClusterUpdateRunData, hiding ResourceData.Name
// Old autorest flatten name was NamePropertiesProgressName
// @@clientName(Step.name, "ProgressName", "csharp");

// ==================== Type overrides (uuid format) ====================
// Old autorest.md had -|uuid format override for these string properties
@@alternateType(ClusterReportedProperties.clusterId, Azure.Core.uuid, "csharp");
@@alternateType(ClusterProperties.cloudId, Azure.Core.uuid, "csharp");
// ClusterProperties identity/AAD fields
@@alternateType(ClusterProperties.aadClientId, Azure.Core.uuid, "csharp");
@@alternateType(ClusterProperties.aadTenantId, Azure.Core.uuid, "csharp");
@@alternateType(ClusterProperties.aadApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ClusterProperties.aadServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ClusterPatchProperties identity/AAD fields
@@alternateType(ClusterPatchProperties.aadClientId, Azure.Core.uuid, "csharp");
@@alternateType(ClusterPatchProperties.aadTenantId, Azure.Core.uuid, "csharp");
// ClusterIdentityResponseProperties
@@alternateType(ClusterIdentityResponseProperties.aadClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ClusterIdentityResponseProperties.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ClusterIdentityResponseProperties.aadServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ClusterIdentityResponseProperties.aadApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ArcSettingProperties
@@alternateType(ArcSettingProperties.arcApplicationClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcSettingProperties.arcApplicationTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcSettingProperties.arcServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcSettingProperties.arcApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// ArcIdentityResponseProperties
@@alternateType(ArcIdentityResponseProperties.arcApplicationClientId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcIdentityResponseProperties.arcApplicationTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcIdentityResponseProperties.arcServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcIdentityResponseProperties.arcApplicationObjectId,
  Azure.Core.uuid,
  "csharp"
);
// PerNodeState
@@alternateType(PerNodeState.arcNodeServicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
// Location: string -> azureLocation for backward compatibility
@@alternateType(Microsoft.AzureStackHCI.Update.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(UpdateRun.location, Azure.Core.azureLocation, "csharp");
@@alternateType(UpdateSummaries.location, Azure.Core.azureLocation, "csharp");
// Old GA had ResourceIdentifier type for these string properties
@@alternateType(RemoteSupportNodeSettings.arcResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DeploymentSettingsProperties.arcNodeResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
// Old GA had BinaryData type for connectivityProperties
@@alternateType(ArcSettingProperties.connectivityProperties, unknown, "csharp");
@@alternateType(ArcSettingsPatchProperties.connectivityProperties,
  unknown,
  "csharp"
);
// Old GA had Nullable<EceDeploymentMode> — spec changed from optional to required
@@alternateType(DeploymentSettingsProperties.deploymentMode,
  DeploymentMode | null,
  "csharp"
);
