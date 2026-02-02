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

// C# model renames - prepend-rp-prefix equivalents
@@clientName(Backup, "NetAppBackup", "csharp");
@@clientName(BackupPolicy, "NetAppBackupPolicy", "csharp");
@@clientName(BackupVault, "NetAppBackupVault", "csharp");
@@clientName(EndpointType, "NetAppEndpointType", "csharp");
@@clientName(Volume, "NetAppVolume", "csharp");
@@clientName(VolumeQuotaRule, "NetAppVolumeQuotaRule", "csharp");
@@clientName(RestoreStatus, "NetAppRestoreStatus", "csharp");
@@clientName(ApplicationType, "NetAppApplicationType", "csharp");
@@clientName(AvsDataStore, "NetAppAvsDataStore", "csharp");
@@clientName(ChownMode, "NetAppChownMode", "csharp");
@@clientName(EncryptionKeySource, "NetAppEncryptionKeySource", "csharp");
@@clientName(MirrorState, "NetAppMirrorState", "csharp");
@@clientName(VolumeReplicationRelationshipStatus, "NetAppRelationshipStatus", "csharp");
@@clientName(NetAppProvisioningState, "NetAppProvisioningState", "csharp");
@@clientName(ReplicationObject, "NetAppReplicationObject", "csharp");
@@clientName(ReplicationSchedule, "NetAppReplicationSchedule", "csharp");
@@clientName(VolumeStorageToNetworkProximity, "NetAppVolumeStorageToNetworkProximity", "csharp");
@@clientName(AccountEncryption, "NetAppAccountEncryption", "csharp");
@@clientName(KeySource, "NetAppKeySource", "csharp");
@@clientName(KeyVaultProperties, "NetAppKeyVaultProperties", "csharp");
@@clientName(KeyVaultStatus, "NetAppKeyVaultStatus", "csharp");
@@clientName(RegionInfo, "NetAppRegionInfo", "csharp");
@@clientName(EncryptionIdentity, "NetAppEncryptionIdentity", "csharp");
@@clientName(ChangeKeyVault, "NetAppChangeKeyVault", "csharp");
@@clientName(DestinationReplication, "NetAppDestinationReplication", "csharp");
@@clientName(EncryptionTransitionRequest, "NetAppEncryptionTransitionRequest", "csharp");
@@clientName(KeyVaultPrivateEndpoint, "NetAppKeyVaultPrivateEndpoint", "csharp");
@@clientName(ReplicationType, "NetAppReplicationType", "csharp");
@@clientName(VolumeLanguage, "NetAppVolumeLanguage", "csharp");

