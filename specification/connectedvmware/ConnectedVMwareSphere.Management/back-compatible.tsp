import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConnectedVMwarevSphere;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VirtualMachineInstanceUpdate.properties);

@@clientName(ResourcePools.create::parameters.resource, "body");
@@clientName(ResourcePools.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ResourcePool.properties);

@@clientName(Clusters.create::parameters.resource, "body");
@@clientName(Clusters.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Cluster.properties);

@@clientName(Hosts.create::parameters.resource, "body");
@@clientName(Hosts.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Host.properties);

@@clientName(Datastores.create::parameters.resource, "body");
@@clientName(Datastores.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Datastore.properties);

@@clientName(VCenters.create::parameters.resource, "body");
@@clientName(VCenters.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VCenter.properties);

@@clientName(VirtualMachineTemplates.create::parameters.resource, "body");
@@clientName(VirtualMachineTemplates.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VirtualMachineTemplate.properties);

@@clientName(VirtualNetworks.create::parameters.resource, "body");
@@clientName(VirtualNetworks.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VirtualNetwork.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(GuestAgent.properties);

@@clientName(InventoryItems.create::parameters.resource, "body");

@@clientName(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(VirtualMachineInstances.update::parameters.properties, "body");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VirtualMachineInstance.properties);

@@clientName(VmInstanceHybridIdentityMetadataOperationGroup,
  "VmInstanceHybridIdentityMetadata"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(VmInstanceHybridIdentityMetadata.properties);

@@clientName(GuestAgents.create::parameters.resource, "body");
@@clientLocation(GuestAgents.get, "VMInstanceGuestAgents", "!csharp");
@@clientLocation(GuestAgents.create, "VMInstanceGuestAgents", "!csharp");
@@clientName(GuestAgents.create::parameters.resource, "body");
@@clientLocation(GuestAgents.delete, "VMInstanceGuestAgents", "!csharp");
@@clientLocation(GuestAgents.list, "VMInstanceGuestAgents", "!csharp");
