import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateCloudUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PlacementPolicyUpdate.properties);

@@clientName(PrivateClouds.createOrUpdate::parameters.resource, "privateCloud");
@@clientName(PrivateClouds.update::parameters.properties, "privateCloudUpdate");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateCloud.properties);

@@clientName(Addons.createOrUpdate::parameters.resource, "addon");

@@clientName(ExpressRouteAuthorizations.createOrUpdate::parameters.resource,
  "authorization"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExpressRouteAuthorization.properties);

@@clientName(CloudLinks.createOrUpdate::parameters.resource, "cloudLink");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudLink.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "cluster");
@@clientName(Clusters.update::parameters.properties, "clusterUpdate");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(Datastores.createOrUpdate::parameters.resource, "datastore");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Datastore.properties);

@@clientName(PlacementPolicies.createOrUpdate::parameters.resource,
  "placementPolicy"
);
@@clientName(PlacementPolicies.update::parameters.properties,
  "placementPolicyUpdate"
);

@@clientName(VirtualMachines.restrictMovement::parameters.body,
  "restrictMovement"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachine.properties);

@@clientName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "globalReachConnection"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GlobalReachConnection.properties);

@@clientName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "hcxEnterpriseSite"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HcxEnterpriseSite.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IscsiPath.properties);

@@clientName(ScriptExecutions.createOrUpdate::parameters.resource,
  "scriptExecution"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScriptExecution.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScriptPackage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScriptCmdlet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetwork.properties);

@@clientName(WorkloadNetworkDhcps.createDhcp::parameters.resource,
  "workloadNetworkDhcp"
);
@@clientName(WorkloadNetworkDhcps.updateDhcp::parameters.properties,
  "workloadNetworkDhcp"
);

@@clientName(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "workloadNetworkDnsService"
);
@@clientName(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "workloadNetworkDnsService"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkDnsService.properties);

@@clientName(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "workloadNetworkDnsZone"
);
@@clientName(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "workloadNetworkDnsZone"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkDnsZone.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkGateway.properties);

@@clientName(WorkloadNetworkPortMirrorings.createPortMirroring::parameters.resource,
  "workloadNetworkPortMirroring"
);
@@clientName(WorkloadNetworkPortMirrorings.updatePortMirroring::parameters.properties,
  "workloadNetworkPortMirroring"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkPortMirroring.properties);

@@clientName(WorkloadNetworkPublicIPS.createPublicIP::parameters.resource,
  "workloadNetworkPublicIP"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkPublicIP.properties);

@@clientName(WorkloadNetworkSegments.createSegments::parameters.resource,
  "workloadNetworkSegment"
);
@@clientName(WorkloadNetworkSegments.updateSegments::parameters.properties,
  "workloadNetworkSegment"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkSegment.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkVirtualMachine.properties);

@@clientName(WorkloadNetworkVMGroups.createVMGroup::parameters.resource,
  "workloadNetworkVMGroup"
);
@@clientName(WorkloadNetworkVMGroups.updateVMGroup::parameters.properties,
  "workloadNetworkVMGroup"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WorkloadNetworkVMGroup.properties);
