import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ScVmmServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("Defines the inventory item.")
@parentResource(ScVmmServer)
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
  @doc("Shows an inventory item.")
  get is ArmResourceRead<InventoryItem>;
  @doc("Create Or Update InventoryItem.")
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;
  @doc("Deletes an inventoryItem.")
  delete is ArmResourceDeleteSync<InventoryItem>;
  @doc("Returns the list of inventoryItems in the given VMMServer.")
  listByVMMServer is ArmResourceListByParent<InventoryItem>;
}
