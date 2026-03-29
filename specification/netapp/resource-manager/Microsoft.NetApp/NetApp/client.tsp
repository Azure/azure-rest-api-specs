import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
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

// ============================================================
// C# backward compatibility: type renames
// ============================================================
// Resource types - add NetApp prefix to match old SDK names
@@clientName(Microsoft.NetApp.Volume, "NetAppVolume", "csharp");
@@clientName(Microsoft.NetApp.Backup, "NetAppBackupVaultBackup", "csharp");
@@clientName(Microsoft.NetApp.BackupPolicy, "NetAppBackupPolicy", "csharp");
@@clientName(Microsoft.NetApp.BackupVault, "NetAppBackupVault", "csharp");
@@clientName(Microsoft.NetApp.QuotaItem, "NetAppSubscriptionQuotaItem", "csharp");
@@clientName(Microsoft.NetApp.SubvolumeInfo, "NetAppSubvolumeInfo", "csharp");
@@clientName(Microsoft.NetApp.VolumeGroupDetails, "NetAppVolumeGroup", "csharp");
@@clientName(Microsoft.NetApp.VolumeQuotaRule, "NetAppVolumeQuotaRule", "csharp");
@@clientName(Microsoft.NetApp.Snapshot, "NetAppVolumeSnapshot", "csharp");
@@clientName(Microsoft.NetApp.CapacityPool, "CapacityPool", "csharp");
@@clientName(Microsoft.NetApp.SnapshotPolicy, "SnapshotPolicy", "csharp");
@@clientName(Microsoft.NetApp.NetAppAccount, "NetAppAccount", "csharp");

