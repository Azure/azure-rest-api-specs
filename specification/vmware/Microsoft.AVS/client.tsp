import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

@@flattenProperty(Azure.ResourceManager.TrackedResource.properties, "java");
@@flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties, "java");
@@flattenProperty(Azure.ResourceManager.ProxyResource.properties, "java");
@@flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties, "java");

@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentity, "PrivateCloudIdentity", "java");
@@clientName(Azure.ResourceManager.Foundations.SystemAssignedServiceIdentityType, "ResourceIdentityType", "java");

@@clientName(VmVmPlacementPolicyProperties, "VmPlacementPolicyProperties", "java");
@@clientName(WorkloadNetworkPublicIP, "WorkloadNetworkPublicIp", "java");
@@clientName(WorkloadNetworkPublicIPProvisioningState, "WorkloadNetworkPublicIpProvisioningState", "java");
