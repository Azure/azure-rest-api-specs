import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the virtualMachineInstance.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@extensionResource
model VirtualMachineInstance
  is Azure.ResourceManager.ExtensionResource<
    VirtualMachineInstanceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = VirtualMachineInstance,
    KeyName = "virtualMachineInstance",
    SegmentName = "virtualMachineInstances",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineInstancesOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /**
         * The fully qualified Azure Resource manager identifier of the resource.
         */
        @path(#{ allowReserved: true })
        resourceUri: string,
      },
      {},
      {
        ...Extension.ExtensionProviderNamespace<VirtualMachineInstance>,
        ...KeysOf<VirtualMachineInstance>,
      }
    > {}

@armResourceOperations
interface VirtualMachineInstances {
  /**
   * Retrieves information about a virtual machine instance.
   */
  get is ArmResourceRead<
    VirtualMachineInstance,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.
   */
  createOrUpdate is VirtualMachineInstancesOps.CreateOrUpdateAsync<
    VirtualMachineInstance,
    OptionalRequestBody = true
  >;

  /**
   * The operation to update a virtual machine instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is VirtualMachineInstancesOps.CustomPatchAsync<
    VirtualMachineInstance,
    PatchModel = VirtualMachineInstanceUpdate,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = VirtualMachineInstance | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    OptionalRequestBody = true
  >;

  /**
   * The operation to delete a virtual machine instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * Whether to delete the VM from the vCenter.
       */
      @query("deleteFromHost")
      deleteFromHost?: boolean;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all of the virtual machine instances within the specified parent resource.
   */
  list is ArmResourceListByParent<
    VirtualMachineInstance,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Response = ArmResponse<VirtualMachineInstancesList>
  >;

  /**
   * The operation to power off (stop) a virtual machine instance.
   */
  stop is ArmResourceActionAsyncBase<
    VirtualMachineInstance,
    StopVirtualMachineOptions,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    OptionalRequestBody = true
  >;

  /**
   * The operation to start a virtual machine instance.
   */
  start is ArmResourceActionAsyncBase<
    VirtualMachineInstance,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * The operation to restart a virtual machine instance.
   */
  restart is ArmResourceActionAsyncBase<
    VirtualMachineInstance,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;
}

@@doc(VirtualMachineInstance.name, "");
@@doc(VirtualMachineInstance.properties, "Resource properties.");
@@doc(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "Request payload."
);
@@doc(VirtualMachineInstances.update::parameters.properties,
  "Resource properties to update."
);
