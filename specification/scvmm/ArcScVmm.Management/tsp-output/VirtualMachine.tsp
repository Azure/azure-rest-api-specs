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

namespace Microsoft.ScVmm;
/**
 * The VirtualMachines resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(VirtualMachineProperties)
@includeInapplicableMetadataInPayload(false)
model VirtualMachine extends TrackedResourceBase {
  /**
   * Name of the VirtualMachine.
   */
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation: ExtendedLocation;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualMachineProperties;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Implements VirtualMachine GET method.
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * Creates Or Updates virtual machines deployed on scvmm fabric.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the VirtualMachines resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualMachine,
    VirtualMachineUpdate,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a VirtualMachine deployed on ScVmm fabric.
   */
  delete is ArmResourceDeleteAsync<
    VirtualMachine,
    {
      ...BaseParameters<VirtualMachine>;

      /**
       * Whether to just disable the VM from azure and retain the VM in the VMM.
       */
      @query("retain")
      retain?: boolean;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of VirtualMachines in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachines_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;

  /**
   * List of VirtualMachines in a subscription.
   */
  listBySubscription is ArmListBySubscription<VirtualMachine>;

  /**
   * Stop virtual machine.
   */
  stop is ArmResourceActionAsync<
    VirtualMachine,
    StopVirtualMachineOptions,
    void
  >;

  /**
   * Start virtual machine.
   */
  start is ArmResourceActionAsync<VirtualMachine, void, void>;

  /**
   * Restart virtual machine.
   */
  restart is ArmResourceActionAsync<VirtualMachine, void, void>;

  /**
   * Creates a checkpoint in virtual machine.
   */
  createCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineCreateCheckpoint,
    void
  >;

  /**
   * Deletes a checkpoint in virtual machine.
   */
  deleteCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineDeleteCheckpoint,
    void
  >;

  /**
   * Restores to a checkpoint in virtual machine.
   */
  restoreCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineRestoreCheckpoint,
    void
  >;
}

@@projectedName(VirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(VirtualMachines.update::parameters.properties, "json", "body");
@@extension(VirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachines.update::parameters.properties,
  "VirtualMachines patch payload."
);
@@doc(VirtualMachines.stop::parameters.body,
  "Virtualmachine stop action payload."
);
@@doc(VirtualMachines.createCheckpoint::parameters.body,
  "Virtualmachine create checkpoint action payload."
);
@@doc(VirtualMachines.deleteCheckpoint::parameters.body,
  "Virtualmachine delete checkpoint action payload."
);
@@doc(VirtualMachines.restoreCheckpoint::parameters.body,
  "Virtualmachine restore checkpoint action payload."
);
