namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_ListVirtualMachines")
  list is ArmResourceListByParent<
    WorkloadNetworkVirtualMachine,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkVirtualMachine,
      "{name}sList"
    >>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("WorkloadNetworks_GetVirtualMachine")
  get is ArmResourceRead<WorkloadNetworkVirtualMachine>;
}

@doc("NSX Virtual Machine")
@parentResource(WorkloadNetwork)
model WorkloadNetworkVirtualMachine
  is ProxyResource<WorkloadNetworkVirtualMachineProperties> {
  @doc("ID of the virtual machine.")
  @pattern("^[-\\w\\._]+$")
  @key("virtualMachineId")
  @path
  @segment("virtualMachines")
  name: string;
}

@doc("NSX Virtual Machine Properties")
model WorkloadNetworkVirtualMachineProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the VM.")
  displayName?: string;

  @doc("Virtual machine type.")
  @visibility("read")
  vmType?: VMTypeEnum;
}

@doc("VM type")
union VMTypeEnum {
  string,

  @doc("is regular")
  REGULAR: "REGULAR",

  @doc("is edge")
  EDGE: "EDGE",

  @doc("is service")
  SERVICE: "SERVICE",
}
