import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * A lab virtual machine resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal(VirtualMachineProperties)
@includeInapplicableMetadataInPayload(false)
model VirtualMachine extends ProxyResourceBase {
  /**
   * The ID of the virtual machine that uniquely identifies it within the containing lab. Used in resource URIs.
   */
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;

  /**
   * Virtual machine resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualMachineProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachines_ListByLab")
  listByLab is ArmResourceListByParent<
    VirtualMachine,
    {
      ...BaseParameters<VirtualMachine>;

      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Action to start a lab virtual machine.
   */
  start is ArmResourceActionAsync<
    VirtualMachine,
    void,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Action to stop a lab virtual machine.
   */
  stop is ArmResourceActionAsync<
    VirtualMachine,
    void,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Re-image a lab virtual machine. The virtual machine will be deleted and recreated using the latest published snapshot of the reference environment of the lab.
   */
  reimage is ArmResourceActionAsync<
    VirtualMachine,
    void,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Action to redeploy a lab virtual machine to a different compute node. For troubleshooting connectivity.
   */
  redeploy is ArmResourceActionAsync<
    VirtualMachine,
    void,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  /**
   * Resets a lab virtual machine password.
   */
  resetPassword is ArmResourceActionAsync<
    VirtualMachine,
    ResetPasswordBody,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;
}

@@doc(VirtualMachines.resetPassword::parameters.body, "The request body.");
