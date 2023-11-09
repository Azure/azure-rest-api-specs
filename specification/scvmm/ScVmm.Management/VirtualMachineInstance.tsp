import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
@doc("Define the virtualMachineInstance.")
@singleton("default")
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  @key("default")
  @segment("virtualMachineInstances")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineInstances {
  @doc("Retrieves information about a virtual machine instance.")
  get is ArmResourceRead<VirtualMachineInstance>;
  @doc("The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VirtualMachineInstance>;
  @doc("The operation to update a virtual machine instance.")
  update is ArmResourcePatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceProperties
  >;
  @doc("The operation to delete a virtual machine instance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    {
      ...BaseParameters<VirtualMachineInstance>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: Force;

      @doc("Whether to disable the VM from azure and also delete it from VMM.")
      @query("deleteFromHost")
      deleteFromHost?: DeleteFromHost;
    }
  >;
  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  listByArm is ArmResourceListByParent<VirtualMachineInstance>;
  @doc("The operation to power off (stop) a virtual machine instance.")
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    StopVirtualMachineOptions
  >;
  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionNoResponseContentAsync<VirtualMachineInstance, {}>;
  @doc("The operation to restart a virtual machine instance.")
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    {}
  >;
  @doc("Creates a checkpoint in virtual machine instance.")
  createCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineCreateCheckpoint
  >;
  @doc("Deletes a checkpoint in virtual machine instance.")
  deleteCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineDeleteCheckpoint
  >;
  @doc("Restores to a checkpoint in virtual machine instance.")
  restoreCheckpoint is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    VirtualMachineRestoreCheckpoint
  >;
}
