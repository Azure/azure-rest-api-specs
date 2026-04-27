import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.NetApp;

@@clientName(Microsoft.NetApp,
  "NetAppManagementClient",
  "java,python,javascript"
);

// Snapshot is not updatable
@@scope(Microsoft.NetApp.Snapshots.update, "!java");

// rename QuotaItem to SubscriptionQuotaItem, avoid break in SDK
@@clientName(QuotaItem, "SubscriptionQuotaItem", "java");

// Fix property name case changes
@@clientName(Microsoft.NetApp.AccountProperties.nfsV4IDDomain,
  "nfsV4IdDomain",
  "java"
);

// Fix property name case changes
@@clientName(Microsoft.NetApp.AccountPropertiesPatch.nfsV4IDDomain,
  "nfsV4IdDomain",
  "java"
);

@@clientName(Microsoft.NetApp.ActiveDirectory.kdcIP, "kdcIp", "java");
@@clientName(Microsoft.NetApp.ActiveDirectory.ldapOverTLS,
  "ldapOverTls",
  "java"
);
@@clientName(Microsoft.NetApp.RemotePath.externalHostName,
  "externalHostname",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.accessedTimeStamp,
  "accessedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.modifiedTimeStamp,
  "modifiedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.changedTimeStamp,
  "changedTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.creationTimeStamp,
  "creationTimestamp",
  "java"
);
@@clientName(Microsoft.NetApp.VolumeGroupListProperties.groupMetaData,
  "groupMetadata",
  "java"
);
@@clientName(Microsoft.NetApp.VolumeGroupProperties.groupMetaData,
  "groupMetadata",
  "java"
);
@@clientName(Microsoft.NetApp.NetAppProvisioningState,
  "ProvisioningState",
  "java"
);

// Fix model name changes
@@clientName(Microsoft.NetApp.VolumeGroupMetaData,
  "VolumeGroupMetadata",
  "java"
);

@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLDAPUserRequest",
  "go,python"
);

@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLDAPUserResponse",
  "go,python"
);

@@clientName(Microsoft.NetApp.NetAppProvisioningState,
  "NetappProvisioningState",
  "go"
);

@@clientName(Microsoft.NetApp.ReplicationSchedule._10minutely,
  "$DO_NOT_NORMALIZE$\"10Minutely\"",
  "javascript"
);

@@clientName(QuotaItem, "SubscriptionQuotaItem", "go");
@@clientName(QuotaItemList, "SubscriptionQuotaItemList", "go");
@@clientName(QuotaItemProperties, "SubscriptionQuotaItemProperties", "go");

// =============================================================================
// C# customizations (csharp scope)
// =============================================================================

// --- C# backward-compat enum (closed enum to preserve System.Enum base) ---

// --- Preserve SDK-facing NetAppProvisioningState naming for backward compat ---
// Old SDK (1.15.0) had NetAppProvisioningState as a closed System.Enum. The spec models it
// as an extensible union; using a union here would emit a `readonly partial struct`, breaking
// ApiCompat. Use a closed `enum` so the C# emitter generates `public enum NetAppProvisioningState`.
/** Compatibility alias for NetApp provisioning state values. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backward compat: must be closed enum to preserve System.Enum base type from v1.15.0."
enum NetAppProvisioningStateDef {
  /** The request has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being patched. */
  Patching: "Patching",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource is being moved. */
  Moving: "Moving",

  /** The operation failed. */
  Failed: "Failed",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The resource is provisioning. */
  Provisioning: "Provisioning",
}

// --- C# backward-compat union (unified relationship status) ---

// --- Fix status model RelationshipStatus type to use unified NetAppRelationshipStatus ---
// Old SDK had RelationshipStatus as NetAppRelationshipStatus? on all three status models.
/** Compatibility alias for NetApp relationship status values. */
union NetAppRelationshipStatusDef {
  string,

  /** The relationship is idle. */
  Idle: "Idle",

