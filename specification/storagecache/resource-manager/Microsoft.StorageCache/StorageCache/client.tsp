import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.StorageCache;

@@clientName(
  Microsoft.StorageCache,
  "StorageCacheManagementClient",
  "javascript,python"
);

@@clientName(CacheUsernameDownloadSettings.userFileURI, "userFileUri", "java");
@@clientName(
  CacheUsernameDownloadSettings.caCertificateURI,
  "caCertificateUri",
  "java"
);
@@clientName(
  CacheUsernameDownloadSettings.groupFileURI,
  "groupFileUri",
  "java"
);
@@clientName(AmlFilesystemRootSquashSettings.squashUID, "squashUid", "java");
@@clientName(AmlFilesystemRootSquashSettings.squashGID, "squashGid", "java");
@@clientName(
  AmlFilesystemPropertiesMaintenanceWindow.timeOfDayUTC,
  "timeOfDayUtc",
  "java"
);
@@clientName(
  AmlFilesystemUpdatePropertiesMaintenanceWindow.timeOfDayUTC,
  "timeOfDayUtc",
  "java"
);
@@clientName(
  AutoExportJobPropertiesStatus.lastStartedTimeUTC,
  "lastStartedTimeUtc",
  "java"
);
@@clientName(
  AutoExportJobPropertiesStatus.lastCompletionTimeUTC,
  "lastCompletionTimeUtc",
  "java"
);
@@clientName(
  AutoExportJobPropertiesStatus.lastSuccessfulIterationCompletionTimeUTC,
  "lastSuccessfulIterationCompletionTimeUtc",
  "java"
);
@@clientName(
  AutoImportJobPropertiesStatus.lastStartedTimeUTC,
  "lastStartedTimeUtc",
  "java"
);
@@clientName(
  AutoImportJobPropertiesStatus.lastCompletionTimeUTC,
  "lastCompletionTimeUtc",
  "java"
);
@@clientName(NfsAccessRule.anonymousUID, "anonymousUid", "java");
@@clientName(NfsAccessRule.anonymousGID, "anonymousGid", "java");
@@clientName(
  getRequiredAmlFSSubnetsSize::parameters.body,
  "requiredAmlFilesystemSubnetsSizeInfo",
  "java"
);

