import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VmmServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
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

  /** Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  kind?: string;
}

@armResourceOperations
interface InventoryItems {
  /** Shows an inventory item. */
  @summary("Implements GET InventoryItem method.")
  get is ArmResourceRead<InventoryItem>;
  /** Create Or Update InventoryItem. */
  @summary("Implements InventoryItem PUT method.")
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;
  /** Deletes an inventoryItem. */
  @summary("Implements inventoryItem DELETE method.")
  delete is ArmResourceDeleteSync<InventoryItem>;
  /** Returns the list of inventoryItems in the given VmmServer. */
  @summary("Implements GET for the list of Inventory Items in the VMMServer.")
  listByVmmServer is ArmResourceListByParent<InventoryItem>;
}
