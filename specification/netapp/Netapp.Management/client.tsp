import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetApp;

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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionQuotaItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegionInfoResource.properties);

@@clientName(NetAppAccounts.createOrUpdate::parameters.resource, "body");
@@clientName(NetAppAccounts.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetAppAccount.properties);

@@clientName(CapacityPools.createOrUpdate::parameters.resource, "body");
@@clientName(CapacityPools.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityPool.properties);

@@clientName(Volumes.createOrUpdate::parameters.resource, "body");
@@clientName(Volumes.update::parameters.properties, "body");
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

@@clientName(VolumeGroupDetailsOperationGroup, "VolumeGroupDetails");
@@clientName(VolumeGroups.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroupDetails.properties);

@@clientName(SubvolumeInfos.create::parameters.resource, "body");
@@clientName(SubvolumeInfos.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubvolumeInfo.properties);

@@clientName(Backups.create::parameters.resource, "body");
@@clientName(Backups.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Backup.properties);

@@clientName(BackupVaults.createOrUpdate::parameters.resource, "body");
@@clientName(BackupVaults.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupVault.properties);
