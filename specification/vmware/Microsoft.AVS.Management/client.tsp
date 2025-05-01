import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AVS;

@TypeSpec.Versioning.useDependency(Versions.v2024_09_01)
@client(
  {
    name: "WorkloadNetworksClient",
    service: Microsoft.AVS,
  },
  "csharp,go,java,javascript,python"
)
namespace Customizations;

@@clientName(Microsoft.AVS, "AzureVMwareSolutionAPI", "javascript");
@@clientName(Microsoft.AVS, "AVS", "python");

interface WorkloadNetworksClient {
  list is Microsoft.AVS.WorkloadNetworks.list;
  get is Microsoft.AVS.WorkloadNetworks.get;

  listDhcp is WorkloadNetworkDhcpConfigurations.list;
  getDhcp is WorkloadNetworkDhcpConfigurations.get;
  createDhcp is WorkloadNetworkDhcpConfigurations.create;
  updateDhcp is WorkloadNetworkDhcpConfigurations.update;
  deleteDhcp is WorkloadNetworkDhcpConfigurations.delete;

  listDnsService is WorkloadNetworkDnsServices.list;
  getDnsService is WorkloadNetworkDnsServices.get;
  createDnsService is WorkloadNetworkDnsServices.create;
  updateDnsService is WorkloadNetworkDnsServices.update;
  deleteDnsService is WorkloadNetworkDnsServices.delete;

  listDnsZones is WorkloadNetworkDnsZones.list;
  getDnsZone is WorkloadNetworkDnsZones.get;
  createDnsZone is WorkloadNetworkDnsZones.create;
  updateDnsZone is WorkloadNetworkDnsZones.update;
  deleteDnsZone is WorkloadNetworkDnsZones.delete;

  listGateways is WorkloadNetworkGateways.list;
  getGateway is WorkloadNetworkGateways.get;

  listPortMirroring is WorkloadNetworkPortMirroringProfiles.list;
  getPortMirroring is WorkloadNetworkPortMirroringProfiles.get;
  createPortMirroring is WorkloadNetworkPortMirroringProfiles.create;
  updatePortMirroring is WorkloadNetworkPortMirroringProfiles.update;
  deletePortMirroring is WorkloadNetworkPortMirroringProfiles.delete;

  listPublicIPs is WorkloadNetworkPublicIps.list;
  getPublicIP is WorkloadNetworkPublicIps.get;
  createPublicIP is WorkloadNetworkPublicIps.create;
  deletePublicIP is WorkloadNetworkPublicIps.delete;

  listSegments is WorkloadNetworkSegments.list;
  getSegment is WorkloadNetworkSegments.get;
  createSegment is WorkloadNetworkSegments.create;
  updateSegment is WorkloadNetworkSegments.update;
  deleteSegment is WorkloadNetworkSegments.deleteSegment;

  listVirtualMachines is WorkloadNetworkVirtualMachines.list;
  getVirtualMachine is WorkloadNetworkVirtualMachines.get;

  listVMGropus is WorkloadNetworkVmGroups.list;
  getVMGroup is WorkloadNetworkVmGroups.get;
  createVMGroup is WorkloadNetworkVmGroups.create;
  updateVMGroup is WorkloadNetworkVmGroups.update;
  deleteVMGroup is WorkloadNetworkVmGroups.delete;
}
