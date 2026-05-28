import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
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
@@clientName(CacheActiveDirectorySettings, "StorageCacheActiveDirectorySettings", "csharp");
@@clientName(CacheActiveDirectorySettingsCredentials, "StorageCacheActiveDirectorySettingsCredentials", "csharp");
@@clientName(CacheDirectorySettings, "StorageCacheDirectorySettings", "csharp");
@@clientName(CacheEncryptionSettings, "StorageCacheEncryptionSettings", "csharp");
@@clientName(CacheHealth, "StorageCacheHealth", "csharp");
@@clientName(CacheNetworkSettings, "StorageCacheNetworkSettings", "csharp");
@@clientName(CacheSecuritySettings, "StorageCacheSecuritySettings", "csharp");
@@clientName(CacheSku, "StorageCacheSkuInfo", "csharp");
@@clientName(CachesListResult, "StorageCachesResult", "csharp");
@@clientName(CacheUpgradeSettings, "StorageCacheUpgradeSettings", "csharp");
@@clientName(CacheUpgradeStatus, "StorageCacheUpgradeStatus", "csharp");
@@clientName(CacheUsernameDownloadSettings, "StorageCacheUsernameDownloadSettings", "csharp");
@@clientName(CacheUsernameDownloadSettingsCredentials, "StorageCacheUsernameDownloadCredential", "csharp");
@@clientName(Condition, "OutstandingCondition", "csharp");
@@clientName(FirmwareStatusType, "StorageCacheFirmwareStatusType", "csharp");
@@clientName(HealthStateType, "StorageCacheHealthStateType", "csharp");
@@clientName(KeyVaultKeyReference, "StorageCacheEncryptionKeyVaultKeyReference", "csharp");
@@clientName(OperationalStateType, "StorageTargetOperationalStateType", "csharp");
@@clientName(PrimingJobIdParameter, "PrimingJobContent", "csharp");
@@clientName(ProvisioningStateType, "StorageCacheProvisioningStateType", "csharp");
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
@@clientName(UsernameDownloadedType, "StorageCacheUsernameDownloadedType", "csharp");
@@clientName(ExpansionJobPropertiesProvisioningState, "ExpansionJobProvisioningState", "csharp");

@@clientName(CacheProperties.mountAddresses, "IPAddresses", "csharp");
@@clientName(CacheActiveDirectorySettings.primaryDnsIpAddress, "PrimaryDnsIPAddress", "csharp");
@@clientName(CacheActiveDirectorySettings.secondaryDnsIpAddress, "SecondaryDnsIPAddress", "csharp");
@@clientName(CacheNetworkSettings.utilityAddresses, "UtilityIPAddresses", "csharp");
@@clientName(CacheNetworkSettings.dnsServers, "DnsServersIPAddresses", "csharp");
@@clientName(CacheUpgradeSettings.upgradeScheduleEnabled, "EnableUpgradeSchedule", "csharp");
@@clientName(CacheUsernameDownloadSettings.extendedGroups, "EnableExtendedGroups", "csharp");
@@clientName(CacheActiveDirectorySettingsCredentials.bindDn, "BindDistinguishedName", "csharp");
@@clientName(CacheEncryptionSettings.rotationToLatestKeyVersionEnabled, "EnableRotationToLatestKeyVersion", "csharp");
@@clientName(NfsAccessRule.suid, "AllowSuid", "csharp");
@@clientName(NfsAccessRule.submountAccess, "AllowSubmountAccess", "csharp");
@@clientName(NfsAccessRule.rootSquash, "EnableRootSquash", "csharp");
@@clientName(NfsAccessRuleAccess.ro, "ReadOnly", "csharp");
@@clientName(NfsAccessRuleAccess.rw, "ReadWrite", "csharp");
@@clientName(Nfs3Target.verificationTimer, "VerificationDelayInSeconds", "csharp");
@@clientName(Nfs3Target.writeBackTimer, "WriteBackDelayInSeconds", "csharp");
@@clientName(BlobNfsTarget.verificationTimer, "VerificationDelayInSeconds", "csharp");
@@clientName(BlobNfsTarget.writeBackTimer, "WriteBackDelayInSeconds", "csharp");

@@clientName(Caches.spaceAllocation, "UpdateSpaceAllocation", "csharp");
@@clientName(Caches.debugInfo, "EnableDebugInfo", "csharp");
@@clientName(StorageTargets.dnsRefresh, "RefreshDns", "csharp");
@@clientName(SkusOperationGroup.list, "GetStorageCacheSkus", "csharp");
@@clientName(AscUsagesOperationGroup.list, "GetStorageCacheUsages", "csharp");
@@clientName(UsageModelsOperationGroup.list, "GetUsageModels", "csharp");