// Model types - preserve old SDK names
@@clientName(Microsoft.NetApp.AccountEncryption, "NetAppAccountEncryption", "csharp");
@@clientName(Microsoft.NetApp.ActiveDirectory, "NetAppAccountActiveDirectory", "csharp");
@@clientName(Microsoft.NetApp.ActiveDirectoryStatus, "NetAppAccountActiveDirectoryStatus", "csharp");
@@clientName(Microsoft.NetApp.AuthorizeRequest, "NetAppVolumeAuthorizeReplicationContent", "csharp");
@@clientName(Microsoft.NetApp.AvsDataStore, "NetAppAvsDataStore", "csharp");
@@clientName(Microsoft.NetApp.BackupPatch, "NetAppBackupVaultBackupPatch", "csharp");
@@clientName(Microsoft.NetApp.BackupPolicyPatch, "NetAppBackupPolicyPatch", "csharp");
@@clientName(Microsoft.NetApp.BackupRestoreFiles, "NetAppVolumeBackupBackupRestoreFilesContent", "csharp");
@@clientName(Microsoft.NetApp.BackupVaultPatch, "NetAppBackupVaultPatch", "csharp");
@@clientName(Microsoft.NetApp.BackupsMigrationRequest, "BackupsMigrationContent", "csharp");
@@clientName(Microsoft.NetApp.BreakFileLocksRequest, "NetAppVolumeBreakFileLocksContent", "csharp");
@@clientName(Microsoft.NetApp.BreakReplicationRequest, "NetAppVolumeBreakReplicationContent", "csharp");
@@clientName(Microsoft.NetApp.ChangeKeyVault, "NetAppChangeKeyVault", "csharp");
@@clientName(Microsoft.NetApp.CheckAvailabilityResponse, "NetAppCheckAvailabilityResult", "csharp");
@@clientName(Microsoft.NetApp.CheckNameResourceTypes, "NetAppNameAvailabilityResourceType", "csharp");
@@clientName(Microsoft.NetApp.CheckQuotaNameResourceTypes, "NetAppQuotaAvailabilityResourceType", "csharp");
@@clientName(Microsoft.NetApp.ChownMode, "NetAppChownMode", "csharp");
@@clientName(Microsoft.NetApp.ClusterPeerCommandResponse, "ClusterPeerCommandResult", "csharp");
@@clientName(Microsoft.NetApp.DailySchedule, "SnapshotPolicyDailySchedule", "csharp");
@@clientName(Microsoft.NetApp.DestinationReplication, "NetAppDestinationReplication", "csharp");
@@clientName(Microsoft.NetApp.EnableSubvolumes, "EnableNetAppSubvolume", "csharp");
@@clientName(Microsoft.NetApp.EncryptionIdentity, "NetAppEncryptionIdentity", "csharp");
@@clientName(Microsoft.NetApp.EncryptionKeySource, "NetAppEncryptionKeySource", "csharp");
@@clientName(Microsoft.NetApp.EncryptionTransitionRequest, "NetAppEncryptionTransitionContent", "csharp");
@@clientName(Microsoft.NetApp.FileAccessLogs, "NetAppFileAccessLog", "csharp");
@@clientName(Microsoft.NetApp.FilePathAvailabilityRequest, "NetAppFilePathAvailabilityContent", "csharp");
@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserRequest, "GetGroupIdListForLdapUserContent", "csharp");
@@clientName(Microsoft.NetApp.GetGroupIdListForLdapUserResponse, "GetGroupIdListForLdapUserResult", "csharp");
@@clientName(Microsoft.NetApp.GetKeyVaultStatusResponse, "NetAppKeyVaultStatusResult", "csharp");
@@clientName(Microsoft.NetApp.HourlySchedule, "SnapshotPolicyHourlySchedule", "csharp");
@@clientName(Microsoft.NetApp.InAvailabilityReasonType, "NetAppNameUnavailableReason", "csharp");
@@clientName(Microsoft.NetApp.KeySource, "NetAppKeySource", "csharp");
@@clientName(Microsoft.NetApp.KeyVaultPrivateEndpoint, "NetAppKeyVaultPrivateEndpoint", "csharp");
@@clientName(Microsoft.NetApp.KeyVaultProperties, "NetAppKeyVaultProperties", "csharp");
@@clientName(Microsoft.NetApp.LdapSearchScopeOpt, "NetAppLdapSearchScopeConfiguration", "csharp");
@@clientName(Microsoft.NetApp.ListReplicationsRequest, "ListReplicationsContent", "csharp");
@@clientName(Microsoft.NetApp.MonthlySchedule, "SnapshotPolicyMonthlySchedule", "csharp");
@@clientName(Microsoft.NetApp.MountTargetProperties, "NetAppVolumeMountTarget", "csharp");
@@clientName(Microsoft.NetApp.NetworkFeatures, "NetAppNetworkFeature", "csharp");
@@clientName(Microsoft.NetApp.PeerClusterForVolumeMigrationRequest, "PeerClusterForVolumeMigrationContent", "csharp");
@@clientName(Microsoft.NetApp.PoolChangeRequest, "NetAppVolumePoolChangeContent", "csharp");
@@clientName(Microsoft.NetApp.QosType, "CapacityPoolQosType", "csharp");
@@clientName(Microsoft.NetApp.QueryNetworkSiblingSetRequest, "QueryNetworkSiblingSetContent", "csharp");
@@clientName(Microsoft.NetApp.QuotaAvailabilityRequest, "NetAppQuotaAvailabilityContent", "csharp");
@@clientName(Microsoft.NetApp.QuotaReportFilterRequest, "QuotaReportFilterContent", "csharp");
@@clientName(Microsoft.NetApp.QuotaType, "NetAppVolumeQuotaType", "csharp");
@@clientName(Microsoft.NetApp.RansomwareSuspectsClearRequest, "RansomwareSuspectsClearContent", "csharp");
@@clientName(Microsoft.NetApp.ReestablishReplicationRequest, "NetAppVolumeReestablishReplicationContent", "csharp");
@@clientName(Microsoft.NetApp.RegionInfo, "NetAppRegionInfo", "csharp");
@@clientName(Microsoft.NetApp.RelocateVolumeRequest, "RelocateVolumeContent", "csharp");
@@clientName(Microsoft.NetApp.Replication, "NetAppVolumeReplication", "csharp");
@@clientName(Microsoft.NetApp.ReplicationObject, "NetAppReplicationObject", "csharp");
@@clientName(Microsoft.NetApp.ReplicationSchedule, "NetAppReplicationSchedule", "csharp");
@@clientName(Microsoft.NetApp.ReplicationType, "NetAppReplicationType", "csharp");
@@clientName(Microsoft.NetApp.ResourceNameAvailabilityRequest, "NetAppNameAvailabilityContent", "csharp");
@@clientName(Microsoft.NetApp.SecurityStyle, "NetAppVolumeSecurityStyle", "csharp");
@@clientName(Microsoft.NetApp.SnapshotRestoreFiles, "NetAppVolumeSnapshotRestoreFilesContent", "csharp");
@@clientName(Microsoft.NetApp.SubvolumeModel, "NetAppSubvolumeMetadata", "csharp");
@@clientName(Microsoft.NetApp.SubvolumePatchRequest, "NetAppSubvolumeInfoPatch", "csharp");
@@clientName(Microsoft.NetApp.SvmPeerCommandResponse, "SvmPeerCommandResult", "csharp");
@@clientName(Microsoft.NetApp.UpdateNetworkSiblingSetRequest, "UpdateNetworkSiblingSetContent", "csharp");
@@clientName(Microsoft.NetApp.UsageName, "NetAppUsageName", "csharp");
@@clientName(Microsoft.NetApp.UsageResult, "NetAppUsageResult", "csharp");
@@clientName(Microsoft.NetApp.VolumeBackupProperties, "NetAppVolumeBackupConfiguration", "csharp");
@@clientName(Microsoft.NetApp.VolumeGroup, "NetAppVolumeGroupResult", "csharp");
@@clientName(Microsoft.NetApp.VolumeGroupVolumeProperties, "NetAppVolumeGroupVolume", "csharp");
@@clientName(Microsoft.NetApp.VolumePatch, "NetAppVolumePatch", "csharp");
@@clientName(Microsoft.NetApp.VolumePatchPropertiesDataProtection, "NetAppVolumePatchDataProtection", "csharp");
@@clientName(Microsoft.NetApp.VolumePropertiesDataProtection, "NetAppVolumeDataProtection", "csharp");
@@clientName(Microsoft.NetApp.VolumeQuotaRulePatch, "NetAppVolumeQuotaRulePatch", "csharp");
@@clientName(Microsoft.NetApp.VolumeRelocationProperties, "NetAppVolumeRelocationProperties", "csharp");
@@clientName(Microsoft.NetApp.VolumeRevert, "NetAppVolumeRevertContent", "csharp");
@@clientName(Microsoft.NetApp.VolumeStorageToNetworkProximity, "NetAppVolumeStorageToNetworkProximity", "csharp");
@@clientName(Microsoft.NetApp.WeeklySchedule, "SnapshotPolicyWeeklySchedule", "csharp");
@@clientName(Microsoft.NetApp.ReplicationStatus, "NetAppVolumeReplicationStatus", "csharp");
@@clientName(Microsoft.NetApp.VolumeBackups, "NetAppVolumeBackupDetail", "csharp");
@@clientName(Microsoft.NetApp.QuotaReport, "NetAppVolumeQuotaReport", "csharp");
@@clientName(Microsoft.NetApp.Exclude, "ExcludeReplicationsFilter", "csharp");

