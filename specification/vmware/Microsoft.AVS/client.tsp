import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

// client
@@clientName(Microsoft.AVS, "Avs", "java");
@@clientName(Microsoft.AVS, "AVS", "python");

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
@@friendlyName(WorkloadNetworks.list, "list");

// model
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity"
);
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentityType,
  "ResourceIdentityType"
);

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
