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

@@clientName(Microsoft.NetApp.CachePropertiesExportPolicy,
  "NetAppCachePropertiesExportPolicy",
  "csharp"
);

// C# model renames to match existing SDK API surface
@@clientName(Microsoft.NetApp.QosType, "CapacityPoolQosType", "csharp");
@@clientName(Microsoft.NetApp.ActiveDirectory,
  "NetAppAccountActiveDirectory",
  "csharp"
);
@@clientName(Microsoft.NetApp.AccountEncryption,
  "NetAppAccountEncryption",
  "csharp"
);
@@clientName(Microsoft.NetApp.Replication, "NetAppVolumeReplication", "csharp");
@@clientName(Microsoft.NetApp.DailySchedule,
  "SnapshotPolicyDailySchedule",
  "csharp"
);
@@clientName(Microsoft.NetApp.HourlySchedule,
  "SnapshotPolicyHourlySchedule",
  "csharp"
);
@@clientName(Microsoft.NetApp.MonthlySchedule,
  "SnapshotPolicyMonthlySchedule",
  "csharp"
);
@@clientName(Microsoft.NetApp.WeeklySchedule,
  "SnapshotPolicyWeeklySchedule",
  "csharp"
);
@@clientName(Microsoft.NetApp.ActiveDirectoryStatus,
  "NetAppAccountActiveDirectoryStatus",
  "csharp"
);
@@clientName(Microsoft.NetApp.LdapSearchScopeOpt,
  "NetAppLdapSearchScopeConfiguration",
  "csharp"
);
@@clientName(Microsoft.NetApp.ReplicationSchedule,
  "NetAppReplicationSchedule",
  "csharp"
);