  /** The relationship is transferring data. */
  Transferring: "Transferring",

  /** The relationship failed. */
  Failed: "Failed",

  /** The relationship state is unknown. */
  Unknown: "Unknown",
}

// --- @@clientName: model and property renames for C# ---
@@clientName(CachePropertiesExportPolicy,
  "NetAppCachePropertiesExportPolicy",
  "csharp"
);

// C# model renames to match existing SDK API surface
@@clientName(QosType, "CapacityPoolQosType", "csharp");
@@clientName(ActiveDirectory, "NetAppAccountActiveDirectory", "csharp");
@@clientName(AccountEncryption, "NetAppAccountEncryption", "csharp");
@@clientName(Replication, "NetAppVolumeReplication", "csharp");
@@clientName(DailySchedule, "SnapshotPolicyDailySchedule", "csharp");
@@clientName(HourlySchedule, "SnapshotPolicyHourlySchedule", "csharp");
@@clientName(MonthlySchedule, "SnapshotPolicyMonthlySchedule", "csharp");
@@clientName(WeeklySchedule, "SnapshotPolicyWeeklySchedule", "csharp");
@@clientName(ActiveDirectoryStatus,
  "NetAppAccountActiveDirectoryStatus",
  "csharp"
);
@@clientName(LdapSearchScopeOpt,
  "NetAppLdapSearchScopeConfiguration",
  "csharp"
);
@@clientName(ReplicationSchedule, "NetAppReplicationSchedule", "csharp");

// C# AZC0030/AZC0032 naming compliance: Request→Content, Response→Result
@@clientName(AuthorizeRequest,
  "NetAppVolumeAuthorizeReplicationContent",
  "csharp"
);
@@clientName(BackupsMigrationRequest, "BackupsMigrationContent", "csharp");
@@clientName(BreakFileLocksRequest,
  "NetAppVolumeBreakFileLocksContent",
  "csharp"
);
@@clientName(BreakReplicationRequest,
  "NetAppVolumeBreakReplicationContent",
  "csharp"
);
@@clientName(ChangeZoneRequest, "ChangeZoneContent", "csharp");
@@clientName(CheckAvailabilityResponse,
  "NetAppCheckAvailabilityResult",
  "csharp"
);
@@clientName(CheckElasticVolumeFilePathAvailabilityRequest,
  "CheckElasticVolumeFilePathAvailabilityContent",
  "csharp"
);
@@clientName(ClusterPeerCommandResponse, "ClusterPeerCommandResult", "csharp");
@@clientName(EncryptionTransitionRequest,
  "NetAppEncryptionTransitionContent",
  "csharp"
);
@@clientName(FilePathAvailabilityRequest,
  "NetAppFilePathAvailabilityContent",
  "csharp"
);
@@clientName(GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLdapUserContent",
  "csharp"
);
@@clientName(GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLdapUserResult",
  "csharp"
);
@@clientName(GetKeyVaultStatusResponse, "NetAppKeyVaultStatusResult", "csharp");
@@clientName(ListQuotaReportResponse,
  "NetAppVolumeQuotaReportListResult",
  "csharp"
);
@@clientName(ListReplicationsRequest, "ListReplicationsContent", "csharp");
@@clientName(PeerClusterForVolumeMigrationRequest,
  "PeerClusterForVolumeMigrationContent",
  "csharp"
);
@@clientName(PoolChangeRequest, "NetAppVolumePoolChangeContent", "csharp");
@@clientName(QueryNetworkSiblingSetRequest,
  "QueryNetworkSiblingSetContent",
  "csharp"
);
@@clientName(QuotaAvailabilityRequest,
  "NetAppQuotaAvailabilityContent",
  "csharp"
);
@@clientName(RansomwareSuspectsClearRequest,
  "RansomwareSuspectsClearContent",
  "csharp"
);
@@clientName(ReestablishReplicationRequest,
  "NetAppVolumeReestablishReplicationContent",
  "csharp"
);
@@clientName(RelocateVolumeRequest, "RelocateVolumeContent", "csharp");
@@clientName(ResourceNameAvailabilityRequest,
  "NetAppNameAvailabilityContent",
  "csharp"
);
@@clientName(SvmPeerCommandResponse, "SvmPeerCommandResult", "csharp");
@@clientName(UpdateNetworkSiblingSetRequest,
  "UpdateNetworkSiblingSetContent",
  "csharp"
);
@@clientName(VolumeGroupMetaData, "NetAppVolumeGroupMetadata", "csharp");