// C# model renames - rename-mapping equivalents
@@clientName(ReplicationSchedule._10minutely, "TenMinutely", "csharp");
@@clientName(EndpointType.src, "Source", "csharp");
@@clientName(EndpointType.dst, "Destination", "csharp");
@@clientName(ExportPolicyRule.cifs, "AllowCifsProtocol", "csharp");
@@clientName(ExportPolicyRule.unixReadOnly, "IsUnixReadOnly", "csharp");
@@clientName(ExportPolicyRule.unixReadWrite, "IsUnixReadWrite", "csharp");
@@clientName(ExportPolicyRule.kerberos5ReadOnly, "IsKerberos5ReadOnly", "csharp");
@@clientName(ExportPolicyRule.kerberos5ReadWrite, "IsKerberos5ReadWrite", "csharp");
@@clientName(ExportPolicyRule.kerberos5iReadOnly, "IsKerberos5iReadOnly", "csharp");
@@clientName(ExportPolicyRule.kerberos5iReadWrite, "IsKerberos5iReadWrite", "csharp");
@@clientName(ExportPolicyRule.kerberos5pReadOnly, "IsKerberos5pReadOnly", "csharp");
@@clientName(ExportPolicyRule.kerberos5pReadWrite, "IsKerberos5pReadWrite", "csharp");
@@clientName(ExportPolicyRule.nfsv3, "AllowNfsV3Protocol", "csharp");
@@clientName(ExportPolicyRule.nfsv41, "AllowNfsV41Protocol", "csharp");
@@clientName(VolumeProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(VolumeProperties.snapshotDirectoryVisible, "IsSnapshotDirectoryVisible", "csharp");
@@clientName(VolumeProperties.kerberosEnabled, "IsKerberosEnabled", "csharp");
@@clientName(VolumeProperties.smbEncryption, "IsSmbEncryptionEnabled", "csharp");
@@clientName(VolumeProperties.smbContinuouslyAvailable, "IsSmbContinuouslyAvailable", "csharp");
@@clientName(VolumeProperties.ldapEnabled, "IsLdapEnabled", "csharp");
@@clientName(VolumeProperties.encrypted, "IsEncrypted", "csharp");
@@clientName(VolumePatchProperties.snapshotDirectoryVisible, "IsSnapshotDirectoryVisible", "csharp");
@@clientName(VolumePatchProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(SnapshotPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(ActiveDirectory.aesEncryption, "IsAesEncryptionEnabled", "csharp");
@@clientName(ActiveDirectory.ldapSigning, "IsLdapSigningEnabled", "csharp");
@@clientName(ActiveDirectory.ldapOverTLS, "IsLdapOverTlsEnabled", "csharp");
@@clientName(BackupPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(ReplicationStatus.healthy, "IsHealthy", "csharp");
@@clientName(PoolProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(VolumeBackups.policyEnabled, "IsPolicyEnabled", "csharp");
@@clientName(SubvolumeModelProperties.creationTimeStamp, "CreatedOn", "csharp");
@@clientName(SubvolumeModelProperties.accessedTimeStamp, "AccessedOn", "csharp");
@@clientName(SubvolumeModelProperties.modifiedTimeStamp, "ModifiedOn", "csharp");
@@clientName(SubvolumeModelProperties.changedTimeStamp, "ChangedOn", "csharp");
@@clientName(VolumeBackupProperties.policyEnforced, "IsPolicyEnforced", "csharp");
@@clientName(BackupStatus.healthy, "IsHealthy", "csharp");
@@clientName(VolumeRelocationProperties.readyToBeFinalized, "IsReadyToBeFinalized", "csharp");
@@clientName(VolumeRelocationProperties.relocationRequested, "IsRelocationRequested", "csharp");

// C# model renames - type renames
@@clientName(VolumeGroupDetails, "NetAppVolumeGroup", "csharp");
@@clientName(QosType, "CapacityPoolQosType", "csharp");
@@clientName(ServiceLevel, "NetAppFileServiceLevel", "csharp");
@@clientName(ActiveDirectory, "NetAppAccountActiveDirectory", "csharp");
@@clientName(ActiveDirectoryStatus, "NetAppAccountActiveDirectoryStatus", "csharp");
@@clientName(VolumeBackups, "NetAppVolumeBackupDetail", "csharp");
@@clientName(CheckAvailabilityResponse, "NetAppCheckAvailabilityResult", "csharp");
@@clientName(FilePathAvailabilityRequest, "NetAppFilePathAvailabilityContent", "csharp");
@@clientName(ResourceNameAvailabilityRequest, "NetAppNameAvailabilityContent", "csharp");
@@clientName(CheckNameResourceTypes, "NetAppNameAvailabilityResourceType", "csharp");
@@clientName(CheckQuotaNameResourceTypes, "NetAppQuotaAvailabilityResourceType", "csharp");
@@clientName(QuotaAvailabilityRequest, "NetAppQuotaAvailabilityContent", "csharp");
@@clientName(InAvailabilityReasonType, "NetAppNameUnavailableReason", "csharp");
@@clientName(Snapshot, "NetAppVolumeSnapshot", "csharp");
@@clientName(QuotaItem, "NetAppSubscriptionQuotaItem", "csharp");
@@clientName(SubvolumeInfo, "NetAppSubvolumeInfo", "csharp");
@@clientName(Replication, "NetAppVolumeReplication", "csharp");
@@clientName(BackupStatus, "NetAppVolumeBackupStatus", "csharp");
@@clientName(AuthorizeRequest, "NetAppVolumeAuthorizeReplicationContent", "csharp");
@@clientName(BreakReplicationRequest, "NetAppVolumeBreakReplicationContent", "csharp");
@@clientName(DailySchedule, "SnapshotPolicyDailySchedule", "csharp");
@@clientName(EnableSubvolumes, "EnableNetAppSubvolume", "csharp");
@@clientName(EncryptionType, "CapacityPoolEncryptionType", "csharp");
@@clientName(ExportPolicyRule, "NetAppVolumeExportPolicyRule", "csharp");
@@clientName(HourlySchedule, "SnapshotPolicyHourlySchedule", "csharp");
@@clientName(MonthlySchedule, "SnapshotPolicyMonthlySchedule", "csharp");
@@clientName(WeeklySchedule, "SnapshotPolicyWeeklySchedule", "csharp");
@@clientName(LdapSearchScopeOpt, "NetAppLdapSearchScopeConfiguration", "csharp");
@@clientName(MountTargetProperties, "NetAppVolumeMountTarget", "csharp");
@@clientName(NetworkFeatures, "NetAppNetworkFeature", "csharp");
@@clientName(PlacementKeyValuePairs, "NetAppVolumePlacementRule", "csharp");
@@clientName(PoolChangeRequest, "NetAppVolumePoolChangeContent", "csharp");
@@clientName(ReestablishReplicationRequest, "NetAppVolumeReestablishReplicationContent", "csharp");
@@clientName(ReplicationStatus, "NetAppVolumeReplicationStatus", "csharp");
@@clientName(SecurityStyle, "NetAppVolumeSecurityStyle", "csharp");
@@clientName(SnapshotRestoreFiles, "NetAppVolumeSnapshotRestoreFilesContent", "csharp");
@@clientName(SubvolumeModel, "NetAppSubvolumeMetadata", "csharp");
@@clientName(Type, "NetAppVolumeQuotaType", "csharp");
@@clientName(VolumePatchPropertiesDataProtection, "NetAppVolumePatchDataProtection", "csharp");
@@clientName(VolumePropertiesDataProtection, "NetAppVolumeDataProtection", "csharp");
@@clientName(VolumeRevert, "NetAppVolumeRevertContent", "csharp");
@@clientName(VolumeBackupProperties, "NetAppVolumeBackupConfiguration", "csharp");
@@clientName(VolumeGroupMetaData, "NetAppVolumeGroupMetadata", "csharp");
@@clientName(VolumeGroup, "NetAppVolumeGroupResult", "csharp");
@@clientName(BreakFileLocksRequest, "NetAppVolumeBreakFileLocksContent", "csharp");
@@clientName(BackupRestoreFiles, "NetAppVolumeBackupBackupRestoreFilesContent", "csharp");
@@clientName(VolumeRelocationProperties, "NetAppVolumeRelocationProperties", "csharp");
@@clientName(FileAccessLogs, "NetAppFileAccessLog", "csharp");
@@clientName(GetGroupIdListForLdapUserResponse, "GetGroupIdListForLdapUserResult", "csharp");
@@clientName(BackupsMigrationRequest, "BackupsMigrationContent", "csharp");
@@clientName(ClusterPeerCommandResponse, "ClusterPeerCommandResult", "csharp");
@@clientName(SvmPeerCommandResponse, "SvmPeerCommandResult", "csharp");
@@clientName(ListQuotaReportResponse, "NetAppVolumeQuotaReportListResult", "csharp");
@@clientName(QuotaReport, "NetAppVolumeQuotaReport", "csharp");
@@clientName(GetKeyVaultStatusResponse, "NetAppKeyVaultStatusResult", "csharp");
@@clientName(UsageResult, "NetAppUsageResult", "csharp");
@@clientName(UsageName, "NetAppUsageName", "csharp");
@@clientName(NfsUser, "NetAppBucketNfsUser", "csharp");
@@clientName(FileSystemUser, "NetAppBucketFileSystemUser", "csharp");
@@clientName(CredentialsStatus, "NetAppBucketCredentialStatus", "csharp");
@@clientName(PoolProperties.customThroughputMibps, "CustomThroughputMibpsInt", "csharp");
@@clientName(RestoreStatus.relationshipStatus, "VolumeRestoreRelationshipStatus", "csharp");
@@clientName(BackupStatus.relationshipStatus, "VolumeBackupRelationshipStatus", "csharp");
@@clientName(ListReplicationsRequest.exclude, "ExcludeReplicationsFilter", "csharp");
@@clientName(Exclude, "ExcludeReplicationsFilter", "csharp");
@@clientName(CheckElasticResourceAvailabilityResponse, "CheckElasticResourceAvailabilityResult", "csharp");
