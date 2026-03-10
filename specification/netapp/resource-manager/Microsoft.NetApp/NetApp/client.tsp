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

// ============================================================
// C# backward compatibility: type renames
// ============================================================
@@clientName(Microsoft.NetApp.KeyVaultProperties, "NetAppKeyVaultProperties", "csharp");
@@clientName(Microsoft.NetApp.ReplicationObject, "NetAppReplicationObject", "csharp");
@@clientName(Microsoft.NetApp.BackupRestoreFiles, "NetAppVolumeBackupBackupRestoreFilesContent", "csharp");
@@clientName(Microsoft.NetApp.VolumeBackupProperties, "NetAppVolumeBackupConfiguration", "csharp");
@@clientName(Microsoft.NetApp.VolumeGroupVolumeProperties, "NetAppVolumeGroupVolume", "csharp");
@@clientName(Microsoft.NetApp.VolumePatch, "NetAppVolumePatch", "csharp");
@@clientName(Microsoft.NetApp.ReplicationStatus, "NetAppVolumeReplicationStatus", "csharp");

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
