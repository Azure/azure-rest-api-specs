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
@@friendlyName(Addons.list, "list", "java");
@@friendlyName(PlacementPolicies.list, "list", "java");
@@friendlyName(VirtualMachines.list, "list", "java");
@@friendlyName(HcxEnterpriseSites.list, "list", "java");
@@friendlyName(ScriptExecutions.list, "list", "java");
@@friendlyName(ScriptPackages.list, "list", "java");
@@friendlyName(Datastores.list, "list", "java");
@@friendlyName(Clusters.list, "list", "java");
@@friendlyName(ScriptCmdlets.list, "list", "java");

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
