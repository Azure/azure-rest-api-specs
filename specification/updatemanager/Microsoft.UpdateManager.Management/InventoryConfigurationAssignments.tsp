import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.UpdateManager;

@doc("Inventory Configuration Assignment resource representing the assignment of an inventory configuration to a VM resource.")
@added(Microsoft.UpdateManager.Versions.v2025_08_01_preview)
@singleton("default")
model InventoryConfigurationAssignment
  is ExtensionResource<InventoryConfigurationAssignmentProperties> {
  @doc("The name of the inventory configuration assignment.")
  @key
  @segment("inventoryConfigurationAssignments")
  @visibility(Lifecycle.Read)
  @path
  @pattern("^default$")
  name: string;
}

@doc("Properties of the InventoryConfigurationAssignment resource.")
@added(Versions.v2025_08_01_preview)
model InventoryConfigurationAssignmentProperties {
  @doc("ARM id of inventory configuration")
  inventoryConfigurationId: string;

  @doc("ARM id of VM resource")
  @visibility(Lifecycle.Read)
  resourceId?: string;

  @doc("Time when this is created")
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  @doc("Enum with status of the assignment.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Error object. Required when the provisioning state is failed.")
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface InventoryConfigurationAssignments {
  get is ArmResourceRead<InventoryConfigurationAssignment>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    InventoryConfigurationAssignment,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<InventoryConfigurationAssignment>;
  list is ArmResourceListByParent<InventoryConfigurationAssignment>;
}