// C# prepend-rp-prefix renames (restore NetApp prefix from old SDK)
@@clientName(AvsDataStore, "NetAppAvsDataStore", "csharp");
@@clientName(ChownMode, "NetAppChownMode", "csharp");
@@clientName(DestinationReplication, "NetAppDestinationReplication", "csharp");
@@clientName(EncryptionIdentity, "NetAppEncryptionIdentity", "csharp");
@@clientName(EncryptionKeySource, "NetAppEncryptionKeySource", "csharp");
@@clientName(KeySource, "NetAppKeySource", "csharp");
@@clientName(KeyVaultPrivateEndpoint,
  "NetAppKeyVaultPrivateEndpoint",
  "csharp"
);
@@clientName(KeyVaultProperties, "NetAppKeyVaultProperties", "csharp");
@@clientName(RegionInfo, "NetAppRegionInfo", "csharp");
@@clientName(ReplicationObject, "NetAppReplicationObject", "csharp");
@@clientName(ReplicationStatus, "NetAppVolumeReplicationStatus", "csharp");
@@clientName(ReplicationType, "NetAppReplicationType", "csharp");
@@clientName(VolumePatch, "NetAppVolumePatch", "csharp");

// C# rename-mapping renames (backward compat with old autorest SDK names)
@@clientName(EnableSubvolumes, "EnableNetAppSubvolume", "csharp");
@@clientName(Exclude, "ExcludeReplicationsFilter", "csharp");
@@clientName(FileAccessLogs, "NetAppFileAccessLog", "csharp");
@@clientName(CheckNameResourceTypes,
  "NetAppNameAvailabilityResourceType",
  "csharp"
);
@@clientName(InAvailabilityReasonType, "NetAppNameUnavailableReason", "csharp");
@@clientName(NetworkFeatures, "NetAppNetworkFeature", "csharp");
@@clientName(CheckQuotaNameResourceTypes,
  "NetAppQuotaAvailabilityResourceType",
  "csharp"
);
@@clientName(SubvolumeModel, "NetAppSubvolumeMetadata", "csharp");
@@clientName(VolumeBackups, "NetAppVolumeBackupDetail", "csharp");
@@clientName(VolumePropertiesDataProtection,
  "NetAppVolumeDataProtection",
  "csharp"
);
@@clientName(VolumeGroup, "NetAppVolumeGroupResult", "csharp");
@@clientName(MountTargetProperties, "NetAppVolumeMountTarget", "csharp");
@@clientName(VolumePatchPropertiesDataProtection,
  "NetAppVolumePatchDataProtection",
  "csharp"
);
@@clientName(QuotaType, "NetAppVolumeQuotaType", "csharp");
@@clientName(VolumeRevert, "NetAppVolumeRevertContent", "csharp");
@@clientName(SecurityStyle, "NetAppVolumeSecurityStyle", "csharp");
@@clientName(SnapshotRestoreFiles,
  "NetAppVolumeSnapshotRestoreFilesContent",
  "csharp"
);
@@clientName(VolumeStorageToNetworkProximity,
  "NetAppVolumeStorageToNetworkProximity",
  "csharp"
);
@@clientName(BackupPatch, "NetAppBackupVaultBackupPatch", "csharp");
@@clientName(UsageName, "NetAppUsageName", "csharp");
@@clientName(UsageResult, "NetAppUsageResult", "csharp");
@@clientName(VolumeRelocationProperties,
  "NetAppVolumeRelocationProperties",
  "csharp"
);
@@clientName(BackupRestoreFiles,
  "NetAppVolumeBackupBackupRestoreFilesContent",
  "csharp"
);
@@clientName(VolumeGroupVolumeProperties, "NetAppVolumeGroupVolume", "csharp");
@@clientName(VolumeBackupProperties,
  "NetAppVolumeBackupConfiguration",
  "csharp"
);
@@clientName(ExportPolicyRule, "NetAppVolumeExportPolicyRule", "csharp");
@@clientName(ExportPolicyRule.unixReadOnly, "IsUnixReadOnly", "csharp");
@@clientName(ExportPolicyRule.unixReadWrite, "IsUnixReadWrite", "csharp");
@@clientName(ExportPolicyRule.cifs, "AllowCifsProtocol", "csharp");
@@clientName(ExportPolicyRule.nfsv3, "AllowNfsV3Protocol", "csharp");
@@clientName(ExportPolicyRule.nfsv41, "AllowNfsV41Protocol", "csharp");