// ============================================================
// C# backward compatibility: @@alternateType for ResourceIdentifier
// ============================================================
// VolumeProperties
@@alternateType(Microsoft.NetApp.VolumeProperties.subnetId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.keyVaultPrivateEndpointResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.proximityPlacementGroup, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.originatingResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.capacityPoolResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(Microsoft.NetApp.VolumeProperties.dataStoreResourceId, Azure.Core.armResourceIdentifier[], "csharp");

// ReplicationObject
@@alternateType(Microsoft.NetApp.ReplicationObject.remoteVolumeResourceId, Azure.Core.armResourceIdentifier, "csharp");

// VolumeSnapshotProperties
@@alternateType(Microsoft.NetApp.VolumeSnapshotProperties.snapshotPolicyId, Azure.Core.armResourceIdentifier, "csharp");

// Replication
@@alternateType(Microsoft.NetApp.Replication.remoteVolumeResourceId, Azure.Core.armResourceIdentifier, "csharp");

// AuthorizeRequest
@@alternateType(Microsoft.NetApp.AuthorizeRequest.remoteVolumeResourceId, Azure.Core.armResourceIdentifier, "csharp");

// ReestablishReplicationRequest
@@alternateType(Microsoft.NetApp.ReestablishReplicationRequest.sourceVolumeId, Azure.Core.armResourceIdentifier, "csharp");

// PoolChangeRequest
@@alternateType(Microsoft.NetApp.PoolChangeRequest.newPoolResourceId, Azure.Core.armResourceIdentifier, "csharp");

// FilePathAvailabilityRequest
@@alternateType(Microsoft.NetApp.FilePathAvailabilityRequest.subnetId, Azure.Core.armResourceIdentifier, "csharp");

// BackupPolicyProperties
@@alternateType(Microsoft.NetApp.BackupPolicyProperties.backupPolicyId, Azure.Core.armResourceIdentifier, "csharp");

// VolumeGroupVolumeProperties
@@alternateType(Microsoft.NetApp.VolumeGroupVolumeProperties.id, Azure.Core.armResourceIdentifier, "csharp");

// VolumeBackups
@@alternateType(Microsoft.NetApp.VolumeBackups.volumeResourceId, Azure.Core.armResourceIdentifier, "csharp");

// ============================================================
// C# backward compatibility: @@alternateType for ETag
// ============================================================
@@alternateType(Microsoft.NetApp.CapacityPool.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.NetAppAccount.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.BackupPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.Volume.etag, Azure.Core.eTag, "csharp");
@@alternateType(Microsoft.NetApp.SnapshotPolicy.etag, Azure.Core.eTag, "csharp");

// ============================================================
// C# backward compatibility: @@alternateType for AzureLocation
// ============================================================
@@alternateType(Microsoft.NetApp.VolumeGroupDetails.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.VolumeGroup.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.Snapshot.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.NetAppAccountPatch.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.BackupPolicyPatch.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.SnapshotPolicyPatch.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Microsoft.NetApp.CapacityPoolPatch.location, Azure.Core.azureLocation, "csharp");

// ============================================================
// C# backward compatibility: @@hierarchyBuilding for base types
// ============================================================
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve TrackedResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.NetAppAccountPatch, Azure.ResourceManager.CommonTypes.TrackedResource, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve TrackedResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.BackupPolicyPatch, Azure.ResourceManager.CommonTypes.TrackedResource, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve TrackedResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.SnapshotPolicyPatch, Azure.ResourceManager.CommonTypes.TrackedResource, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve TrackedResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.CapacityPoolPatch, Azure.ResourceManager.CommonTypes.TrackedResource, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve ResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.SubvolumeModel, Azure.ResourceManager.CommonTypes.Resource, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "C# backward compat: preserve ResourceData base"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Microsoft.NetApp.VolumeGroup, Azure.ResourceManager.CommonTypes.Resource, "csharp");
