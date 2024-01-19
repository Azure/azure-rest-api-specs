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
@doc("Define the virtualMachineInstance.")
@singleton("default")
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  @key("virtualMachineInstance")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a virtual machine instance.")
  update is ArmCustomPatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceUpdate,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
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
    },
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  list is ArmResourceListByParent<VirtualMachineInstance>;

  @doc("The operation to power off (stop) a virtual machine instance.")
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    StopVirtualMachineOptions,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    void,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  @doc("The operation to restart a virtual machine instance.")
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