// C# AZC0030/AZC0032 naming compliance: Request→Content, Response→Result
@@clientName(Microsoft.NetApp.AuthorizeRequest,
  "NetAppVolumeAuthorizeReplicationContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupsMigrationRequest,
  "BackupsMigrationContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.BreakFileLocksRequest,
  "NetAppVolumeBreakFileLocksContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.BreakReplicationRequest,
  "NetAppVolumeBreakReplicationContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.ChangeZoneRequest, "ChangeZoneContent", "csharp");
@@clientName(Microsoft.NetApp.CheckAvailabilityResponse,
  "NetAppCheckAvailabilityResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.CheckElasticVolumeFilePathAvailabilityRequest,
  "CheckElasticVolumeFilePathAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.ClusterPeerCommandResponse,
  "ClusterPeerCommandResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.EncryptionTransitionRequest,
  "NetAppEncryptionTransitionContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.FilePathAvailabilityRequest,
  "NetAppFilePathAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLdapUserContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLdapUserResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.GetKeyVaultStatusResponse,
  "NetAppKeyVaultStatusResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.ListQuotaReportResponse,
  "NetAppVolumeQuotaReportListResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.ListReplicationsRequest,
  "ListReplicationsContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.PeerClusterForVolumeMigrationRequest,
  "PeerClusterForVolumeMigrationContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.PoolChangeRequest,
  "NetAppVolumePoolChangeContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.QueryNetworkSiblingSetRequest,
  "QueryNetworkSiblingSetContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.QuotaAvailabilityRequest,
  "NetAppQuotaAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.RansomwareSuspectsClearRequest,
  "RansomwareSuspectsClearContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.ReestablishReplicationRequest,
  "NetAppVolumeReestablishReplicationContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.RelocateVolumeRequest,
  "RelocateVolumeContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.ResourceNameAvailabilityRequest,
  "NetAppNameAvailabilityContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.SvmPeerCommandResponse,
  "SvmPeerCommandResult",
  "csharp"
);
@@clientName(Microsoft.NetApp.UpdateNetworkSiblingSetRequest,
  "UpdateNetworkSiblingSetContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeGroupMetaData,
  "NetAppVolumeGroupMetadata",
  "csharp"
);

// C# prepend-rp-prefix renames (restore NetApp prefix from old SDK)
@@clientName(Microsoft.NetApp.AvsDataStore, "NetAppAvsDataStore", "csharp");
@@clientName(Microsoft.NetApp.ChownMode, "NetAppChownMode", "csharp");
@@clientName(Microsoft.NetApp.DestinationReplication,
  "NetAppDestinationReplication",
  "csharp"
);
@@clientName(Microsoft.NetApp.EncryptionIdentity,
  "NetAppEncryptionIdentity",
  "csharp"
);
@@clientName(Microsoft.NetApp.EncryptionKeySource,
  "NetAppEncryptionKeySource",
  "csharp"
);
@@clientName(Microsoft.NetApp.KeySource, "NetAppKeySource", "csharp");
@@clientName(Microsoft.NetApp.KeyVaultPrivateEndpoint,
  "NetAppKeyVaultPrivateEndpoint",
  "csharp"
);
@@clientName(Microsoft.NetApp.KeyVaultProperties,
  "NetAppKeyVaultProperties",
  "csharp"
);
@@clientName(Microsoft.NetApp.RegionInfo, "NetAppRegionInfo", "csharp");
@@clientName(Microsoft.NetApp.ReplicationObject,
  "NetAppReplicationObject",
  "csharp"
);
@@clientName(Microsoft.NetApp.ReplicationStatus,
  "NetAppVolumeReplicationStatus",
  "csharp"
);
@@clientName(Microsoft.NetApp.ReplicationType,
  "NetAppReplicationType",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumePatch, "NetAppVolumePatch", "csharp");

// C# rename-mapping renames (backward compat with old autorest SDK names)
@@clientName(Microsoft.NetApp.EnableSubvolumes,
  "EnableNetAppSubvolume",
  "csharp"
);
@@clientName(Microsoft.NetApp.Exclude, "ExcludeReplicationsFilter", "csharp");
@@clientName(Microsoft.NetApp.FileAccessLogs, "NetAppFileAccessLog", "csharp");
@@clientName(Microsoft.NetApp.CheckNameResourceTypes,
  "NetAppNameAvailabilityResourceType",
  "csharp"
);
@@clientName(Microsoft.NetApp.InAvailabilityReasonType,
  "NetAppNameUnavailableReason",
  "csharp"
);
@@clientName(Microsoft.NetApp.NetworkFeatures,
  "NetAppNetworkFeature",
  "csharp"
);
@@clientName(Microsoft.NetApp.CheckQuotaNameResourceTypes,
  "NetAppQuotaAvailabilityResourceType",
  "csharp"
);
@@clientName(Microsoft.NetApp.SubvolumeModel,
  "NetAppSubvolumeMetadata",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeBackups,
  "NetAppVolumeBackupDetail",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumePropertiesDataProtection,
  "NetAppVolumeDataProtection",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeGroup, "NetAppVolumeGroupResult", "csharp");
@@clientName(Microsoft.NetApp.MountTargetProperties,
  "NetAppVolumeMountTarget",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumePatchPropertiesDataProtection,
  "NetAppVolumePatchDataProtection",
  "csharp"
);
@@clientName(Microsoft.NetApp.QuotaType, "NetAppVolumeQuotaType", "csharp");
@@clientName(Microsoft.NetApp.VolumeRevert,
  "NetAppVolumeRevertContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.SecurityStyle,
  "NetAppVolumeSecurityStyle",
  "csharp"
);
@@clientName(Microsoft.NetApp.SnapshotRestoreFiles,
  "NetAppVolumeSnapshotRestoreFilesContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeStorageToNetworkProximity,
  "NetAppVolumeStorageToNetworkProximity",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupPatch,
  "NetAppBackupVaultBackupPatch",
  "csharp"
);
@@clientName(Microsoft.NetApp.UsageName, "NetAppUsageName", "csharp");
@@clientName(Microsoft.NetApp.UsageResult, "NetAppUsageResult", "csharp");
@@clientName(Microsoft.NetApp.VolumeRelocationProperties,
  "NetAppVolumeRelocationProperties",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupRestoreFiles,
  "NetAppVolumeBackupBackupRestoreFilesContent",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeGroupVolumeProperties,
  "NetAppVolumeGroupVolume",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeBackupProperties,
  "NetAppVolumeBackupConfiguration",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule,
  "NetAppVolumeExportPolicyRule",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.unixReadOnly,
  "IsUnixReadOnly",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.unixReadWrite,
  "IsUnixReadWrite",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.cifs,
  "AllowCifsProtocol",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.nfsv3,
  "AllowNfsV3Protocol",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.nfsv41,
  "AllowNfsV41Protocol",
  "csharp"
);

// C# boolean property renames (restore Is*/Has* prefix from old SDK)
@@clientName(Microsoft.NetApp.VolumeProperties.snapshotDirectoryVisible,
  "IsSnapshotDirectoryVisible",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.kerberosEnabled,
  "IsKerberosEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.smbEncryption,
  "IsSmbEncryptionEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.smbContinuouslyAvailable,
  "IsSmbContinuouslyAvailable",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.ldapEnabled,
  "IsLdapEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.coolAccess,
  "IsCoolAccessEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.encrypted,
  "IsEncrypted",
  "csharp"
);
@@clientName(Microsoft.NetApp.ActiveDirectory.aesEncryption,
  "IsAesEncryptionEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.ActiveDirectory.ldapSigning,
  "IsLdapSigningEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.ActiveDirectory.ldapOverTLS,
  "IsLdapOverTlsEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.PoolProperties.coolAccess,
  "IsCoolAccessEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.PoolPatchProperties.coolAccess,
  "IsCoolAccessEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeBackupProperties.policyEnforced,
  "IsPolicyEnforced",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupPolicyProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5ReadOnly,
  "IsKerberos5ReadOnly",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5ReadWrite,
  "IsKerberos5ReadWrite",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5iReadOnly,
  "IsKerberos5iReadOnly",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5iReadWrite,
  "IsKerberos5iReadWrite",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5pReadOnly,
  "IsKerberos5pReadOnly",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.kerberos5pReadWrite,
  "IsKerberos5pReadWrite",
  "csharp"
);
@@clientName(Microsoft.NetApp.ExportPolicyRule.hasRootAccess,
  "HasRootAccess",
  "csharp"
);
// BackupsMigrationRequest.backupVaultId: armResourceIdentifier → string (old API had string)
@@alternateType(Microsoft.NetApp.BackupsMigrationRequest.backupVaultId,
  string,
  "csharp"
);

// C# property renames for backward compat
@@clientName(Microsoft.NetApp.VolumeRelocationProperties.relocationRequested,
  "IsRelocationRequested",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeRelocationProperties.readyToBeFinalized,
  "IsReadyToBeFinalized",
  "csharp"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.accessedTimeStamp,
  "AccessedOn",
  "csharp"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.modifiedTimeStamp,
  "ModifiedOn",
  "csharp"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.changedTimeStamp,
  "ChangedOn",
  "csharp"
);
@@clientName(Microsoft.NetApp.SubvolumeModelProperties.creationTimeStamp,
  "CreatedOn",
  "csharp"
);
@@clientName(Microsoft.NetApp.SnapshotPolicyProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(Microsoft.NetApp.VolumeProperties.proximityPlacementGroup,
  "ProximityPlacementGroupId",
  "csharp"
);

// C# property type overrides for MountTargetProperties
@@alternateType(Microsoft.NetApp.MountTargetProperties.mountTargetId,
  uuid,
  "csharp"
);
@@alternateType(Microsoft.NetApp.MountTargetProperties.fileSystemId,
  uuid,
  "csharp"
);
@@alternateType(Microsoft.NetApp.MountTargetProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);

// C# property type overrides for VolumeProperties
@@alternateType(Microsoft.NetApp.VolumeProperties.fileSystemId, uuid, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.networkSiblingSetId,
  uuid,
  "csharp"
);

// C# ETag and Guid property type overrides
@@alternateType(Microsoft.NetApp.PoolProperties.poolId, uuid, "csharp");

// C# ARM resource renames (restore NetApp prefix on resource types)
// Note: Volume is handled via [CodeGenType] in Custom code because @@clientName
// on Volume causes generator crashes with [CodeGenSerialization] in Custom code.
@@clientName(Microsoft.NetApp.BackupPolicy, "NetAppBackupPolicy", "csharp");
@@clientName(Microsoft.NetApp.BackupVault, "NetAppBackupVault", "csharp");
@@clientName(Microsoft.NetApp.Backup, "NetAppBackupVaultBackup", "csharp");
@@clientName(Microsoft.NetApp.SubvolumeInfo, "NetAppSubvolumeInfo", "csharp");
@@clientName(Microsoft.NetApp.VolumeQuotaRule,
  "NetAppVolumeQuotaRule",
  "csharp"
);
@@clientName(Microsoft.NetApp.Snapshot, "NetAppVolumeSnapshot", "csharp");
@@clientName(Microsoft.NetApp.VolumeGroupDetails,
  "NetAppVolumeGroup",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupPolicyPatch,
  "NetAppBackupPolicyPatch",
  "csharp"
);
@@clientName(Microsoft.NetApp.BackupVaultPatch,
  "NetAppBackupVaultPatch",
  "csharp"
);
// SubvolumePatchParams rename removed — derived from SubvolumeInfo resource rename
@@clientName(Microsoft.NetApp.VolumeQuotaRulePatch,
  "NetAppVolumeQuotaRulePatch",
  "csharp"
);
@@clientName(Microsoft.NetApp.ChangeKeyVault, "NetAppChangeKeyVault", "csharp");

// Make types public for C# SDK backward compatibility
@@access(Microsoft.NetApp.VolumePropertiesExportPolicy,
  Access.public,
  "csharp"
);

// C# hierarchy building (restore base types for backward compat)
// First, align property types with TrackedResource expectations
// CapacityPoolPatch: restore TrackedResourceData base
@@alternateType(Microsoft.NetApp.CapacityPoolPatch.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.CapacityPoolPatch.location,
  azureLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(Microsoft.NetApp.CapacityPoolPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@alternateType(Microsoft.NetApp.CapacityPoolPatch.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.CapacityPoolPatch.location,
  azureLocation,
  "csharp"
);

// BackupPolicyPatch: restore TrackedResourceData base
@@alternateType(Microsoft.NetApp.BackupPolicyPatch.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.BackupPolicyPatch.location,
  azureLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(Microsoft.NetApp.BackupPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

@@alternateType(Microsoft.NetApp.NetAppAccountPatch.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.NetAppAccountPatch.location,
  azureLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(Microsoft.NetApp.NetAppAccountPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

@@alternateType(Microsoft.NetApp.SnapshotPolicyPatch.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.SnapshotPolicyPatch.location,
  azureLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(Microsoft.NetApp.SnapshotPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for backward compat"
@@hierarchyBuilding(Microsoft.NetApp.SubvolumeModel,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
@@access(Microsoft.NetApp.VolumeBackupRelationshipStatus,
  Access.public,
  "csharp"
);
@@access(Microsoft.NetApp.VolumeRestoreRelationshipStatus,
  Access.public,
  "csharp"
);

// C# property type overrides (backward compat with old autorest SDK types)
@@alternateType(Microsoft.NetApp.ReplicationObject.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeSnapshotProperties.snapshotPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.ActiveDirectory.kdcIP,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(Microsoft.NetApp.BackupPolicyProperties.backupPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.FilePathAvailabilityRequest.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.AuthorizeRequest.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.BackupRestoreFiles.destinationVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeProperties.keyVaultPrivateEndpointResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeProperties.originatingResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeProperties.proximityPlacementGroup,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeProperties.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeGroupVolumeProperties.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.PoolChangeRequest.newPoolResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.ReestablishReplicationRequest.sourceVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.Replication.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);

// C# property name renames
@@clientName(Microsoft.NetApp.KeyVaultProperties.keyVaultResourceId,
  "KeyVaultArmResourceId",
  "csharp"
);

// C# property name casing fixes
@@clientName(Microsoft.NetApp.AccountProperties.nfsV4IDDomain,
  "NfsV4IdDomain",
  "csharp"
);
@@clientName(Microsoft.NetApp.AccountPropertiesPatch.nfsV4IDDomain,
  "NfsV4IdDomain",
  "csharp"
);
@@clientName(Microsoft.NetApp.QuotaReport, "NetAppVolumeQuotaReport", "csharp");
@@clientName(Microsoft.NetApp.QuotaReportFilterRequest,
  "QuotaReportFilterContent",
  "csharp"
);

// TEMPORARY: reproduce DeserializeAzureLocation bug
@@alternateType(Microsoft.NetApp.VolumeGroup.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeGroup.location, azureLocation, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "test"
@@hierarchyBuilding(Microsoft.NetApp.VolumeGroup,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// --- Fix enum → extensible enum (NetAppProvisioningState) ---
// The spec defines NetAppProvisioningState as a union (extensible), but the old SDK had it
// as a closed enum. Replace with a closed enum for backward compat.
enum NetAppProvisioningStateEnum {
  Accepted: "Accepted",
  Creating: "Creating",
  Patching: "Patching",
  Updating: "Updating",
  Deleting: "Deleting",
  Moving: "Moving",
  Failed: "Failed",
  Succeeded: "Succeeded",
  Canceled: "Canceled",
  Provisioning: "Provisioning",
}
@@alternateType(Microsoft.NetApp.NetAppProvisioningState,
  NetAppProvisioningStateEnum,
  "csharp"
);
@@clientName(NetAppProvisioningStateEnum, "NetAppProvisioningState", "csharp");

// --- Fix property type mismatches via @@alternateType ---
// ETag: string → Azure.Core.eTag
@@alternateType(Microsoft.NetApp.CapacityPool.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.NetAppAccount.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.BackupPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.SnapshotPolicy.etag,
  Azure.Core.eTag,
  "csharp"
);

// Snapshot location: string → azureLocation
@@alternateType(Microsoft.NetApp.Snapshot.location, azureLocation, "csharp");

// VolumeRevert.snapshotId: armResourceIdentifier → string (old API had string)
@@clientName(Microsoft.NetApp.VolumeRevert.snapshotId, "SnapshotId", "csharp");
@@alternateType(Microsoft.NetApp.VolumeRevert.snapshotId, string, "csharp");

// VolumeProperties property type overrides for backward compat with old SDK
@@alternateType(Microsoft.NetApp.VolumeProperties.snapshotId, string, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.backupId, string, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.capacityPoolResourceId,
  armResourceIdentifier,
  "csharp"
);

// VolumeGroupDetails.location: string → azureLocation (old API had AzureLocation?)
@@alternateType(Microsoft.NetApp.VolumeGroupDetails.location,
  azureLocation,
  "csharp"
);
@@alternateType(Microsoft.NetApp.VolumeGroup.location, azureLocation, "csharp");

// --- Fix status model RelationshipStatus type to use unified NetAppRelationshipStatus ---
// Old SDK had RelationshipStatus as NetAppRelationshipStatus? on all three status models.
// Define replacement union matching old NetAppRelationshipStatus shape.
union NetAppRelationshipStatusDef {
  string,
  Idle: "Idle",
  Transferring: "Transferring",
  Failed: "Failed",
  Unknown: "Unknown",
}
@@clientName(NetAppRelationshipStatusDef, "NetAppRelationshipStatus", "csharp");
@@alternateType(Microsoft.NetApp.BackupStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
@@alternateType(Microsoft.NetApp.ReplicationStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
@@alternateType(Microsoft.NetApp.RestoreStatus.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);
// Also fix ReplicationObject.relationshipStatus
@@alternateType(Microsoft.NetApp.ReplicationObject.relationshipStatus,
  NetAppRelationshipStatusDef,
  "csharp"
);

// --- Fix missing setters via @@usage (Input | Output) ---
@@usage(Microsoft.NetApp.RegionInfoAvailabilityZoneMappingsItem,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.NetApp.ReplicationObject,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.NetApp.VolumeRevert, Usage.input | Usage.output, "csharp");
@@usage(Microsoft.NetApp.RansomwareReport,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.NetApp.RegionInfoResource,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(Microsoft.NetApp.Snapshot, Usage.input | Usage.output, "csharp");