// C# boolean property renames (restore Is*/Has* prefix from old SDK)
@@clientName(VolumeProperties.snapshotDirectoryVisible,
  "IsSnapshotDirectoryVisible",
  "csharp"
);
@@clientName(VolumeProperties.kerberosEnabled, "IsKerberosEnabled", "csharp");
@@clientName(VolumeProperties.smbEncryption,
  "IsSmbEncryptionEnabled",
  "csharp"
);
@@clientName(VolumeProperties.smbContinuouslyAvailable,
  "IsSmbContinuouslyAvailable",
  "csharp"
);
@@clientName(VolumeProperties.ldapEnabled, "IsLdapEnabled", "csharp");
@@clientName(VolumeProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(VolumeProperties.encrypted, "IsEncrypted", "csharp");
@@clientName(ActiveDirectory.aesEncryption, "IsAesEncryptionEnabled", "csharp");
@@clientName(ActiveDirectory.ldapSigning, "IsLdapSigningEnabled", "csharp");
@@clientName(ActiveDirectory.ldapOverTLS, "IsLdapOverTlsEnabled", "csharp");
@@clientName(LdapConfiguration.ldapOverTLS, "IsLdapOverTlsEnabled", "csharp");
@@clientName(LdapConfigurationPatch.ldapOverTLS,
  "IsLdapOverTlsEnabled",
  "csharp"
);
@@clientName(PoolProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(PoolPatchProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(VolumeBackupProperties.policyEnforced,
  "IsPolicyEnforced",
  "csharp"
);
@@clientName(BackupPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(ExportPolicyRule.kerberos5ReadOnly,
  "IsKerberos5ReadOnly",
  "csharp"
);
@@clientName(ExportPolicyRule.kerberos5ReadWrite,
  "IsKerberos5ReadWrite",
  "csharp"
);
@@clientName(ExportPolicyRule.kerberos5iReadOnly,
  "IsKerberos5iReadOnly",
  "csharp"
);
@@clientName(ExportPolicyRule.kerberos5iReadWrite,
  "IsKerberos5iReadWrite",
  "csharp"
);
@@clientName(ExportPolicyRule.kerberos5pReadOnly,
  "IsKerberos5pReadOnly",
  "csharp"
);
@@clientName(ExportPolicyRule.kerberos5pReadWrite,
  "IsKerberos5pReadWrite",
  "csharp"
);
@@clientName(ExportPolicyRule.hasRootAccess, "HasRootAccess", "csharp");

// C# property renames for backward compat
@@clientName(VolumeRelocationProperties.relocationRequested,
  "IsRelocationRequested",
  "csharp"
);
@@clientName(VolumeRelocationProperties.readyToBeFinalized,
  "IsReadyToBeFinalized",
  "csharp"
);
@@clientName(SubvolumeModelProperties.accessedTimeStamp,
  "AccessedOn",
  "csharp"
);
@@clientName(SubvolumeModelProperties.modifiedTimeStamp,
  "ModifiedOn",
  "csharp"
);
@@clientName(SubvolumeModelProperties.changedTimeStamp, "ChangedOn", "csharp");
@@clientName(SubvolumeModelProperties.creationTimeStamp, "CreatedOn", "csharp");
@@clientName(SnapshotPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(VolumeProperties.proximityPlacementGroup,
  "ProximityPlacementGroupId",
  "csharp"
);

// C# ARM resource renames (restore NetApp prefix on resource types)
// Volume is NOT renamed via @@clientName: doing so causes the generator to omit
// child-collection accessors (GetNetAppVolumes) on parent resources like
// CapacityPoolResource. Backward-compat NetAppVolumeResource/Data/Collection
// are provided as deprecated stubs in src/Custom instead.
@@clientName(Bucket, "NetAppBucket", "csharp");
@@clientName(Cache, "NetAppCache", "csharp");
@@clientName(ActiveDirectoryConfig, "NetAppActiveDirectoryConfig", "csharp");
@@clientName(BackupPolicy, "NetAppBackupPolicy", "csharp");
@@clientName(BackupVault, "NetAppBackupVault", "csharp");
@@clientName(Backup, "NetAppBackupVaultBackup", "csharp");
@@clientName(SubvolumeInfo, "NetAppSubvolumeInfo", "csharp");
@@clientName(VolumeQuotaRule, "NetAppVolumeQuotaRule", "csharp");
@@clientName(Snapshot, "NetAppVolumeSnapshot", "csharp");
@@clientName(VolumeGroupDetails, "NetAppVolumeGroup", "csharp");
@@clientName(ElasticAccount, "NetAppElasticAccount", "csharp");
@@clientName(ElasticBackup, "NetAppElasticBackup", "csharp");
@@clientName(ElasticBackupPolicy, "NetAppElasticBackupPolicy", "csharp");
@@clientName(ElasticBackupVault, "NetAppElasticBackupVault", "csharp");
@@clientName(ElasticCapacityPool, "NetAppElasticCapacityPool", "csharp");
@@clientName(ElasticSnapshot, "NetAppElasticSnapshot", "csharp");
@@clientName(ElasticSnapshotPolicy, "NetAppElasticSnapshotPolicy", "csharp");
@@clientName(ElasticVolume, "NetAppElasticVolume", "csharp");
@@clientName(BackupPolicyPatch, "NetAppBackupPolicyPatch", "csharp");
@@clientName(BackupVaultPatch, "NetAppBackupVaultPatch", "csharp");
// SubvolumePatchParams rename removed — derived from SubvolumeInfo resource rename
@@clientName(VolumeQuotaRulePatch, "NetAppVolumeQuotaRulePatch", "csharp");
@@clientName(ChangeKeyVault, "NetAppChangeKeyVault", "csharp");

// C# property name renames
@@clientName(KeyVaultProperties.keyVaultResourceId,
  "KeyVaultArmResourceId",
  "csharp"
);

// C# property name casing fixes
@@clientName(AccountProperties.nfsV4IDDomain, "NfsV4IdDomain", "csharp");
@@clientName(QuotaReport, "NetAppVolumeQuotaReport", "csharp");
@@clientName(QuotaReportFilterRequest, "QuotaReportFilterContent", "csharp");
@@clientName(NetAppProvisioningStateDef, "NetAppProvisioningState", "csharp");

// C# enum-member casing fixes (formerly exposed with these spellings)
@@clientName(ApplicationType.`SAP-HANA`, "SapHana", "csharp");
@@clientName(ApplicationType.ORACLE, "Oracle", "csharp");
@@clientName(EndpointType.src, "Source", "csharp");
@@clientName(EndpointType.dst, "Destination", "csharp");
@@clientName(ServiceLevel.StandardZRS, "StandardZrs", "csharp");
@@clientName(ElasticProtocolType.NFSv3, "Nfsv3", "csharp");
@@clientName(ElasticProtocolType.NFSv4, "Nfsv4", "csharp");

// Body parameter rename to restore previous property name
@@clientName(ListReplicationsRequest.exclude,
  "ExcludeReplicationsFilter",
  "csharp"
);

// VolumeRevert.snapshotId: armResourceIdentifier → string (old API had string)
@@clientName(VolumeRevert.snapshotId, "SnapshotId", "csharp");
@@clientName(NetAppRelationshipStatusDef, "NetAppRelationshipStatus", "csharp");
@@clientName(VolumePropertiesExportPolicy,
  "NetAppVolumeExportPolicy",
  "csharp"
);

// --- @@alternateType: property type overrides for C# ---
// BackupsMigrationRequest.backupVaultId: armResourceIdentifier → string (old API had string)
@@alternateType(BackupsMigrationRequest.backupVaultId, string, "csharp");

// Restore previous operation names that include the NetApp resource subject (csharp).
// NOTE: We cannot also use `@@alternateType(Azure.ResourceManager.LocationParameter.location,
// azureLocation, "csharp")` to convert the `string location` parameter to AzureLocation:
// doing so causes the mgmt emitter to drop these subscription-scoped action operations
// from the generated MockableNetAppSubscriptionResource entirely. The parameter therefore
// stays `string`; AzureLocation backward-compat overloads are added in custom code.
@@clientName(NetAppResourceOperationGroup.checkNameAvailability,
  "CheckNetAppNameAvailability",
  "csharp"
);
@@clientName(NetAppResourceOperationGroup.checkFilePathAvailability,
  "CheckNetAppFilePathAvailability",
  "csharp"
);
@@clientName(NetAppResourceOperationGroup.checkQuotaAvailability,
  "CheckNetAppQuotaAvailability",
  "csharp"
);
@@clientName(NetAppResourceOperationGroup.queryRegionInfo,
  "QueryRegionInfoNetAppResource",
  "csharp"
);
@@clientName(NetAppResourceOperationGroup.queryNetworkSiblingSet,
  "QueryNetworkSiblingSetNetAppResource",
  "csharp"
);
@@clientName(NetAppResourceOperationGroup.updateNetworkSiblingSet,
  "UpdateNetworkSiblingSetNetAppResource",
  "csharp"
);

// C# property type overrides for MountTargetProperties
@@alternateType(MountTargetProperties.mountTargetId, uuid, "csharp");
@@alternateType(MountTargetProperties.fileSystemId, uuid, "csharp");
@@alternateType(MountTargetProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);

// C# property type overrides for VolumeProperties
@@alternateType(VolumeProperties.fileSystemId, uuid, "csharp");
@@alternateType(VolumeProperties.networkSiblingSetId, uuid, "csharp");

// C# ETag and Guid property type overrides
@@alternateType(PoolProperties.poolId, uuid, "csharp");

// C# hierarchy building (restore base types for backward compat)
// First, align property types with TrackedResource expectations
// CapacityPoolPatch: restore TrackedResourceData base
@@alternateType(CapacityPoolPatch.id, armResourceIdentifier, "csharp");
@@alternateType(CapacityPoolPatch.location, azureLocation, "csharp");
@@alternateType(CapacityPoolPatch.id, armResourceIdentifier, "csharp");
@@alternateType(CapacityPoolPatch.location, azureLocation, "csharp");

// BackupPolicyPatch: restore TrackedResourceData base
@@alternateType(BackupPolicyPatch.id, armResourceIdentifier, "csharp");
@@alternateType(BackupPolicyPatch.location, azureLocation, "csharp");
@@alternateType(SnapshotPolicyPatch.id, armResourceIdentifier, "csharp");
@@alternateType(SnapshotPolicyPatch.location, azureLocation, "csharp");

// VolumePatch (renamed to NetAppVolumePatch above): restore TrackedResourceData base
@@alternateType(VolumePatch.id, armResourceIdentifier, "csharp");
@@alternateType(VolumePatch.location, azureLocation, "csharp");

// C# property type overrides (backward compat with old autorest SDK types)
@@alternateType(ReplicationObject.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BackupProperties.backupPolicyResourceId, string, "csharp");
@@alternateType(VolumeSnapshotProperties.snapshotPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ActiveDirectory.kdcIP, Azure.Core.ipV4Address, "csharp");
@@alternateType(BackupPolicyProperties.backupPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FilePathAvailabilityRequest.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AuthorizeRequest.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BackupRestoreFiles.destinationVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VolumeProperties.keyVaultPrivateEndpointResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VolumeProperties.originatingResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VolumeProperties.proximityPlacementGroup,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VolumeProperties.subnetId, armResourceIdentifier, "csharp");
@@alternateType(VolumeGroupVolumeProperties.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PoolChangeRequest.newPoolResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ReestablishReplicationRequest.sourceVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Replication.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);

// TEMPORARY: reproduce DeserializeAzureLocation bug
@@alternateType(VolumeGroup.id, armResourceIdentifier, "csharp");
@@alternateType(VolumeGroup.location, azureLocation, "csharp");
@@alternateType(NetAppProvisioningState, NetAppProvisioningStateDef, "csharp");

// --- Fix property type mismatches via @@alternateType ---
// ETag: string → Azure.Core.eTag
@@alternateType(CapacityPool.etag, Azure.Core.eTag, "csharp");
@@alternateType(NetAppAccount.etag, Azure.Core.eTag, "csharp");
@@alternateType(BackupPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(SnapshotPolicy.etag, Azure.Core.eTag, "csharp");

// Snapshot location: string → azureLocation
@@alternateType(Snapshot.location, azureLocation, "csharp");
@@alternateType(VolumeRevert.snapshotId, string, "csharp");

// VolumeProperties property type overrides for backward compat with old SDK
@@alternateType(VolumeProperties.snapshotId, string, "csharp");
@@alternateType(VolumeProperties.backupId, string, "csharp");
@@alternateType(VolumeProperties.capacityPoolResourceId,
  armResourceIdentifier,
  "csharp"
);

// VolumeGroupDetails.location: string → azureLocation (old API had AzureLocation?)
@@alternateType(VolumeGroupDetails.location, azureLocation, "csharp");
@@alternateType(VolumeGroup.location, azureLocation, "csharp");
@@alternateType(BackupStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
@@alternateType(ReplicationStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
@@alternateType(RestoreStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
// Also fix ReplicationObject.relationshipStatus
@@alternateType(ReplicationObject.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);

// --- @@access: visibility overrides for C# ---

// Make types public for C# SDK backward compatibility
@@access(VolumePropertiesExportPolicy, Access.public, "csharp");
@@access(VolumeBackupRelationshipStatus, Access.public, "csharp");
@@access(VolumeRestoreRelationshipStatus, Access.public, "csharp");

// --- @@hierarchyBuilding: restore base types for backward compat ---
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(CapacityPoolPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(BackupPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(SnapshotPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(VolumePatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for backward compat"
@@hierarchyBuilding(SubvolumeModel,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "test"
@@hierarchyBuilding(VolumeGroup,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// --- @@usage: add Usage.input to make output-only models also serializable as input (decorator appends) ---
@@usage(RegionInfoAvailabilityZoneMappingsItem, Usage.input, "csharp");
@@usage(ReplicationObject, Usage.input, "csharp");
@@usage(VolumeRevert, Usage.input, "csharp");
@@usage(RansomwareReport, Usage.input, "csharp");
@@usage(RegionInfoResource, Usage.input, "csharp");
@@usage(Snapshot, Usage.input, "csharp");
