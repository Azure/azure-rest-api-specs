import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.NetApp;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(UsageResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(NetAppAccountPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(GetKeyVaultStatusResponse.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(CapacityPoolPatch.properties);

@@clientName(ExportPolicyRule.kerberos5iReadOnly, "kerberos5IReadOnly");
@@clientName(ExportPolicyRule.kerberos5iReadWrite, "kerberos5IReadWrite");
@@clientName(ExportPolicyRule.kerberos5pReadOnly, "kerberos5PReadOnly");
@@clientName(ExportPolicyRule.kerberos5pReadWrite, "kerberos5PReadWrite");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SnapshotPolicyPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(BackupPolicyPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumeQuotaRulePatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumeGroup.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumeGroupVolumeProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SubvolumePatchRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SubvolumeModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(BackupPatch.properties);

@@clientLocation(SubscriptionQuotaItems.get, "NetAppResourceQuotaLimits");
@@clientLocation(SubscriptionQuotaItems.list, "NetAppResourceQuotaLimits");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(QuotaItem.properties);

@@clientLocation(RegionInfoResources.get, "NetAppResourceRegionInfos");
@@clientLocation(RegionInfoResources.list, "NetAppResourceRegionInfos");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RegionInfoResource.properties);

@@clientLocation(NetAppAccounts.get, "Accounts");
@@clientLocation(NetAppAccounts.createOrUpdate, "Accounts");
@@clientName(NetAppAccounts.createOrUpdate::parameters.resource, "body");
@@clientLocation(NetAppAccounts.update, "Accounts");
@@clientName(NetAppAccounts.update::parameters.properties, "body");
@@clientLocation(NetAppAccounts.delete, "Accounts");
@@clientLocation(NetAppAccounts.list, "Accounts");
@@clientLocation(NetAppAccounts.listBySubscription, "Accounts");
@@clientLocation(NetAppAccounts.renewCredentials, "Accounts");
@@clientLocation(NetAppAccounts.transitionToCmk, "Accounts");
@@clientLocation(NetAppAccounts.getChangeKeyVaultInformation, "Accounts");
@@clientLocation(NetAppAccounts.changeKeyVault, "Accounts");
@@clientLocation(NetAppAccounts.listByNetAppAccount, VolumeGroups);
@@clientLocation(NetAppAccounts.migrateBackups, "BackupsUnderAccount");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(NetAppAccount.properties);

@@clientLocation(CapacityPools.get, "Pools");
@@clientLocation(CapacityPools.createOrUpdate, "Pools");
@@clientName(CapacityPools.createOrUpdate::parameters.resource, "body");
@@clientLocation(CapacityPools.update, "Pools");
@@clientName(CapacityPools.update::parameters.properties, "body");
@@clientLocation(CapacityPools.delete, "Pools");
@@clientLocation(CapacityPools.list, "Pools");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(CapacityPool.properties);

@@clientName(Volumes.createOrUpdate::parameters.resource, "body");
@@clientName(Volumes.update::parameters.properties, "body");
@@clientLocation(Volumes.getLatestStatus, Backups);
@@clientLocation(Volumes.getVolumeLatestRestoreStatus, Backups);
@@clientLocation(Volumes.migrateBackups, "BackupsUnderVolume");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Volume.properties);

@@clientName(Snapshots.create::parameters.resource, "body");
@@clientName(Snapshots.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Snapshot.properties);

@@clientName(SnapshotPolicies.create::parameters.resource, "body");
@@clientName(SnapshotPolicies.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SnapshotPolicy.properties);

@@clientName(BackupPolicies.create::parameters.resource, "body");
@@clientName(BackupPolicies.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(BackupPolicy.properties);

@@clientName(VolumeQuotaRules.create::parameters.resource, "body");
@@clientName(VolumeQuotaRules.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumeQuotaRule.properties);

@@clientName(VolumeGroups.create::parameters.resource, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(VolumeGroupDetails.properties);

@@clientLocation(SubvolumeInfos.get, "Subvolumes");
@@clientLocation(SubvolumeInfos.create, "Subvolumes");
@@clientName(SubvolumeInfos.create::parameters.resource, "body");
@@clientLocation(SubvolumeInfos.update, "Subvolumes");
@@clientName(SubvolumeInfos.update::parameters.properties, "body");
@@clientLocation(SubvolumeInfos.delete, "Subvolumes");
@@clientLocation(SubvolumeInfos.listByVolume, "Subvolumes");
@@clientLocation(SubvolumeInfos.getMetadata, "Subvolumes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SubvolumeInfo.properties);

@@clientName(Backups.create::parameters.resource, "body");
@@clientName(Backups.update::parameters.properties, "body");
@@clientLocation(Backups.restoreFiles, "BackupsUnderBackupVault");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Backup.properties);

@@clientName(BackupVaults.createOrUpdate::parameters.resource, "body");
@@clientName(BackupVaults.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(BackupVault.properties);

@@clientName(Buckets.createOrUpdate::parameters.resource, "body");
@@clientName(Buckets.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Bucket.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(BucketPatch.properties);

@@clientLocation(NetAppResourceOperationGroup.checkNameAvailability,
  "NetAppResource"
);
@@clientLocation(NetAppResourceOperationGroup.checkFilePathAvailability,
  "NetAppResource"
);
@@clientLocation(NetAppResourceOperationGroup.checkQuotaAvailability,
  "NetAppResource"
);
@@clientLocation(NetAppResourceOperationGroup.queryRegionInfo,
  "NetAppResource"
);
@@clientLocation(NetAppResourceOperationGroup.queryNetworkSiblingSet,
  "NetAppResource"
);
@@clientLocation(NetAppResourceOperationGroup.updateNetworkSiblingSet,
  "NetAppResource"
);

@@clientLocation(NetAppResourceUsagesOperationGroup.list,
  "NetAppResourceUsages"
);
@@clientLocation(NetAppResourceUsagesOperationGroup.get,
  "NetAppResourceUsages"
);

@@clientName(ApplicationType.`SAP-HANA`, "SAP_HANA", "python");
