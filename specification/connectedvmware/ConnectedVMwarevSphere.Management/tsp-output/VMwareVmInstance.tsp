import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Define the virtualMachineInstance.")
@singleton("default")
model VMwareVmInstance is ExtensionResource<VirtualMachineInstanceProperties> {
  @key("default")
  @segment("virtualMachineInstances")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
interface VMwareVmInstances {
  @doc("Retrieves information about a virtual machine instance.")
  get is ArmResourceRead<VMwareVmInstance>;
  @doc("The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<VMwareVmInstance>;
  @doc("The operation to update a virtual machine instance.")
  update is ArmResourcePatchAsync<
    VMwareVmInstance,
    VirtualMachineInstanceProperties
  >;
  @doc("The operation to delete a virtual machine instance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VMwareVmInstance,
    {
      ...BaseParameters<VMwareVmInstance>;

      @doc("Whether to delete the VM from the vCenter.")
      @query("deleteFromHost")
      deleteFromHost?: boolean;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  listByArm is ArmResourceListByParent<VMwareVmInstance>;
  @doc("The operation to power off (stop) a virtual machine instance.")
  stop is ArmResourceActionNoResponseContentAsync<
    VMwareVmInstance,
    StopVirtualMachineOptions
  >;
  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionNoResponseContentAsync<VMwareVmInstance, {}>;
  @doc("The operation to restart a virtual machine instance.")
  restart is ArmResourceActionNoResponseContentAsync<VMwareVmInstance, {}>;
}
