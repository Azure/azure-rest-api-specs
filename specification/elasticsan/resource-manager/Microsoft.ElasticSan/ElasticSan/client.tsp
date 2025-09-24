import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.ElasticSan;
using Azure.ClientGenerator.Core;
using Azure.Core;

@@clientName(SkuName, "ElasticSanSkuName", "csharp");
@@clientName(SkuName.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(SkuName.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(EncryptionType, "ElasticSanEncryptionType", "csharp");
@@clientName(Volume, "ElasticSanVolume", "csharp");
@@alternateType(VolumeProperties.volumeId, uuid, "csharp");
@@clientName(VolumeCreateOption, "ElasticSanVolumeCreateOption", "csharp");
@@clientName(VolumeGroup, "ElasticSanVolumeGroup", "csharp");
@@clientName(VolumeGroupList, "ElasticSanVolumeGroupList", "csharp");
@@clientName(VolumeList, "ElasticSanVolumeList", "csharp");
@@clientName(SkuInformationList, "ElasticSanSkuInformationList", "csharp");
@@clientName(SkuLocationInfo, "ElasticSanSkuLocationInfo", "csharp");
@@alternateType(SkuLocationInfo.location, azureLocation, "csharp");
@@clientName(Snapshot, "ElasticSanSnapshot", "csharp");
@@clientName(KeyVaultProperties, "ElasticSanKeyVaultProperties", "csharp");
@@clientName(EncryptionProperties, "ElasticSanEncryptionProperties", "csharp");
@@clientName(PublicNetworkAccess, "ElasticSanPublicNetworkAccess", "csharp");
@@clientName(StorageTargetType, "ElasticSanStorageTargetType", "csharp");
@@clientName(DeleteType, "ElasticSanDeleteType", "csharp");
@@clientName(VirtualNetworkRule, "ElasticSanVirtualNetworkRule", "csharp");
@@alternateType(VirtualNetworkRule.id, armResourceIdentifier, "csharp");
@@clientName(EncryptionIdentity, "ElasticSanEncryptionIdentity", "csharp");
@@alternateType(EncryptionIdentity.userAssignedIdentity,
  armResourceIdentifier,
  "csharp"
);
@@clientName(NetworkRuleSet, "ElasticSanNetworkRuleSet", "csharp");
@@clientName(ScaleUpProperties, "ElasticSanScaleUpProperties", "csharp");
@@clientName(DeleteRetentionPolicy,
  "ElasticSanDeleteRetentionPolicy",
  "csharp"
);
@@clientName(Action, "ElasticSanVirtualNetworkRuleAction", "csharp");
@@clientName(OperationalStatus, "ResourceOperationalStatus", "csharp");
@@clientName(ProvisioningStates, "ElasticSanProvisioningState", "csharp");
@@clientName(SKUCapability, "ElasticSanSkuCapability", "csharp");
@@clientName(SourceCreationData, "ElasticSanVolumeDataSourceInfo", "csharp");
@@alternateType(SourceCreationData.sourceId, armResourceIdentifier, "csharp");
@@clientName(SnapshotCreationData, "SnapshotCreationInfo", "csharp");
@@alternateType(SnapshotCreationData.sourceId, armResourceIdentifier, "csharp");
@@clientName(DiskSnapshotList, "DiskSnapshotListContent", "csharp");
@@clientName(PolicyState, "ElasticSanDeleteRetentionPolicyState", "csharp");
@@clientName(PreValidationResponse, "ElasticSanPreValidationResult", "csharp");
@@clientName(VolumeNameList, "ElasticSanVolumeNameListContent", "csharp");
@@clientName(`x-ms-delete-snapshots`,
  "ElasticSanDeleteSnapshotsUnderVolume",
  "csharp"
);
@@clientName(`x-ms-access-soft-deleted-resources`,
  "ElasticSanAccessSoftDeletedVolume",
  "csharp"
);
@@clientName(`x-ms-force-delete`, "ElasticSanForceDeleteVolume", "csharp");
@@clientName(ElasticSanProperties.totalMBps, "totalMbps", "csharp");
@@clientName(Microsoft.ElasticSan.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(ManagedByInfo.resourceId, armResourceIdentifier, "csharp");
@@clientName(PrivateLinkResource, "ElasticSanPrivateLinkResource", "csharp");
@@usage(PrivateLinkResource, Usage.input, "csharp");
@@clientName(restoreVolume, "RestoreVolume", "csharp");

// Move restoreVolume operation to Management client for Go to maintain compatibility
@@clientLocation(Microsoft.ElasticSan.restoreVolume, "Management", "go");
