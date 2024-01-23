import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VmmServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** Defines the inventory item. */
@parentResource(VmmServer)
model InventoryItem is ProxyResource<InventoryItemProperties> {
  /** Name of the inventoryItem. */
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @path
  @key("inventoryItemResourceName")
  @segment("inventoryItems")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface InventoryItems {
  /** Shows an inventory item. */
  get is ArmResourceRead<InventoryItem>;
  /** Create Or Update InventoryItem. */
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;
  /** Deletes an inventoryItem. */
  delete is ArmResourceDeleteSync<InventoryItem>;
  /** Returns the list of inventoryItems in the given VmmServer. */
  listByVmmServer is ArmResourceListByParent<InventoryItem>;
}
