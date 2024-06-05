import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

// client
@@clientName(Microsoft.AVS, "Avs", "java");

// flatten
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.ProxyResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties
);

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PrivateCloudUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ClusterUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkSegmentUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDhcpUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkPortMirroringUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkVMGroupUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsServiceUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(WorkloadNetworkDnsZoneUpdate.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(PlacementPolicyUpdate.properties);

// operation
@@friendlyName(Addons.list, "list");
@@friendlyName(PlacementPolicies.list, "list");
@@friendlyName(VirtualMachines.list, "list");
@@friendlyName(HcxEnterpriseSites.list, "list");
@@friendlyName(ScriptExecutions.list, "list");
@@friendlyName(ScriptPackages.list, "list");
@@friendlyName(Datastores.list, "list");
@@friendlyName(Clusters.list, "list");
@@friendlyName(ScriptCmdlets.list, "list");
@@friendlyName(Authorizations.list, "list");
@@friendlyName(CloudLinks.list, "list");
@@friendlyName(GlobalReachConnections.list, "list");

// model
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity"
);
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentityType,
  "ResourceIdentityType"
);

@@clientName(VmVmPlacementPolicyProperties, "VmPlacementPolicyProperties");
@@clientName(WorkloadNetworkPublicIP, "WorkloadNetworkPublicIp");
@@clientName(WorkloadNetworkPublicIPProvisioningState,
  "WorkloadNetworkPublicIpProvisioningState"
);

// property
@@clientName(Circuit.expressRouteID, "expressRouteId");
@@clientName(Circuit.expressRoutePrivatePeeringID,
  "expressRoutePrivatePeeringId"
);
@@clientName(WorkloadNetworkPublicIPProperties,
  "WorkloadNetworkPublicIpProperties"
);
@@clientName(WorkloadNetworkPublicIPProperties.publicIPBlock,
  "publicIpBlock"
);
