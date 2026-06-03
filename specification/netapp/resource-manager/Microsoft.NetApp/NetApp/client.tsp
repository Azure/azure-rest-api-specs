import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.NetApp;

@@clientName(
  Microsoft.NetApp,
  "NetAppManagementClient",
  "java,python,javascript"
);

// Snapshot is not updatable
@@scope(Microsoft.NetApp.Snapshots.update, "!java");

// rename QuotaItem to SubscriptionQuotaItem, avoid break in SDK
@@clientName(QuotaItem, "SubscriptionQuotaItem", "java");

// Fix property name case changes
@@clientName(
  Microsoft.NetApp.AccountProperties.nfsV4IDDomain,
  "nfsV4IdDomain",
  "java"
);

@@clientName(Microsoft.NetApp.ActiveDirectory.kdcIP, "kdcIp", "java");
@@clientName(
  Microsoft.NetApp.ActiveDirectory.ldapOverTLS,
  "ldapOverTls",
  "java"
);
@@clientName(
  Microsoft.NetApp.RemotePath.externalHostName,
  "externalHostname",
  "java"
);
@@clientName(
  Microsoft.NetApp.SubvolumeModelProperties.accessedTimeStamp,
  "accessedTimestamp",
  "java"
);
@@clientName(
  Microsoft.NetApp.SubvolumeModelProperties.modifiedTimeStamp,
  "modifiedTimestamp",
  "java"
);
@@clientName(
  Microsoft.NetApp.SubvolumeModelProperties.changedTimeStamp,
  "changedTimestamp",
  "java"
);
@@clientName(
  Microsoft.NetApp.SubvolumeModelProperties.creationTimeStamp,
  "creationTimestamp",
  "java"
);
@@clientName(
  Microsoft.NetApp.VolumeGroupListProperties.groupMetaData,
  "groupMetadata",
  "java"
);
@@clientName(
  Microsoft.NetApp.VolumeGroupProperties.groupMetaData,
  "groupMetadata",
  "java"
);
@@clientName(
  Microsoft.NetApp.NetAppProvisioningState,
  "ProvisioningState",
  "java"
);

// Fix model name changes
@@clientName(
  Microsoft.NetApp.VolumeGroupMetaData,
  "VolumeGroupMetadata",
  "java"
);

@@clientName(
  Microsoft.NetApp.GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLDAPUserRequest",
  "go,python"
);

@@clientName(
  Microsoft.NetApp.GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLDAPUserResponse",
  "go,python"
);

@@clientName(
  Microsoft.NetApp.NetAppProvisioningState,
  "NetappProvisioningState",
  "go"
);

@@clientName(
  Microsoft.NetApp.ReplicationSchedule._10minutely,
  "$DO_NOT_NORMALIZE$\"10Minutely\"",
  "javascript"
);

@@clientName(QuotaItem, "SubscriptionQuotaItem", "go");
@@clientName(QuotaItemList, "SubscriptionQuotaItemList", "go");
@@clientName(QuotaItemProperties, "SubscriptionQuotaItemProperties", "go");

// =============================================================================
// C# customizations (csharp scope)
// =============================================================================

// --- @@clientName: model and property renames for C# ---
@@clientName(
  CachePropertiesExportPolicy,
  "NetAppCachePropertiesExportPolicy",
  "csharp"
);

