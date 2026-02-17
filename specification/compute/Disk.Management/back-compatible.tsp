import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiskUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiskEncryptionSetUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SnapshotUpdate.properties);

@@clientName(Disks.update, "Disks.update::parameters.properties", "disk");
@@clientName(Disks.grantAccess,
  "Disks.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Disk.properties);

@@clientName(DiskAccesses.update,
  "DiskAccesses.update::parameters.properties",
  "diskAccess"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiskAccess.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientName(DiskEncryptionSets.update,
  "DiskEncryptionSets.update::parameters.properties",
  "diskEncryptionSet"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiskEncryptionSet.properties
);

@@clientName(DiskRestorePoints.grantAccess,
  "DiskRestorePoints.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiskRestorePoint.properties
);

@@clientName(Snapshots.update,
  "Snapshots.update::parameters.properties",
  "snapshot"
);
@@clientName(Snapshots.grantAccess,
  "Snapshots.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Snapshot.properties);

@@clientName(DiskAccesses.createOrUpdate::parameters.resource, "diskAccess");
@@clientName(DiskAccesses.update::parameters.properties, "diskAccess");
@@clientName(PrivateEndpointConnections.updateAPrivateEndpointConnection::parameters.resource,
  "privateEndpointConnection"
);
@@clientName(DiskEncryptionSets.createOrUpdate::parameters.resource,
  "diskEncryptionSet"
);
@@clientName(DiskEncryptionSets.update::parameters.properties,
  "diskEncryptionSet"
);
@@clientName(Disks.createOrUpdate::parameters.resource, "disk");
@@clientName(Disks.update::parameters.properties, "disk");
@@clientName(Disks.grantAccess::parameters.body, "grantAccessData");
@@clientName(DiskRestorePoints.grantAccess::parameters.body, "grantAccessData");
@@clientName(Snapshots.createOrUpdate::parameters.resource, "snapshot");
@@clientName(Snapshots.update::parameters.properties, "snapshot");
@@clientName(Snapshots.grantAccess::parameters.body, "grantAccessData");

@@clientLocation(DiskRestorePoints.get, "DiskRestorePoint", "!csharp");
@@clientLocation(DiskRestorePoints.listByRestorePoint,
  "DiskRestorePoint",
  "!csharp"
);
@@clientLocation(DiskRestorePoints.grantAccess, "DiskRestorePoint", "!csharp");
@@clientLocation(DiskRestorePoints.revokeAccess, "DiskRestorePoint", "!csharp");

@@clientLocation(PrivateEndpointConnections.getAPrivateEndpointConnection,
  DiskAccesses,
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.updateAPrivateEndpointConnection,
  DiskAccesses,
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.deleteAPrivateEndpointConnection,
  DiskAccesses,
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  DiskAccesses,
  "!csharp"
);
