import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the virtualMachineInstance.")
@singleton("default")
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  @key("default")
  @segment("virtualMachineInstances")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;
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

      @doc("Whether to delete the VM from the vCenter.")
      @query("deleteFromHost")
      deleteFromHost?: boolean;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
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
}