// C# model renames to match existing SDK API surface
@@clientLocation(
  SubscriptionQuotaItems.get,
  "NetAppSubscriptionQuotaItems",
  "csharp"
);
@@clientLocation(
  SubscriptionQuotaItems.list,
  "NetAppSubscriptionQuotaItems",
  "csharp"
);
@@clientName(QosType, "CapacityPoolQosType", "csharp");
@@clientName(ActiveDirectory, "NetAppAccountActiveDirectory", "csharp");
@@clientName(AccountEncryption, "NetAppAccountEncryption", "csharp");
@@clientName(Replication, "NetAppVolumeReplication", "csharp");
@@clientName(CacheProperties, "NetAppCacheProperties", "csharp");
@@clientName(
  CacheMountTargetProperties,
  "NetAppCacheMountTargetProperties",
  "csharp"
);
@@clientName(PeeringPassphrases, "NetAppPeeringPassphrases", "csharp");
@@clientName(SmbSettings, "NetAppSmbSettings", "csharp");
@@clientName(
  OriginClusterInformation,
  "NetAppOriginClusterInformation",
  "csharp"
);
@@clientName(DailySchedule, "SnapshotPolicyDailySchedule", "csharp");
@@clientName(HourlySchedule, "SnapshotPolicyHourlySchedule", "csharp");
@@clientName(MonthlySchedule, "SnapshotPolicyMonthlySchedule", "csharp");
@@clientName(WeeklySchedule, "SnapshotPolicyWeeklySchedule", "csharp");
@@clientName(CacheLifeCycleState, "NetAppCacheLifeCycleState", "csharp");
@@clientName(CacheProvisioningState, "NetAppCacheProvisioningState", "csharp");
@@clientName(CifsChangeNotifyState, "NetAppCifsChangeNotifyState", "csharp");
@@clientName(EnableWriteBackState, "NetAppEnableWriteBackState", "csharp");
@@clientName(EncryptionState, "NetAppEncryptionState", "csharp");
@@clientName(
  ExternalReplicationSetupStatus,
  "NetAppExternalReplicationSetupStatus",
  "csharp"
);
@@clientName(GlobalFileLockingState, "NetAppGlobalFileLockingState", "csharp");
@@clientName(KerberosState, "NetAppKerberosState", "csharp");
@@clientName(LdapState, "NetAppLdapState", "csharp");
@@clientName(LdapServerType, "NetAppLdapServerType", "csharp");
@@clientName(ProtocolTypes, "NetAppProtocolType", "csharp");
@@clientName(SmbEncryptionState, "NetAppSmbEncryptionState", "csharp");
@@clientName(VolumeLanguage, "NetAppVolumeLanguage", "csharp");
@@clientName(
  ActiveDirectoryStatus,
  "NetAppAccountActiveDirectoryStatus",
  "csharp"
);
@@clientName(
  LdapSearchScopeOpt,
  "NetAppLdapSearchScopeConfiguration",
  "csharp"
);
@@clientName(ReplicationSchedule, "NetAppReplicationSchedule", "csharp");

