namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface VirtualMachines {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("VirtualMachines_List")
  list is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<ResourceList<VirtualMachine, "{name}sList">>
  >;

  get is ArmResourceRead<VirtualMachine>;

  // restrictMovement should be a ArmResourceActionNoContentAsync, but does not respond with a 204.
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