// C# management-plane compatibility names from the previous AutoRest configuration.
@@clientName(Cache, "StorageCache", "csharp");
@@clientName(
  CacheActiveDirectorySettings,
  "StorageCacheActiveDirectorySettings",
  "csharp"
);
@@clientName(
  CacheActiveDirectorySettingsCredentials,
  "StorageCacheActiveDirectorySettingsCredentials",
  "csharp"
);
@@clientName(CacheDirectorySettings, "StorageCacheDirectorySettings", "csharp");
@@clientName(
  CacheEncryptionSettings,
  "StorageCacheEncryptionSettings",
  "csharp"
);
@@clientName(CacheHealth, "StorageCacheHealth", "csharp");
@@clientName(CacheNetworkSettings, "StorageCacheNetworkSettings", "csharp");
@@clientName(CacheSecuritySettings, "StorageCacheSecuritySettings", "csharp");
@@clientName(CacheSku, "StorageCacheSkuInfo", "csharp");
@@clientName(CachesListResult, "StorageCachesResult", "csharp");
@@clientName(CacheUpgradeSettings, "StorageCacheUpgradeSettings", "csharp");
@@clientName(CacheUpgradeStatus, "StorageCacheUpgradeStatus", "csharp");
@@clientName(
  CacheUsernameDownloadSettings,
  "StorageCacheUsernameDownloadSettings",
  "csharp"
);
@@clientName(
  CacheUsernameDownloadSettingsCredentials,
  "StorageCacheUsernameDownloadCredential",
  "csharp"
);
@@clientName(AscOperation, "StorageCacheAscOperationInfo", "csharp");
@@clientName(
  AscOperationErrorResponse,
  "StorageCacheAscOperationError",
  "csharp"
);
@@clientName(AmlFilesystem, "AmlFileSystem", "csharp");
@@clientName(AmlFilesystemsListResult, "AmlFileSystemsResult", "csharp");
@@clientName(
  AmlFilesystemEncryptionSettings,
  "AmlFileSystemEncryptionSettings",
  "csharp"
);
@@clientName(AmlFilesystemHealth, "AmlFileSystemHealth", "csharp");
@@clientName(
  AmlFilesystemHealthStateType,
  "AmlFileSystemHealthStateType",
  "csharp"
);
@@clientName(AmlFilesystemIdentity, "AmlFileSystemIdentity", "csharp");
@@clientName(AmlFilesystemClientInfo, "AmlFileSystemClientInfo", "csharp");
@@clientName(
  AmlFilesystemContainerStorageInterface,
  "AmlFileSystemContainerStorageInterface",
  "csharp"
);
@@clientName(
  AmlFilesystemPropertiesHsm,
  "AmlFileSystemPropertiesHsm",
  "csharp"
);
@@clientName(
  AmlFilesystemPropertiesMaintenanceWindow,
  "AmlFileSystemPropertiesMaintenanceWindow",
  "csharp"
);
@@clientName(
  AmlFilesystemProvisioningStateType,
  "AmlFileSystemProvisioningStateType",
  "csharp"
);
@@clientName(
  AmlFilesystemRootSquashSettings,
  "AmlFileSystemRootSquashSettings",
  "csharp"
);
@@clientName(AmlFilesystemSquashMode, "AmlFileSystemSquashMode", "csharp");
@@clientName(AmlFilesystemUpdate, "AmlFileSystemPatch", "csharp");
@@clientName(
  AmlFilesystemUpdatePropertiesMaintenanceWindow,
  "AmlFileSystemUpdatePropertiesMaintenanceWindow",
  "csharp"
);
@@clientName(AmlFilesystemHsmSettings, "AmlFileSystemHsmSettings", "csharp");
@@clientName(AmlFilesystemArchive, "AmlFileSystemArchive", "csharp");
@@clientName(AmlFilesystemArchiveInfo, "AmlFileSystemArchiveContent", "csharp");
@@clientName(
  AmlFilesystemArchiveStatus,
  "AmlFileSystemArchiveStatus",
  "csharp"
);
@@clientName(
  AmlFilesystemCheckSubnetError,
  "AmlFileSystemCheckSubnetError",
  "csharp"
);
@@clientName(
  AmlFilesystemCheckSubnetErrorFilesystemSubnet,
  "AmlFileSystemCheckSubnetErrorFilesystemSubnet",
  "csharp"
);
@@clientName(AmlFilesystemSubnetInfo, "AmlFileSystemSubnetContent", "csharp");
@@clientName(
  RequiredAmlFilesystemSubnetsSize,
  "RequiredAmlFileSystemSubnetsSize",
  "csharp"
);
@@clientName(
  RequiredAmlFilesystemSubnetsSizeInfo,
  "RequiredAmlFileSystemSubnetsSizeContent",
  "csharp"
);
@@clientName(Condition, "OutstandingCondition", "csharp");
@@clientName(FirmwareStatusType, "StorageCacheFirmwareStatusType", "csharp");
@@clientName(HealthStateType, "StorageCacheHealthStateType", "csharp");
@@clientName(ImportJob, "StorageCacheImportJob", "csharp");
@@clientName(ImportJobUpdate, "StorageCacheImportJobPatch", "csharp");
@@clientName(ImportJobsListResult, "StorageCacheImportJobsResult", "csharp");
@@clientName(ExpansionJob, "AmlFileSystemExpansionJob", "csharp");
@@clientName(ExpansionJobUpdate, "AmlFileSystemExpansionJobPatch", "csharp");
@@clientName(
  KeyVaultKeyReference,
  "StorageCacheEncryptionKeyVaultKeyReference",
  "csharp"
);
@@clientName(
  OperationalStateType,
  "StorageTargetOperationalStateType",
  "csharp"
);
@@clientName(PrimingJobIdParameter, "PrimingJobContent", "csharp");
@@clientName(
  ProvisioningStateType,
  "StorageCacheProvisioningStateType",
  "csharp"
);
@@clientName(ReasonCode, "StorageCacheRestrictionReasonCode", "csharp");
@@clientName(Restriction, "StorageCacheRestriction", "csharp");
@@clientName(ResourceSku, "StorageCacheSku", "csharp");
@@clientName(ResourceSkuCapabilities, "StorageCacheSkuCapability", "csharp");
@@clientName(ResourceSkuLocationInfo, "StorageCacheSkuLocationInfo", "csharp");
@@clientName(ResourceSkusResult, "StorageCacheSkusResult", "csharp");
@@clientName(ResourceUsage, "StorageCacheUsage", "csharp");
@@clientName(ResourceUsageName, "StorageCacheUsageName", "csharp");
@@clientName(ResourceUsagesListResult, "StorageCacheUsagesResult", "csharp");
@@clientName(UsageModel, "StorageCacheUsageModel", "csharp");
@@clientName(UsageModelDisplay, "StorageCacheUsageModelDisplay", "csharp");
@@clientName(UsageModelsResult, "StorageCacheUsageModelsResult", "csharp");
@@clientName(UsernameSource, "StorageCacheUsernameSourceType", "csharp");
@@clientName(UsernameSource.LDAP, "Ldap", "csharp");
@@clientName(
  UsernameDownloadedType,
  "StorageCacheUsernameDownloadedType",
  "csharp"
);
@@clientName(
  ExpansionJobPropertiesProvisioningState,
  "AmlFileSystemExpansionJobProvisioningState",
  "csharp"
);
@@clientName(
  ExpansionJobStatusType,
  "AmlFileSystemExpansionJobStatusType",
  "csharp"
);

