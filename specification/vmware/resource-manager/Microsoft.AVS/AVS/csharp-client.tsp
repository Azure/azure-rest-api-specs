import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;
using TypeSpec.Versioning;

@client(
  {
    name: "AvsClient",
    service: Microsoft.AVS,
  },
  "csharp"
)
@useDependency(Microsoft.AVS.Versions.v2024_09_01)
namespace Customization;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface WorkloadNetworks {
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

  listDnsServices is WorkloadNetworkDnsServices.list;
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
  createSegments is WorkloadNetworkSegments.create;
  updateSegments is WorkloadNetworkSegments.update;
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

@operationGroup("csharp")
interface Operations extends Microsoft.AVS.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Locations extends Microsoft.AVS.Locations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface PrivateClouds extends Microsoft.AVS.PrivateClouds {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Clusters extends Microsoft.AVS.Clusters {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Datastores extends Microsoft.AVS.Datastores {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface HcxEnterpriseSites extends Microsoft.AVS.HcxEnterpriseSites {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Authorizations extends Microsoft.AVS.Authorizations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface GlobalReachConnections extends Microsoft.AVS.GlobalReachConnections {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface CloudLinks extends Microsoft.AVS.CloudLinks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Addons extends Microsoft.AVS.Addons {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface VirtualMachines extends Microsoft.AVS.VirtualMachines {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface PlacementPolicies extends Microsoft.AVS.PlacementPolicies {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface ScriptPackages extends Microsoft.AVS.ScriptPackages {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface ScriptCmdlets extends Microsoft.AVS.ScriptCmdlets {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface ScriptExecutions extends Microsoft.AVS.ScriptExecutions {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface IscsiPaths extends Microsoft.AVS.IscsiPaths {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Hosts extends Microsoft.AVS.Hosts {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface ProvisionedNetworks extends Microsoft.AVS.ProvisionedNetworks {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface Skus extends Microsoft.AVS.Skus {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "operationGroup"
@operationGroup("csharp")
interface PureStoragePolicies extends Microsoft.AVS.PureStoragePolicies {}
