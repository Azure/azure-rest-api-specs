import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a virtual machine by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetVirtualMachine")
  getVirtualMachine is ArmResourceRead<WorkloadNetworkVirtualMachine>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of virtual machines in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListVirtualMachines")
  listVirtualMachines is ArmResourceListByParent<WorkloadNetworkVirtualMachine>;
}
