import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("The virtual machine instance resource definition.")
@extension("x-ms-azure-resource", true)
@singleton("default")
model VirtualMachineInstance
  is ExtensionResource<VirtualMachineInstanceProperties> {
  @doc("name of virtual machine")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @key("virtualMachineInstance")
  @segment("virtualMachineInstances")
  @visibility("read")
  @path
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface VirtualMachineInstances {
  @doc("Gets a virtual machine instance")
  get is ArmResourceRead<VirtualMachineInstance>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachineInstance,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a virtual machine instance.")
  @parameterVisibility
  update is ArmCustomPatchAsync<
    VirtualMachineInstance,
    VirtualMachineInstanceUpdateRequest
  >;

  @doc("The operation to delete a virtual machine instance.")
  delete is ArmResourceDeleteWithoutOkAsync<VirtualMachineInstance>;

  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  list is ArmResourceListByParent<VirtualMachineInstance>;

  @doc("The operation to start a virtual machine instance.")
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request = void
  >;

  @doc("The operation to stop a virtual machine instance.")
  stop is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request = void
  >;

  @doc("The operation to restart a virtual machine instance.")
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request = void
  >;

  @doc("The operation to pause a virtual machine instance.")
  pause is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request = void
  >;

  @doc("The operation to save a virtual machine instance.")
  save is ArmResourceActionNoResponseContentAsync<
    VirtualMachineInstance,
    Request = void
  >;
}
