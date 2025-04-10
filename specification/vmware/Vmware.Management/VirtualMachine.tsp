import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * Virtual Machine
 */
@parentResource(Cluster)
model VirtualMachine
  is Azure.ResourceManager.ProxyResource<VirtualMachineProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachine,
    KeyName = "virtualMachineId",
    SegmentName = "virtualMachines",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get a VirtualMachine
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * List VirtualMachine resources by Cluster
   */
  list is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<VirtualMachinesList>
  >;

  /**
   * Enable or disable DRS-driven VM movement restriction
   */
  restrictMovement is ArmResourceActionAsyncBase<
    VirtualMachine,
    VirtualMachineRestrictMovement,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>
  >;
}

@@doc(VirtualMachine.name, "ID of the virtual machine.");
@@doc(VirtualMachine.properties,
  "The resource-specific properties for this resource."
);
@@doc(VirtualMachines.restrictMovement::parameters.body,
  "The body type of the operation request."
);
