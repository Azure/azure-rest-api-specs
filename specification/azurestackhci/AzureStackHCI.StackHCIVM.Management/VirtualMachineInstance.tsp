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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The virtual machine instance resource definition.")
@singleton("default")
@includeInapplicableMetadataInPayload(false)
model VirtualMachineInstance is ExtensionResource<VirtualMachineInstanceProperties> {
  @doc("name of virtual machine")
  @key("virtualMachineInstance")
  @segment("virtualMachineInstances")
  @visibility("read")
  @path
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
    LroHeaders=ArmAsyncOperationHeader
  >;

  @doc("The operation to update a virtual machine instance.")
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceUpdateRequest,
    LroHeaders=ArmAsyncOperationHeader
  >;

  @doc("The operation to delete a virtual machine instance.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineInstance,
    LroHeaders=ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  @operationId("VirtualMachineInstances_List")
  list is ArmResourceListByParent<VirtualMachineInstance>;

  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request=void,
    LroHeaders=ArmLroLocationHeader
  >;

  @doc("The operation to stop a virtual machine instance.")
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request=void,
    LroHeaders=ArmLroLocationHeader
  >;

  @doc("The operation to restart a virtual machine instance.")
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request=void,
    LroHeaders=ArmLroLocationHeader
  >;

  @doc("The operation to pause a virtual machine instance.")
  pause is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request=void,
    LroHeaders=ArmLroLocationHeader
  >;

  @doc("The operation to save a virtual machine instance.")
  save is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request=void,
    LroHeaders=ArmLroLocationHeader
  >;
}