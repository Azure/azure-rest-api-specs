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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The virtual machine instance resource definition.")
@singleton("default")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  VirtualMachineInstanceProperties
)
model VirtualMachineInstance extends ExtensionResourceBase {
  @doc("name of virtual machine")
  @key("virtualMachineInstance")
  @segment("virtualMachineInstances")
  @visibility("read")
  @path
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;

  @doc("Properties under the virtual machine instance resource")
  @extension("x-ms-client-flatten", true)
  properties?: VirtualMachineInstanceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface VirtualMachineInstances {
  @doc("Gets a virtual machine instance")
  get is ArmResourceRead<VirtualMachineInstance>;

  @doc("The operation to create or update a virtual machine instance. Please note some properties can be set only during virtual machine instance creation.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmAsyncOperationHeader
  >;

  @doc("The operation to update a virtual machine instance.")
  @parameterVisibility("read")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the virtual machine instances within the specified parent resource.")
  @operationId("VirtualMachineInstances_List")
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

  @doc("The operation to pause a virtual machine instance.")
  pause is ArmResourceActionAsync<
    VirtualMachineInstance,
    void,
    VirtualMachineInstance,
    BaseParameters<VirtualMachineInstance>,
    ArmLroLocationHeader
  >;

  @doc("The operation to save a virtual machine instance.")
  save is ArmResourceActionAsync<
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
