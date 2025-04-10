import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * A lab virtual machine resource.
 */
@parentResource(Lab)
model VirtualMachine
  is Azure.ResourceManager.ProxyResource<VirtualMachineProperties, false> {
  ...ResourceNameParameter<
    Resource = VirtualMachine,
    KeyName = "virtualMachineName",
    SegmentName = "virtualMachines",
    NamePattern = "^[-\\w\\\\._\\\\(\\\\)]+$"
  >;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Returns the properties for a lab virtual machine.
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * Returns a list of all virtual machines for a lab.
   */
  listByLab is ArmResourceListByParent<
    VirtualMachine,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedVirtualMachines>
  >;

  /**
   * Action to start a lab virtual machine.
   */
  start is ArmResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Action to stop a lab virtual machine.
   */
  stop is ArmResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Re-image a lab virtual machine. The virtual machine will be deleted and recreated using the latest published snapshot of the reference environment of the lab.
   */
  reimage is ArmResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Action to redeploy a lab virtual machine to a different compute node. For troubleshooting connectivity.
   */
  redeploy is ArmResourceActionAsync<VirtualMachine, void, OkResponse>;

  /**
   * Resets a lab virtual machine password.
   */
  resetPassword is ArmResourceActionAsync<
    VirtualMachine,
    ResetPasswordBody,
    OkResponse
  >;
}

@@maxLength(VirtualMachine.name, 100);
@@minLength(VirtualMachine.name, 1);
@@doc(VirtualMachine.name,
  "The ID of the virtual machine that uniquely identifies it within the containing lab. Used in resource URIs."
);
@@doc(VirtualMachine.properties, "Virtual machine resource properties");
@@doc(VirtualMachines.resetPassword::parameters.body, "The request body.");
