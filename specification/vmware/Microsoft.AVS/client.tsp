import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.TrackedResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.ProxyResource.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties);

@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentity,
  "PrivateCloudIdentity");
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentityType,
  "ResourceIdentityType");

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

// model
@@clientName(VmVmPlacementPolicyProperties,
  "VmPlacementPolicyProperties");
@@clientName(WorkloadNetworkPublicIP, "WorkloadNetworkPublicIp");
@@clientName(WorkloadNetworkPublicIPProvisioningState,
  "WorkloadNetworkPublicIpProvisioningState");

// property
@@clientName(Circuit.expressRouteID, "expressRouteId");
@@clientName(Circuit.expressRoutePrivatePeeringID,
  "expressRoutePrivatePeeringId");
