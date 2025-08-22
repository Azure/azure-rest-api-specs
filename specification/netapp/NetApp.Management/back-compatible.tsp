import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetApp;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UsageResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetAppAccountPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GetKeyVaultStatusResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityPoolPatch.properties);

@@clientName(ExportPolicyRule.kerberos5iReadOnly, "kerberos5IReadOnly");
@@clientName(ExportPolicyRule.kerberos5iReadWrite, "kerberos5IReadWrite");
@@clientName(ExportPolicyRule.kerberos5pReadOnly, "kerberos5PReadOnly");
@@clientName(ExportPolicyRule.kerberos5pReadWrite, "kerberos5PReadWrite");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SnapshotPolicyPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupPolicyPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeQuotaRulePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroupVolumeProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubvolumePatchRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubvolumeModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MountTarget.tags);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MountTarget.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SnapshotPolicyDetails.properties);

@@clientLocation(SubscriptionQuotaItems.get, "NetAppResourceQuotaLimits");
@@clientLocation(SubscriptionQuotaItems.list, "NetAppResourceQuotaLimits");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionQuotaItem.properties);

@@clientLocation(RegionInfoResources.get, "NetAppResourceRegionInfos");
@@clientLocation(RegionInfoResources.list, "NetAppResourceRegionInfos");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetAppAccount.properties);

@@clientLocation(CapacityPools.get, "Pools");
@@clientLocation(CapacityPools.createOrUpdate, "Pools");
@@clientName(CapacityPools.createOrUpdate::parameters.resource, "body");
@@clientLocation(CapacityPools.update, "Pools");
@@clientName(CapacityPools.update::parameters.properties, "body");
@@clientLocation(CapacityPools.delete, "Pools");
@@clientLocation(CapacityPools.list, "Pools");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityPool.properties);

@@clientName(Volumes.createOrUpdate::parameters.resource, "body");
@@clientName(Volumes.update::parameters.properties, "body");
@@clientLocation(Volumes.getLatestStatus, Backups);
@@clientLocation(Volumes.getVolumeLatestRestoreStatus, Backups);
@@clientLocation(Volumes.migrateBackups, "BackupsUnderVolume");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Volume.properties);

@@clientName(Snapshots.create::parameters.resource, "body");
@@clientName(Snapshots.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Snapshot.properties);

@@clientName(SnapshotPolicies.create::parameters.resource, "body");
@@clientName(SnapshotPolicies.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SnapshotPolicy.properties);

@@clientName(BackupPolicies.create::parameters.resource, "body");
@@clientName(BackupPolicies.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupPolicy.properties);

@@clientName(VolumeQuotaRules.create::parameters.resource, "body");
@@clientName(VolumeQuotaRules.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeQuotaRule.properties);

@@clientName(VolumeGroups.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroupDetails.properties);

@@clientLocation(SubvolumeInfos.get, "Subvolumes");
@@clientLocation(SubvolumeInfos.create, "Subvolumes");
@@clientName(SubvolumeInfos.create::parameters.resource, "body");
@@clientLocation(SubvolumeInfos.update, "Subvolumes");
@@clientName(SubvolumeInfos.update::parameters.properties, "body");
@@clientLocation(SubvolumeInfos.delete, "Subvolumes");
@@clientLocation(SubvolumeInfos.listByVolume, "Subvolumes");
@@clientLocation(SubvolumeInfos.getMetadata, "Subvolumes");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubvolumeInfo.properties);

@@clientName(Backups.create::parameters.resource, "body");
@@clientName(Backups.update::parameters.properties, "body");
@@clientLocation(Backups.restoreFiles, "BackupsUnderBackupVault");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Backup.properties);

@@clientName(BackupVaults.createOrUpdate::parameters.resource, "body");
@@clientName(BackupVaults.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupVault.properties);

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
