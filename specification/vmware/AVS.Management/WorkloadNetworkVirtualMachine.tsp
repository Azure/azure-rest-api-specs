import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("NSX Virtual Machine")
@parentResource(PrivateCloud)
model WorkloadNetworkVirtualMachine
  is ProxyResource<WorkloadNetworkVirtualMachineProperties> {
  @doc("Virtual Machine identifier")
  @path
  @key("virtualMachineId")
  @segment("virtualMachines")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
  @doc("Get a virtual machine by id in a private cloud workload network.")
  getVirtualMachine is ArmResourceRead<WorkloadNetworkVirtualMachine>;
  @doc("List of virtual machines in a private cloud workload network.")
  listVirtualMachines is ArmResourceListByParent<WorkloadNetworkVirtualMachine>;
}
