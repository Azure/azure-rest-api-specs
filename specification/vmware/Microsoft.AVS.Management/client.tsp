import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.AVS;

@TypeSpec.Versioning.useDependency(Microsoft.AVS.Versions.v2024_09_01)
@client(
  {
    service: Microsoft.AVS,
  },
  "csharp,java,javascript,python"
)
namespace Client {
  @@clientName(Microsoft.AVS, "AzureVMwareSolutionAPI", "javascript");
  @@clientName(Microsoft.AVS, "AVS", "python");

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
}
