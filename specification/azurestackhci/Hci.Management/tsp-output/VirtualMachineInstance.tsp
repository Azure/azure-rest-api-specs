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

namespace Microsoft.AzureStackHCI;
@doc("The virtual machine instance resource definition.")
@singleton("default")
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  @key("virtualMachineInstance")
  @segment("virtualMachineInstances")
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface VirtualMachineInstances {
  @doc("Gets a virtual machine instance")
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
    VirtualMachineInstanceUpdateRequest,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a virtual machine instance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  list is ArmResourceListByParent<VirtualMachineInstance>;

  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionAsync<
    VirtualMachineInstance,
    void,
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  @doc("The operation to stop a virtual machine instance.")
  stop is ArmResourceActionAsync<
    VirtualMachineInstance,
    void,
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  @doc("The operation to restart a virtual machine instance.")
  restart is ArmResourceActionAsync<
    VirtualMachineInstance,
    void,
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;
}

@@projectedName(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "json",
  "virtualMachineInstance"
);
@@extension(VirtualMachineInstances.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualMachineInstance"
);
@@doc(VirtualMachineInstances.createOrUpdate::parameters.resource, "");
@@projectedName(VirtualMachineInstances.update::parameters.properties,
  "json",
  "virtualMachineInstance"
);
@@extension(VirtualMachineInstances.update::parameters.properties,
  "x-ms-client-name",
  "virtualMachineInstance"
);
@@doc(VirtualMachineInstances.update::parameters.properties, "");