@@clientName(ExpansionJobPropertiesStatus.startTimeUTC, "StartedOn", "csharp");
@@clientName(
  ExpansionJobPropertiesStatus.completionTimeUTC,
  "CompletedOn",
  "csharp"
);
@@clientName(CacheProperties.mountAddresses, "MountAddresses", "csharp");
@@clientName(
  CacheActiveDirectorySettings.primaryDnsIpAddress,
  "PrimaryDnsIPAddress",
  "csharp"
);
@@clientName(
  CacheActiveDirectorySettings.secondaryDnsIpAddress,
  "SecondaryDnsIPAddress",
  "csharp"
);
@@clientName(
  CacheNetworkSettings.utilityAddresses,
  "UtilityAddresses",
  "csharp"
);
@@clientName(CacheNetworkSettings.dnsServers, "DnsServers", "csharp");
@@clientName(
  CacheUsernameDownloadSettings.groupFileURI,
  "GroupFileUri",
  "csharp"
);
@@clientName(
  CacheUsernameDownloadSettings.userFileURI,
  "UserFileUri",
  "csharp"
);
@@clientName(
  CacheUsernameDownloadSettings.caCertificateURI,
  "CaCertificateUri",
  "csharp"
);
@@clientName(
  CacheUpgradeSettings.upgradeScheduleEnabled,
  "EnableUpgradeSchedule",
  "csharp"
);
@@clientName(
  CacheUsernameDownloadSettings.extendedGroups,
  "EnableExtendedGroups",
  "csharp"
);
@@clientName(
  CacheUsernameDownloadSettingsCredentials.bindDn,
  "BindDistinguishedName",
  "csharp"
);
@@clientName(
  CacheEncryptionSettings.rotationToLatestKeyVersionEnabled,
  "EnableRotationToLatestKeyVersion",
  "csharp"
);
@@clientName(Restriction.type, "RestrictionType", "csharp");
@@clientName(NfsAccessRule.suid, "AllowSuid", "csharp");
@@clientName(NfsAccessRule.submountAccess, "AllowSubmountAccess", "csharp");
@@clientName(NfsAccessRule.rootSquash, "EnableRootSquash", "csharp");
@@clientName(NfsAccessRuleAccess.ro, "ReadOnly", "csharp");
@@clientName(NfsAccessRuleAccess.rw, "ReadWrite", "csharp");
@@clientName(
  Nfs3Target.verificationTimer,
  "VerificationDelayInSeconds",
  "csharp"
);
@@clientName(Nfs3Target.writeBackTimer, "WriteBackDelayInSeconds", "csharp");
@@clientName(
  BlobNfsTarget.verificationTimer,
  "VerificationDelayInSeconds",
  "csharp"
);
@@clientName(BlobNfsTarget.writeBackTimer, "WriteBackDelayInSeconds", "csharp");

@@alternateType(CacheProperties.mountAddresses, ipV4Address[], "csharp");
@@alternateType(CacheProperties.subnet, armResourceIdentifier, "csharp");
@@alternateType(
  CacheActiveDirectorySettings.primaryDnsIpAddress,
  ipV4Address,
  "csharp"
);
@@alternateType(
  CacheActiveDirectorySettings.secondaryDnsIpAddress,
  ipV4Address,
  "csharp"
);
@@alternateType(CacheNetworkSettings.utilityAddresses, ipV4Address, "csharp");
@@alternateType(CacheNetworkSettings.dnsServers, ipV4Address, "csharp");
@@alternateType(CacheUsernameDownloadSettings.groupFileURI, url, "csharp");
@@alternateType(CacheUsernameDownloadSettings.userFileURI, url, "csharp");
@@alternateType(CacheUsernameDownloadSettings.caCertificateURI, url, "csharp");
@@alternateType(AmlFilesystemProperties.clusterUuid, uuid, "csharp");
@@alternateType(
  KeyVaultKeyReferenceSourceVault.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BlobNfsTarget.target, armResourceIdentifier, "csharp");
@@alternateType(ClfsTarget.target, armResourceIdentifier, "csharp");
@@alternateType(
  AscUsagesOperationGroup.list::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  AmlFilesystem.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  Cache.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(StorageTarget.location, Azure.Core.azureLocation, "csharp");

@@visibility(CacheProperties.primingJobs, Lifecycle.Read);
@@visibility(AutoExportJobProperties.status, Lifecycle.Read, Lifecycle.Create);

@@clientName(Caches.spaceAllocation, "UpdateSpaceAllocation", "csharp");
@@clientName(Caches.debugInfo, "EnableDebugInfo", "csharp");
@@clientName(StorageTargets.dnsRefresh, "RefreshDns", "csharp");
@@clientName(checkAmlFSSubnets, "CheckAmlFSSubnets", "csharp");
@@clientName(
  getRequiredAmlFSSubnetsSize,
  "GetRequiredAmlFSSubnetsSize",
  "csharp"
);
@@clientName(SkusOperationGroup.list, "GetStorageCacheSkus", "csharp");
@@clientName(
  AscOperationsOperationGroup.get,
  "GetStorageCacheAscOperation",
  "csharp"
);
@@clientName(AscUsagesOperationGroup.list, "GetStorageCacheUsages", "csharp");
@@clientName(UsageModelsOperationGroup.list, "GetUsageModels", "csharp");
