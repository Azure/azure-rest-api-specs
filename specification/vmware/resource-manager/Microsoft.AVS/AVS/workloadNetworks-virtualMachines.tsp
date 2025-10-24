namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
  list is ArmResourceListByParent<
    WorkloadNetworkVirtualMachine,
    Response = ArmResponse<ResourceList<
      WorkloadNetworkVirtualMachine,
      "{name}sList"
    >>
  >;

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
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the VM.")
  displayName?: string;

  @doc("Virtual machine type.")
  @visibility(Lifecycle.Read)
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
