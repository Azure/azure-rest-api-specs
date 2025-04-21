import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ElasticSan;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ElasticSanUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(EncryptionProperties.identity, "encryptionIdentity");

@@clientName(EncryptionIdentity.userAssignedIdentity,
  "encryptionUserAssignedIdentity"
);

@@clientName(VirtualNetworkRule.id, "virtualNetworkResourceId");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroupUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeUpdate.properties);

@@clientName(ElasticSans.create::parameters.resource, "parameters");
@@clientName(ElasticSans.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ElasticSan.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(VolumeGroups.create::parameters.resource, "parameters");
@@clientName(VolumeGroups.update::parameters.properties, "parameters");
@@clientName(VolumeGroups.preBackup::parameters.body, "parameters");
@@clientName(VolumeGroups.preRestore::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VolumeGroup.properties);

@@clientName(Snapshots.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Snapshot.properties);

@@clientName(Volumes.create::parameters.resource, "parameters");
@@clientName(Volumes.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Volume.properties);
