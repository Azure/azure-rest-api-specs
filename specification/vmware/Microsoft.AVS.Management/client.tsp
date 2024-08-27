import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.AVS;

@client(
  {
    name: "AvsClient",
    service: Microsoft.AVS,
  },
  "java,csharp,javascript,go"
)
@client(
  {
    name: "AVSClient",
    service: Microsoft.AVS,
  },
  "python"
)
@useDependency(Microsoft.AVS.Versions.v2023_09_01)
namespace Customization;

// client
@@clientName(Microsoft.AVS, "Avs", "java");
@@clientName(Microsoft.AVS, "AVS", "python");

// operation group per interface
#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Operations extends Microsoft.AVS.Operations {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Locations extends Microsoft.AVS.Locations {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PrivateClouds extends Microsoft.AVS.PrivateClouds {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Clusters extends Microsoft.AVS.Clusters {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Datastores extends Microsoft.AVS.Datastores {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface HcxEnterpriseSites extends Microsoft.AVS.HcxEnterpriseSites {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Authorizations extends Microsoft.AVS.Authorizations {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface GlobalReachConnections extends Microsoft.AVS.GlobalReachConnections {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface CloudLinks extends Microsoft.AVS.CloudLinks {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Addons extends Microsoft.AVS.Addons {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface VirtualMachines extends Microsoft.AVS.VirtualMachines {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PlacementPolicies extends Microsoft.AVS.PlacementPolicies {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptPackages extends Microsoft.AVS.ScriptPackages {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptCmdlets extends Microsoft.AVS.ScriptCmdlets {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptExecutions extends Microsoft.AVS.ScriptExecutions {}

#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface IscsiPaths extends Microsoft.AVS.IscsiPaths {}

// group multiple interfaces into single operation group
#suppress "@azure-tools/typespec-client-generator-core/client-service" "operationGroup"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
@operationGroup
interface WorkloadNetworks {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  list is Microsoft.AVS.WorkloadNetworks.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  get is Microsoft.AVS.WorkloadNetworks.get;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @clientName("listSegments")
  listSegments is Microsoft.AVS.WorkloadNetworkSegments.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @clientName("getSegment")
  getSegment is Microsoft.AVS.WorkloadNetworkSegments.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @clientName("createSegment")
  createSegment is Microsoft.AVS.WorkloadNetworkSegments.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @clientName("updateSegment")
  updateSegment is Microsoft.AVS.WorkloadNetworkSegments.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  @clientName("deleteSegment")
  deleteSegment is Microsoft.AVS.WorkloadNetworkSegments.deleteSegment;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listDhcp is Microsoft.AVS.WorkloadNetworkDhcpConfigurations.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  getDhcp is Microsoft.AVS.WorkloadNetworkDhcpConfigurations.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createDhcp is Microsoft.AVS.WorkloadNetworkDhcpConfigurations.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  updateDhcp is Microsoft.AVS.WorkloadNetworkDhcpConfigurations.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDhcp is Microsoft.AVS.WorkloadNetworkDhcpConfigurations.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listGateways is Microsoft.AVS.WorkloadNetworkGateways.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  getGateway is Microsoft.AVS.WorkloadNetworkGateways.get;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listPortMirroring is Microsoft.AVS.WorkloadNetworkPortMirroringProfiles.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  getPortMirroring is Microsoft.AVS.WorkloadNetworkPortMirroringProfiles.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createPortMirroring is Microsoft.AVS.WorkloadNetworkPortMirroringProfiles.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  updatePortMirroring is Microsoft.AVS.WorkloadNetworkPortMirroringProfiles.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  deletePortMirroring is Microsoft.AVS.WorkloadNetworkPortMirroringProfiles.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  listVMGroups is Microsoft.AVS.WorkloadNetworkVmGroups.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  getVMGroup is Microsoft.AVS.WorkloadNetworkVmGroups.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createVMGroup is Microsoft.AVS.WorkloadNetworkVmGroups.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  updateVMGroup is Microsoft.AVS.WorkloadNetworkVmGroups.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  deleteVMGroup is Microsoft.AVS.WorkloadNetworkVmGroups.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listVirtualMachines is Microsoft.AVS.WorkloadNetworkVirtualMachines.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  getVirtualMachine is Microsoft.AVS.WorkloadNetworkVirtualMachines.get;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listDnsServices is Microsoft.AVS.WorkloadNetworkDnsServices.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  getDnsService is Microsoft.AVS.WorkloadNetworkDnsServices.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createDnsService is Microsoft.AVS.WorkloadNetworkDnsServices.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  updateDnsService is Microsoft.AVS.WorkloadNetworkDnsServices.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  deleteDnsService is Microsoft.AVS.WorkloadNetworkDnsServices.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  listDnsZones is Microsoft.AVS.WorkloadNetworkDnsZones.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  getDnsZone is Microsoft.AVS.WorkloadNetworkDnsZones.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createDnsZone is Microsoft.AVS.WorkloadNetworkDnsZones.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  updateDnsZone is Microsoft.AVS.WorkloadNetworkDnsZones.update;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  deleteDnsZone is Microsoft.AVS.WorkloadNetworkDnsZones.delete;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  listPublicIPs is Microsoft.AVS.WorkloadNetworkPublicIps.list;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  getPublicIP is Microsoft.AVS.WorkloadNetworkPublicIps.get;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  createPublicIP is Microsoft.AVS.WorkloadNetworkPublicIps.create;
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing operationId."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  deletePublicIP is Microsoft.AVS.WorkloadNetworkPublicIps.delete;
}

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
