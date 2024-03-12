import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** Define the virtualMachineInstance. */
@singleton
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  /** Name of the virtual machine instance. */
  @key
  @segment("virtualMachineInstances")
  @visibility("read")
  @path
  name: string;

  /** Gets or sets the extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  @visibility("read")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineInstances {
  /** Retrieves information about a virtual machine instance. */
  get is ArmResourceRead<VirtualMachineInstance>;
  /** The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualMachineInstance>;
  /** The operation to update a virtual machine instance. */
  update is ArmResourcePatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceProperties
  >;
  /** The operation to delete a virtual machine instance. */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    {
      ...BaseParameters<VirtualMachineInstance>;
      ...QueryForceDelete;

      /** Whether to disable the VM from azure and also delete it from Vmm. */
      @query("deleteFromHost")
      deleteFromHost?: boolean;
    }
  >;
  /** Lists all of the virtual machine instances within the specified parent resource. */
  listByArm is ArmResourceListByParent<VirtualMachineInstance>;
  /** The operation to power off (stop) a virtual machine instance. */
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    StopVirtualMachineOptions
  >;
  /** The operation to start a virtual machine instance. */
  start is ArmResourceActionNoResponseContentAsync<VirtualMachineInstance, {}>;
  /** The operation to restart a virtual machine instance. */
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void
  >;
  /** Creates a checkpoint in virtual machine instance. */
  createCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineCreateCheckpoint
  >;
  /** Deletes a checkpoint in virtual machine instance. */
  deleteCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineDeleteCheckpoint
  >;
  /** Restores to a checkpoint in virtual machine instance. */
  restoreCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineRestoreCheckpoint
  >;
}
