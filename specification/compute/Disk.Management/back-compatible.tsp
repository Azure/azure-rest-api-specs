import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskEncryptionSetUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SnapshotUpdate.properties);

@@clientName(Disks.update, "Disks.update::parameters.properties", "disk");
@@clientName(Disks.grantAccess,
  "Disks.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Disk.properties);

@@clientName(DiskAccesses.update,
  "DiskAccesses.update::parameters.properties",
  "diskAccess"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskAccess.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(DiskEncryptionSets.update,
  "DiskEncryptionSets.update::parameters.properties",
  "diskEncryptionSet"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskEncryptionSet.properties);

@@clientName(DiskRestorePoints.grantAccess,
  "DiskRestorePoints.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiskRestorePoint.properties);

@@clientName(Snapshots.update,
  "Snapshots.update::parameters.properties",
  "snapshot"
);
@@clientName(Snapshots.grantAccess,
  "Snapshots.grantAccess::parameters.body",
  "grantAccessData"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Snapshot.properties);

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
