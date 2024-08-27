import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

// flatten
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties
);

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Location.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Cluster.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Datastore.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(HcxEnterpriseSite.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ExpressRouteAuthorization.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(GlobalReachConnection.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetwork.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkSegment.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDhcp.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkGateway.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkPortMirroring.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkVMGroup.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkVirtualMachine.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsService.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsZone.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkPublicIP.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(CloudLink.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(VirtualMachine.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptPackage.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptCmdlet.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ScriptExecution.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(IscsiPath.properties);

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PrivateCloudUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ClusterUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PlacementPolicyUpdate.properties);

// model
@@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity"
);
// name conflict with Azure.ResourceManager.CommonTypes.ResourceIdentityType
// @@clientName(Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentityType,
//   "ResourceIdentityType"
// );

@@clientName(VmVmPlacementPolicyProperties, "VmPlacementPolicyProperties");
@@clientName(WorkloadNetworkPublicIP, "WorkloadNetworkPublicIp", "java");
@@clientName(WorkloadNetworkPublicIPProvisioningState,
  "WorkloadNetworkPublicIpProvisioningState",
  "java"
);

// property
@@clientName(Circuit.expressRouteID, "expressRouteId", "java");
@@clientName(Circuit.expressRoutePrivatePeeringID,
  "expressRoutePrivatePeeringId",
  "java"
);
@@clientName(WorkloadNetworkPublicIPProperties,
  "WorkloadNetworkPublicIpProperties",
  "java"
);
@@clientName(WorkloadNetworkPublicIPProperties.publicIPBlock,
  "publicIpBlock",
  "java"
);