// C# AZC0030/AZC0032 naming compliance: Request→Content, Response→Result
@@clientName(
  AuthorizeRequest,
  "NetAppVolumeAuthorizeReplicationContent",
  "csharp"
);
@@clientName(BackupsMigrationRequest, "BackupsMigrationContent", "csharp");
@@clientName(
  BreakFileLocksRequest,
  "NetAppVolumeBreakFileLocksContent",
  "csharp"
);
@@clientName(BreakFileLocksRequest.clientIp, "ClientIP", "csharp");
@@alternateType(
  BreakFileLocksRequest.clientIp,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(
  BreakReplicationRequest,
  "NetAppVolumeBreakReplicationContent",
  "csharp"
);
@@clientName(ChangeZoneRequest, "ChangeZoneContent", "csharp");
@@clientName(
  CheckAvailabilityResponse,
  "NetAppCheckAvailabilityResult",
  "csharp"
);
@@clientName(
  CheckElasticVolumeFilePathAvailabilityRequest,
  "CheckElasticVolumeFilePathAvailabilityContent",
  "csharp"
);
@@clientName(ClusterPeerCommandResponse, "ClusterPeerCommandResult", "csharp");
@@clientName(
  EncryptionTransitionRequest,
  "NetAppEncryptionTransitionContent",
  "csharp"
);
@@clientName(
  FilePathAvailabilityRequest,
  "NetAppFilePathAvailabilityContent",
  "csharp"
);
@@clientName(
  GetGroupIdListForLdapUserRequest,
  "GetGroupIdListForLdapUserContent",
  "csharp"
);
@@clientName(
  GetGroupIdListForLdapUserResponse,
  "GetGroupIdListForLdapUserResult",
  "csharp"
);
@@clientName(GetKeyVaultStatusResponse, "NetAppKeyVaultStatusResult", "csharp");
@@clientName(
  ListQuotaReportResponse,
  "NetAppVolumeQuotaReportListResult",
  "csharp"
);
@@clientName(ListReplicationsRequest, "ListReplicationsContent", "csharp");
@@clientName(
  PeerClusterForVolumeMigrationRequest,
  "PeerClusterForVolumeMigrationContent",
  "csharp"
);
@@clientName(PoolChangeRequest, "NetAppVolumePoolChangeContent", "csharp");
@@clientName(
  QueryNetworkSiblingSetRequest,
  "QueryNetworkSiblingSetContent",
  "csharp"
);
@@clientName(
  QuotaAvailabilityRequest,
  "NetAppQuotaAvailabilityContent",
  "csharp"
);
@@clientName(
  RansomwareSuspectsClearRequest,
  "RansomwareSuspectsClearContent",
  "csharp"
);
@@clientName(
  ReestablishReplicationRequest,
  "NetAppVolumeReestablishReplicationContent",
  "csharp"
);
@@clientName(RelocateVolumeRequest, "RelocateVolumeContent", "csharp");
@@clientName(
  ResourceNameAvailabilityRequest,
  "NetAppNameAvailabilityContent",
  "csharp"
);
@@clientName(SvmPeerCommandResponse, "SvmPeerCommandResult", "csharp");
@@clientName(
  UpdateNetworkSiblingSetRequest,
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
@@clientName(
  KeyVaultPrivateEndpoint,
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
@@clientName(
  CheckNameResourceTypes,
  "NetAppNameAvailabilityResourceType",
  "csharp"
);
@@clientName(InAvailabilityReasonType, "NetAppNameUnavailableReason", "csharp");
@@clientName(NetworkFeatures, "NetAppNetworkFeature", "csharp");
@@clientName(
  CheckQuotaNameResourceTypes,
  "NetAppQuotaAvailabilityResourceType",
  "csharp"
);
@@clientName(SubvolumeModel, "NetAppSubvolumeMetadata", "csharp");
@@clientName(VolumeBackups, "NetAppVolumeBackupDetail", "csharp");
@@clientName(
  VolumePropertiesDataProtection,
  "NetAppVolumeDataProtection",
  "csharp"
);
@@clientName(VolumeGroup, "NetAppVolumeGroupResult", "csharp");
@@clientName(MountTargetProperties, "NetAppVolumeMountTarget", "csharp");
@@clientName(
  VolumePatchPropertiesDataProtection,
  "NetAppVolumePatchDataProtection",
  "csharp"
);
@@clientName(QuotaType, "NetAppVolumeQuotaType", "csharp");
@@clientName(VolumeRevert, "NetAppVolumeRevertContent", "csharp");
@@clientName(SecurityStyle, "NetAppVolumeSecurityStyle", "csharp");
@@clientName(
  SnapshotRestoreFiles,
  "NetAppVolumeSnapshotRestoreFilesContent",
  "csharp"
);
@@clientName(
  VolumeStorageToNetworkProximity,
  "NetAppVolumeStorageToNetworkProximity",
  "csharp"
);
@@clientName(BackupPatch, "NetAppBackupVaultBackupPatch", "csharp");
@@clientName(UsageName, "NetAppUsageName", "csharp");
@@clientName(UsageResult, "NetAppUsageResult", "csharp");
@@clientName(PolicyStatus, "ElasticSnapshotPolicyStatus", "csharp");
@@clientName(SecretPassword, "NetAppSecretPassword", "csharp");
@@clientName(SecretPasswordIdentity, "NetAppSecretPasswordIdentity", "csharp");
@@clientName(SnapshotUsage, "ElasticBackupSnapshotUsage", "csharp");
@@clientName(VolumeSize, "ElasticBackupVolumeSize", "csharp");
@@clientName(
  VolumeRelocationProperties,
  "NetAppVolumeRelocationProperties",
  "csharp"
);
@@clientName(
  BackupRestoreFiles,
  "NetAppVolumeBackupBackupRestoreFilesContent",
  "csharp"
);
@@clientName(VolumeGroupVolumeProperties, "NetAppVolumeGroupVolume", "csharp");
@@clientName(VolumeGroupVolumeProperties.type, "ResourceType", "csharp");
@@clientName(
  VolumeBackupProperties,
  "NetAppVolumeBackupConfiguration",
  "csharp"
);
@@clientName(
  SecretPasswordKeyVaultProperties,
  "NetAppSecretPasswordKeyVaultPatchProperties",
  "csharp"
);
@@clientName(FileSystemUser, "NetAppFileSystemUser", "csharp");
@@clientName(NfsUser, "NetAppNfsUser", "csharp");
@@clientName(BucketServerProperties, "NetAppBucketServerProperties", "csharp");
@@clientName(
  BucketServerPatchProperties,
  "NetAppBucketServerPatchProperties",
  "csharp"
);
@@clientName(BucketPermissions, "NetAppBucketPermission", "csharp");
@@clientName(BucketPatchPermissions, "NetAppBucketPatchPermission", "csharp");
@@clientName(
  OnCertificateConflictAction,
  "NetAppOnCertificateConflictAction",
  "csharp"
);
@@clientName(
  BucketCredentialsExpiry,
  "NetAppBucketCredentialsExpiry",
  "csharp"
);
@@clientName(
  BucketGenerateCredentials,
  "NetAppBucketGenerateCredentials",
  "csharp"
);
@@clientName(
  BucketGenerateCredentials.keyPairExpiry,
  "KeyPairExpiresOn",
  "csharp"
);
@@clientName(AzureKeyVaultDetails, "NetAppKeyVaultDetails", "csharp");
@@clientName(BucketProperties.akvDetails, "KeyVaultDetails", "csharp");
@@clientName(BucketPatchProperties.akvDetails, "KeyVaultDetails", "csharp");
@@clientName(CertificateAkvDetails, "CertificateKeyVaultDetails", "csharp");
@@clientName(CredentialsAkvDetails, "CredentialsKeyVaultDetails", "csharp");
@@clientName(
  AzureKeyVaultDetails.certificateAkvDetails,
  "CertificateKeyVaultDetails",
  "csharp"
);
@@clientName(
  AzureKeyVaultDetails.credentialsAkvDetails,
  "CredentialsKeyVaultDetails",
  "csharp"
);
@@clientName(CredentialsStatus, "NetAppCredentialsStatus", "csharp");
@@clientName(
  Buckets.generateAkvCredentials,
  "GenerateKeyVaultCredentials",
  "csharp"
);
@@clientName(ExportPolicyRule, "NetAppVolumeExportPolicyRule", "csharp");
@@clientName(ExportPolicyRule.unixReadOnly, "IsUnixReadOnly", "csharp");
@@clientName(ExportPolicyRule.unixReadWrite, "IsUnixReadWrite", "csharp");
@@clientName(ExportPolicyRule.cifs, "AllowCifsProtocol", "csharp");
@@clientName(ExportPolicyRule.nfsv3, "AllowNfsV3Protocol", "csharp");
@@clientName(ExportPolicyRule.nfsv41, "AllowNfsV41Protocol", "csharp");

// C# boolean property renames (restore Is*/Has* prefix from old SDK)
@@clientName(
  VolumeProperties.snapshotDirectoryVisible,
  "IsSnapshotDirectoryVisible",
  "csharp"
);
@@clientName(VolumeProperties.kerberosEnabled, "IsKerberosEnabled", "csharp");
@@clientName(
  VolumeProperties.smbEncryption,
  "IsSmbEncryptionEnabled",
  "csharp"
);
@@clientName(
  VolumeProperties.smbContinuouslyAvailable,
  "IsSmbContinuouslyAvailable",
  "csharp"
);
@@clientName(VolumeProperties.ldapEnabled, "IsLdapEnabled", "csharp");
@@clientName(VolumeProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(VolumePatchProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(
  VolumePatchProperties.snapshotDirectoryVisible,
  "IsSnapshotDirectoryVisible",
  "csharp"
);
@@clientName(VolumeProperties.encrypted, "IsEncrypted", "csharp");
@@clientName(ActiveDirectory.aesEncryption, "IsAesEncryptionEnabled", "csharp");
@@clientName(ActiveDirectory.ldapSigning, "IsLdapSigningEnabled", "csharp");
@@clientName(ActiveDirectory.ldapOverTLS, "IsLdapOverTlsEnabled", "csharp");
@@clientName(LdapConfiguration.ldapOverTLS, "IsLdapOverTlsEnabled", "csharp");
@@clientName(
  LdapConfigurationPatch.ldapOverTLS,
  "IsLdapOverTlsEnabled",
  "csharp"
);
@@clientName(PoolProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(PoolPatchProperties.coolAccess, "IsCoolAccessEnabled", "csharp");
@@clientName(
  VolumeBackupProperties.policyEnforced,
  "IsPolicyEnforced",
  "csharp"
);
@@clientName(BackupPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(VolumeBackups.policyEnabled, "IsPolicyEnabled", "csharp");
@@clientName(RestoreStatus.healthy, "IsHealthy", "csharp");
@@clientName(BackupStatus.healthy, "IsHealthy", "csharp");
@@clientName(ReplicationStatus.healthy, "IsHealthy", "csharp");
@@clientName(ResourceNameAvailabilityRequest.type, "ResourceType", "csharp");
@@clientName(
  QuotaAvailabilityRequest.type,
  "AvailabilityResourceType",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5ReadOnly,
  "IsKerberos5ReadOnly",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5ReadWrite,
  "IsKerberos5ReadWrite",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5iReadOnly,
  "IsKerberos5iReadOnly",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5iReadWrite,
  "IsKerberos5iReadWrite",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5pReadOnly,
  "IsKerberos5pReadOnly",
  "csharp"
);
@@clientName(
  ExportPolicyRule.kerberos5pReadWrite,
  "IsKerberos5pReadWrite",
  "csharp"
);
@@clientName(ExportPolicyRule.hasRootAccess, "HasRootAccess", "csharp");

// C# property renames for backward compat
@@clientName(
  VolumeRelocationProperties.relocationRequested,
  "IsRelocationRequested",
  "csharp"
);
@@clientName(
  VolumeRelocationProperties.readyToBeFinalized,
  "IsReadyToBeFinalized",
  "csharp"
);
@@clientName(
  SubvolumeModelProperties.accessedTimeStamp,
  "AccessedOn",
  "csharp"
);
@@clientName(
  SubvolumeModelProperties.modifiedTimeStamp,
  "ModifiedOn",
  "csharp"
);
@@clientName(SubvolumeModelProperties.changedTimeStamp, "ChangedOn", "csharp");
@@clientName(SubvolumeModelProperties.creationTimeStamp, "CreatedOn", "csharp");
@@clientName(SnapshotPolicyProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  VolumeProperties.proximityPlacementGroup,
  "ProximityPlacementGroupId",
  "csharp"
);

// C# ARM resource renames (restore NetApp prefix on resource types)
@@clientName(Volume, "NetAppVolume", "csharp");
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
@@clientName(
  KeyVaultProperties.keyVaultResourceId,
  "KeyVaultArmResourceId",
  "csharp"
);

// C# property name casing fixes
@@clientName(AccountProperties.nfsV4IDDomain, "NfsV4IdDomain", "csharp");
@@clientName(QuotaReport, "NetAppVolumeQuotaReport", "csharp");
@@clientName(QuotaReportFilterRequest, "QuotaReportFilterContent", "csharp");

// C# enum-member casing fixes (formerly exposed with these spellings)
@@clientName(ApplicationType.`SAP-HANA`, "SapHana", "csharp");
@@clientName(ApplicationType.ORACLE, "Oracle", "csharp");
@@clientName(EndpointType.src, "Source", "csharp");
@@clientName(EndpointType.dst, "Destination", "csharp");
@@clientName(ServiceLevel.StandardZRS, "StandardZrs", "csharp");
@@clientName(ProtocolTypes.NFSv3, "Nfsv3", "csharp");
@@clientName(ProtocolTypes.NFSv4, "Nfsv4", "csharp");
@@clientName(ProtocolTypes.SMB, "Smb", "csharp");
@@clientName(LdapServerType.OpenLDAP, "OpenLdap", "csharp");
@@clientName(VolumeLanguage.utf8mb4, "Utf8Mb4", "csharp");
@@clientName(ElasticProtocolType.NFSv3, "Nfsv3", "csharp");
@@clientName(ElasticProtocolType.NFSv4, "Nfsv4", "csharp");

// Body parameter rename to restore previous property name
@@clientName(
  ListReplicationsRequest.exclude,
  "ExcludeReplicationsFilter",
  "csharp"
);

// VolumeRevert.snapshotId: armResourceIdentifier → string (old API had string)
@@clientName(VolumeRevert.snapshotId, "SnapshotId", "csharp");
@@clientName(
  VolumePropertiesExportPolicy,
  "NetAppVolumeExportPolicy",
  "csharp"
);

// --- @@alternateType: property type overrides for C# ---
// BackupsMigrationRequest.backupVaultId: accept ResourceIdentifier and rename;
// the old string BackupVaultId API is preserved by SDK customization.
@@clientName(
  BackupsMigrationRequest.backupVaultId,
  "BackupVaultResourceId",
  "csharp"
);

// Restore previous operation names that include the NetApp resource subject (csharp).
@@clientName(NetAppAccounts.listByNetAppAccount, "GetVolumeGroups", "csharp");
@@clientName(
  NetAppResourceOperationGroup.checkNameAvailability,
  "CheckNetAppNameAvailability",
  "csharp"
);
@@clientName(
  NetAppResourceOperationGroup.checkFilePathAvailability,
  "CheckNetAppFilePathAvailability",
  "csharp"
);
@@clientName(
  NetAppResourceOperationGroup.checkQuotaAvailability,
  "CheckNetAppQuotaAvailability",
  "csharp"
);
@@clientName(
  NetAppResourceOperationGroup.queryRegionInfo,
  "QueryRegionInfoNetAppResource",
  "csharp"
);
@@clientName(
  NetAppResourceOperationGroup.queryNetworkSiblingSet,
  "QueryNetworkSiblingSetNetAppResource",
  "csharp"
);
@@clientName(
  NetAppResourceOperationGroup.updateNetworkSiblingSet,
  "UpdateNetworkSiblingSetNetAppResource",
  "csharp"
);
@@clientName(
  NetAppResourceUsagesOperationGroup.list,
  "GetNetAppResourceUsages",
  "csharp"
);
@@clientName(
  NetAppResourceUsagesOperationGroup.get,
  "GetNetAppResourceUsage",
  "csharp"
);

// C# property type overrides for MountTargetProperties
@@alternateType(MountTargetProperties.mountTargetId, uuid, "csharp");
@@alternateType(MountTargetProperties.fileSystemId, uuid, "csharp");
@@alternateType(
  MountTargetProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(CacheMountTargetProperties.ipAddress, string, "csharp");
@@clientName(MountTargetProperties.ipAddress, "IPAddress", "csharp");
@@clientName(CacheMountTargetProperties.ipAddress, "IPAddress", "csharp");
@@clientName(NicInfo.ipAddress, "IPAddress", "csharp");
@@clientName(BucketServerProperties.ipAddress, "IPAddress", "csharp");
@@clientName(
  PeerClusterForVolumeMigrationRequest.peerIpAddresses,
  "PeerIPAddresses",
  "csharp"
);

// C# property type overrides for VolumeProperties
@@alternateType(VolumeProperties.fileSystemId, uuid, "csharp");
@@alternateType(VolumeProperties.networkSiblingSetId, uuid, "csharp");
// dataStoreResourceId: string[] -> ResourceIdentifier[] (old SDK exposed Azure.Core.ResourceIdentifier)
@@alternateType(
  VolumeProperties.dataStoreResourceId,
  armResourceIdentifier[],
  "csharp"
);

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
@@alternateType(
  ReplicationObject.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(
  BackupProperties.backupPolicyResourceId,
  "BackupPolicyArmResourceId",
  "csharp"
);
@@alternateType(
  VolumeSnapshotProperties.snapshotPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ActiveDirectory.kdcIP, Azure.Core.ipV4Address, "csharp");
@@alternateType(
  BackupPolicyProperties.backupPolicyId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  FilePathAvailabilityRequest.subnetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AuthorizeRequest.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  BackupRestoreFiles.destinationVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VolumeProperties.keyVaultPrivateEndpointResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VolumeProperties.originatingResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VolumeProperties.proximityPlacementGroup,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VolumeProperties.subnetId, armResourceIdentifier, "csharp");
@@alternateType(
  VolumeGroupVolumeProperties.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VolumeGroupVolumeProperties.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  PoolChangeRequest.newPoolResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReestablishReplicationRequest.sourceVolumeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Replication.remoteVolumeResourceId,
  armResourceIdentifier,
  "csharp"
);

// TEMPORARY: reproduce DeserializeAzureLocation bug
@@alternateType(VolumeGroup.id, armResourceIdentifier, "csharp");
@@alternateType(VolumeGroup.location, azureLocation, "csharp");
@@clientName(
  VolumeQuotaRulesProperties.provisioningState,
  "VolumeQuotaRuleProvisioningState",
  "csharp"
);

// --- Fix property type mismatches via @@alternateType ---
// ETag: string → Azure.Core.eTag
@@alternateType(CapacityPool.etag, Azure.Core.eTag, "csharp");
@@alternateType(NetAppAccount.etag, Azure.Core.eTag, "csharp");
@@alternateType(BackupPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(SnapshotPolicy.etag, Azure.Core.eTag, "csharp");
@@alternateType(Volume.etag, Azure.Core.eTag, "csharp");
@@alternateType(Cache.etag, Azure.Core.eTag, "csharp");
@@alternateType(ActiveDirectoryConfig.etag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticAccount.eTag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticBackupPolicy.eTag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticBackupVault.eTag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticCapacityPool.eTag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticSnapshotPolicy.eTag, Azure.Core.eTag, "csharp");
@@alternateType(ElasticVolume.eTag, Azure.Core.eTag, "csharp");

// Capacity pool throughput: generate the original int?-typed property name and keep
// the GA float?-typed CustomThroughputMibps as a compatibility alias in SDK custom code.
@@clientName(
  PoolProperties.customThroughputMibps,
  "CustomThroughputMibpsInt",
  "csharp"
);

// Snapshot location: string → azureLocation
@@alternateType(Snapshot.location, azureLocation, "csharp");
@@alternateType(VolumeRevert.snapshotId, string, "csharp");

// VolumeProperties property type overrides for backward compat with old SDK
@@alternateType(VolumeProperties.snapshotId, string, "csharp");
@@alternateType(VolumeProperties.backupId, string, "csharp");
@@alternateType(
  VolumeProperties.capacityPoolResourceId,
  armResourceIdentifier,
  "csharp"
);

// VolumeGroupDetails.location: string → azureLocation (old API had AzureLocation?)
@@alternateType(VolumeGroupDetails.location, azureLocation, "csharp");
@@alternateType(VolumeGroup.location, azureLocation, "csharp");
@@clientName(
  BackupStatus.relationshipStatus,
  "VolumeBackupRelationshipStatus",
  "csharp"
);
@@clientName(
  ReplicationStatus.relationshipStatus,
  "VolumeReplicationRelationshipStatus",
  "csharp"
);
@@clientName(
  RestoreStatus.relationshipStatus,
  "VolumeRestoreRelationshipStatus",
  "csharp"
);
// Also fix ReplicationObject.relationshipStatus
@@alternateType(
  ReplicationObject.relationshipStatus,
  VolumeReplicationRelationshipStatus,
  "csharp"
);

// --- @@hierarchyBuilding: restore base types for backward compat ---
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  CapacityPoolPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  BackupPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  SnapshotPolicyPatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore TrackedResourceData base type for backward compat"
@@hierarchyBuilding(
  VolumePatch,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for backward compat"
@@hierarchyBuilding(
  SubvolumeModel,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "test"
@@hierarchyBuilding(
  VolumeGroup,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// --- @@usage: add Usage.input to make output-only models also serializable as input (decorator appends) ---
@@usage(BackupsMigrationRequest, Usage.input, "csharp");
@@usage(RegionInfoAvailabilityZoneMappingsItem, Usage.input, "csharp");
@@usage(ReplicationObject, Usage.input, "csharp");
@@usage(VolumeRevert, Usage.input, "csharp");
@@usage(RansomwareReport, Usage.input, "csharp");
@@usage(RegionInfoResource, Usage.input, "csharp");
@@usage(Snapshot, Usage.input, "csharp");
@@usage(QuotaItem, Usage.input, "csharp");
@@usage(VolumeBackupRelationshipStatus, Usage.input, "csharp");
@@usage(VolumeReplicationRelationshipStatus, Usage.input, "csharp");
@@usage(VolumeRestoreRelationshipStatus, Usage.input, "csharp");
