import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Defines the inventory item.")
@parentResource(VCenter)
model InventoryItem is ProxyResource<InventoryItemProperties> {
  @doc("Name of the inventoryItem.")
  @path
  @key("inventoryItemName")
  @segment("inventoryItems")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface InventoryItems {
  @doc("Implements InventoryItem GET method.")
  get is ArmResourceRead<InventoryItem>;
  @doc("Create Or Update InventoryItem.")
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;
  @doc("Implements inventoryItem DELETE method.")
  delete is ArmResourceDeleteSync<InventoryItem>;
  @doc("Returns the list of inventoryItems of the given vCenter.")
  listByVCenter is ArmResourceListByParent<InventoryItem>;
}
