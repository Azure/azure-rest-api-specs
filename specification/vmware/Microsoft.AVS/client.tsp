import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties, "java");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties,
  "java"
);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.ProxyResource.properties, "java");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties,
  "java"
);

@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity",
  "java"
);
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentityType,
  "ResourceIdentityType",
  "java"
);

// operation
@@clientName(Addons.list, "list", "java");
@@clientName(PlacementPolicies.list, "list", "java");
@@clientName(VirtualMachines.list, "list", "java");
@@clientName(HcxEnterpriseSites.list, "list", "java");
@@clientName(ScriptExecutions.list, "list", "java");
@@clientName(ScriptPackages.list, "list", "java");
@@clientName(Datastores.list, "list", "java");
@@clientName(Clusters.list, "list", "java");
@@clientName(ScriptCmdlets.list, "list", "java");

// model
@@clientName(VmVmPlacementPolicyProperties,
  "VmPlacementPolicyProperties",
  "java"
);
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
