namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface VirtualMachines {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("VirtualMachines_List")
  list is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<ResourceList<VirtualMachine, "{name}sList">>
  >;

  get is ArmResourceRead<VirtualMachine>;

  // restrictMovement should be a ArmResourceActionNoContentAsync, but does not respond with a 204.
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @doc("Enable or disable DRS-driven VM movement restriction")
  @armResourceAction(Location)
  @post
  @extension("x-ms-long-running-operation", true)
  restrictMovement(
    ...ResourceInstanceParameters<VirtualMachine>,

    @bodyRoot
    @doc("The body type of the operation request.")
    restrictMovement: VirtualMachineRestrictMovement,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

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
  @visibility("read")
  provisioningState?: VirtualMachineProvisioningState;

  @doc("Display name of the VM.")
  @visibility("read")
  displayName?: string;

  @doc("Virtual machine managed object reference id")
  @visibility("read")
  moRefId?: string;

  @doc("Path to virtual machine's folder starting from datacenter virtual machine folder")
  @visibility("read")
  folderPath?: string;

  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  @visibility("read")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("Set VM DRS-driven movement to restricted (enabled) or not (disabled)")
model VirtualMachineRestrictMovement {
  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  restrictMovement?: VirtualMachineRestrictMovementState;
}
