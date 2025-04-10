import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConnectedVMwarevSphere;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineInstanceUpdate.properties);

@@clientName(ResourcePools.create::parameters.resource, "body");
@@clientName(ResourcePools.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourcePool.properties);

@@clientName(Clusters.create::parameters.resource, "body");
@@clientName(Clusters.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(Hosts.create::parameters.resource, "body");
@@clientName(Hosts.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Host.properties);

@@clientName(Datastores.create::parameters.resource, "body");
@@clientName(Datastores.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Datastore.properties);

@@clientName(VCenters.create::parameters.resource, "body");
@@clientName(VCenters.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VCenter.properties);

@@clientName(VirtualMachineTemplates.create::parameters.resource, "body");
@@clientName(VirtualMachineTemplates.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineTemplate.properties);

@@clientName(VirtualNetworks.create::parameters.resource, "body");
@@clientName(VirtualNetworks.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualNetwork.properties);

@@clientName(InventoryItems.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(InventoryItem.properties);

@@clientName(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(VirtualMachineInstances.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineInstance.properties);

@@clientName(VmInstanceHybridIdentityMetadataOperationGroup,
  "VmInstanceHybridIdentityMetadata"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VmInstanceHybridIdentityMetadata.properties);

@@clientName(GuestAgents.create::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GuestAgent.properties);
