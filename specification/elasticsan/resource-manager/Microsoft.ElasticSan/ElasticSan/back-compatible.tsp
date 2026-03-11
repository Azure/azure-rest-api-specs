import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ElasticSanUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(EncryptionProperties.identity, "EncryptionIdentity");

@@clientName(EncryptionIdentity.userAssignedIdentity,
  "EncryptionUserAssignedIdentity"
);

@@clientName(VirtualNetworkRule.id, "VirtualNetworkResourceId");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VolumeGroupUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VolumeUpdate.properties);

@@clientName(ElasticSans.create::parameters.resource, "parameters");
@@clientName(ElasticSans.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ElasticSan.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientName(VolumeGroups.create::parameters.resource, "parameters");
@@clientName(VolumeGroups.update::parameters.properties, "parameters");
@@clientName(VolumeGroups.preBackup::parameters.body, "parameters");
@@clientName(VolumeGroups.preRestore::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VolumeGroup.properties);

@@clientName(Snapshots.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Snapshot.properties);

@@clientName(Volumes.create::parameters.resource, "parameters");
@@clientName(Volumes.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Volume.properties);

@@clientName(AutoScaleProperties.scaleUpProperties, "ScaleUpProperties");
@@clientName(EncryptionProperties.keyVaultProperties, "KeyVaultProperties");
@@clientName(KeyVaultProperties.keyName, "KeyName");
@@clientName(KeyVaultProperties.keyVersion, "KeyVersion");
@@clientName(KeyVaultProperties.keyVaultUri, "KeyVaultUri");
@@clientName(KeyVaultProperties.currentVersionedKeyIdentifier,
  "CurrentVersionedKeyIdentifier"
);
@@clientName(KeyVaultProperties.lastKeyRotationTimestamp,
  "LastKeyRotationTimestamp"
);
@@clientName(KeyVaultProperties.currentVersionedKeyExpirationTimestamp,
  "CurrentVersionedKeyExpirationTimestamp"
);
@@clientName(ManagedByInfo.resourceId, "ResourceId");

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// ElasticSans interface operations
@@clientLocation(ElasticSans.listByElasticSan, "PrivateLinkResources");

// SkusOperationGroup interface operations
@@clientLocation(SkusOperationGroup.list, "Skus");

// Snapshots interface operations
// this clientLocation setting will jeopardize the logic in C# generator of detecting resource, making this no longer a resource. Therefore adding this !csharp scope to avoid that (temporarily)
@@clientLocation(Snapshots.get, "VolumeSnapshots", "!csharp");
@@clientLocation(Snapshots.create, "VolumeSnapshots", "!csharp");
@@clientLocation(Snapshots.delete, "VolumeSnapshots", "!csharp");
@@clientLocation(Snapshots.listByVolumeGroup, "VolumeSnapshots", "!csharp");

// VolumeGroups interface operations
@@clientLocation(VolumeGroups.preBackup, Volumes);
@@clientLocation(VolumeGroups.preRestore, Volumes);

@@clientName(`x-ms-delete-snapshots`, "XMsDeleteSnapshots", "python");
@@clientName(`x-ms-force-delete`, "XMsForceDelete", "python");
@@clientName(`x-ms-access-soft-deleted-resources`,
  "XMsAccessSoftDeletedResources",
  "python"
);
