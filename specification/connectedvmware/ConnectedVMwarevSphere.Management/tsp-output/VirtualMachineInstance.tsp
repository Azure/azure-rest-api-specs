import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the virtualMachineInstance.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  VirtualMachineInstanceProperties
)
model VirtualMachineInstance extends ExtensionResourceBase {
  @key("virtualMachineInstance")
  @segment("virtualMachineInstances")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualMachineInstanceProperties;
}

@armResourceOperations
interface VirtualMachineInstances {
  /**
   * Retrieves information about a virtual machine instance.
   */
  get is ArmResourceRead<VirtualMachineInstance>;

  /**
   * The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update a virtual machine instance.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceUpdate,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a virtual machine instance.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    {
      ...BaseParameters<VirtualMachineInstance>;

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
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the virtual machine instances within the specified parent resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachineInstances_List")
  list is ArmResourceListByParent<VirtualMachineInstance>;

  /**
   * The operation to power off (stop) a virtual machine instance.
   */
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    StopVirtualMachineOptions,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  /**
   * The operation to start a virtual machine instance.
   */
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  /**
   * The operation to restart a virtual machine instance.
   */
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;
}

@@projectedName(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "Request payload."
);
@@projectedName(VirtualMachineInstances.update::parameters.properties,
  "json",
  "body"
);
@@extension(VirtualMachineInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineInstances.update::parameters.properties,
  "Resource properties to update."
);
@@doc(VirtualMachineInstances.stop::parameters.body,
  "Virtualmachine stop action payload."
);
