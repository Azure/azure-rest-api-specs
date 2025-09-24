namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface VirtualMachines {
  list is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<ResourceList<VirtualMachine, "{name}sList">>
  >;

  get is ArmResourceRead<VirtualMachine>;

  @doc("Enable or disable DRS-driven VM movement restriction")
  restrictMovement is ArmResourceActionAsyncBase<
    VirtualMachine,
    VirtualMachineRestrictMovement,
    ArmAcceptedLroResponse,
    Foundations.BaseParameters<VirtualMachine>
  >;
}

@@clientName(VirtualMachines.restrictMovement::parameters.body,
  "restrictMovement"
);

@doc("Virtual Machine Restrict Movement state")
union VirtualMachineRestrictMovementState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Virtual Machine")
@parentResource(Cluster)
model VirtualMachine is ProxyResource<VirtualMachineProperties> {
  @doc("ID of the virtual machine.")
  @pattern("^[-\\w\\._]+$")
  @key("virtualMachineId")
  @path
  @segment("virtualMachines")
  name: string;
}

@doc("Virtual Machine provisioning state")
union VirtualMachineProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Virtual Machine Properties")
model VirtualMachineProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: VirtualMachineProvisioningState;

  @doc("Display name of the VM.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("vCenter managed object reference ID of the virtual machine")
  @visibility(Lifecycle.Read)
  moRefId?: string;

  @doc("Path to virtual machine's folder starting from datacenter virtual machine folder")
  @visibility(Lifecycle.Read)
  folderPath?: string;

  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  @visibility(Lifecycle.Read)
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("Set VM DRS-driven movement to restricted (enabled) or not (disabled)")
model VirtualMachineRestrictMovement {
  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  restrictMovement?: VirtualMachineRestrictMovementState;
}
