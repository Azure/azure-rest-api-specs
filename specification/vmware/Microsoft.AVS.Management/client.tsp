import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.AVS;
using TypeSpec.Versioning;

@client(
  {
    name: "AvsClient",
    service: Microsoft.AVS,
  },
  "csharp,java"
)
@client(
  {
    name: "AzureVMwareSolutionAPI",
    service: Microsoft.AVS,
  },
  "javascript"
)
@client(
  {
    name: "AVSClient",
    service: Microsoft.AVS,
  },
  "python"
)
@useDependency(Microsoft.AVS.Versions.v2024_09_01)
namespace Customization;

@operationGroup
@armResourceOperations
interface WorkloadNetworksClient {
  list is Microsoft.AVS.WorkloadNetworks.list;
  get is Microsoft.AVS.WorkloadNetworks.get;

  listDhcp is WorkloadNetworkDhcpConfigurations.list;
  getDhcp is WorkloadNetworkDhcpConfigurations.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDhcp is WorkloadNetworkDhcpConfigurations.create;
  updateDhcp is WorkloadNetworkDhcpConfigurations.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDhcp is WorkloadNetworkDhcpConfigurations.delete;

  listDnsService is WorkloadNetworkDnsServices.list;
  getDnsService is WorkloadNetworkDnsServices.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDnsService is WorkloadNetworkDnsServices.create;
  updateDnsService is WorkloadNetworkDnsServices.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDnsService is WorkloadNetworkDnsServices.delete;

  listDnsZones is WorkloadNetworkDnsZones.list;
  getDnsZone is WorkloadNetworkDnsZones.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createDnsZone is WorkloadNetworkDnsZones.create;
  updateDnsZone is WorkloadNetworkDnsZones.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteDnsZone is WorkloadNetworkDnsZones.delete;

  listGateways is WorkloadNetworkGateways.list;
  getGateway is WorkloadNetworkGateways.get;

  listPortMirroring is WorkloadNetworkPortMirroringProfiles.list;
  getPortMirroring is WorkloadNetworkPortMirroringProfiles.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createPortMirroring is WorkloadNetworkPortMirroringProfiles.create;
  updatePortMirroring is WorkloadNetworkPortMirroringProfiles.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deletePortMirroring is WorkloadNetworkPortMirroringProfiles.delete;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  listPublicIPs is WorkloadNetworkPublicIps.list;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  getPublicIP is WorkloadNetworkPublicIps.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createPublicIP is WorkloadNetworkPublicIps.create;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  deletePublicIP is WorkloadNetworkPublicIps.delete;

  listSegments is WorkloadNetworkSegments.list;
  getSegment is WorkloadNetworkSegments.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createSegment is WorkloadNetworkSegments.create;
  updateSegment is WorkloadNetworkSegments.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  deleteSegment is WorkloadNetworkSegments.deleteSegment;

  listVirtualMachines is WorkloadNetworkVirtualMachines.list;
  getVirtualMachine is WorkloadNetworkVirtualMachines.get;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  listVMGroups is WorkloadNetworkVmGroups.list;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  getVMGroup is WorkloadNetworkVmGroups.get;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createVMGroup is WorkloadNetworkVmGroups.create;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  updateVMGroup is WorkloadNetworkVmGroups.update;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  deleteVMGroup is WorkloadNetworkVmGroups.delete;
}

// operation group per interface

@operationGroup
interface Operations extends Microsoft.AVS.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Locations extends Microsoft.AVS.Locations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PrivateClouds extends Microsoft.AVS.PrivateClouds {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Clusters extends Microsoft.AVS.Clusters {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Datastores extends Microsoft.AVS.Datastores {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface HcxEnterpriseSites extends Microsoft.AVS.HcxEnterpriseSites {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Authorizations extends Microsoft.AVS.Authorizations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface GlobalReachConnections extends Microsoft.AVS.GlobalReachConnections {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface CloudLinks extends Microsoft.AVS.CloudLinks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Addons extends Microsoft.AVS.Addons {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface VirtualMachines extends Microsoft.AVS.VirtualMachines {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface PlacementPolicies extends Microsoft.AVS.PlacementPolicies {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptPackages extends Microsoft.AVS.ScriptPackages {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptCmdlets extends Microsoft.AVS.ScriptCmdlets {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ScriptExecutions extends Microsoft.AVS.ScriptExecutions {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface IscsiPaths extends Microsoft.AVS.IscsiPaths {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Hosts extends Microsoft.AVS.Hosts {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface ProvisionedNetworks extends Microsoft.AVS.ProvisionedNetworks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup
interface Skus extends Microsoft.AVS.Skus {}

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
