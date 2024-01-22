import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Defines the inventory item.
 */
@parentResource(VCenter)
model InventoryItem is ProxyResource<InventoryItemProperties> {
  /**
   * Name of the inventoryItem.
   */
  @path
  @key("inventoryItemName")
  @segment("inventoryItems")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface InventoryItems {
  /**
   * Implements InventoryItem GET method.
   */
  get is ArmResourceRead<InventoryItem>;

  /**
   * Create Or Update InventoryItem.
   */
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;

  /**
   * Implements inventoryItem DELETE method.
   */
  delete is ArmResourceDeleteSync<InventoryItem>;

  /**
   * Returns the list of inventoryItems of the given vCenter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InventoryItems_ListByVCenter")
  listByVCenter is ArmResourceListByParent<InventoryItem>;
}

@@projectedName(InventoryItems.create::parameters.resource, "json", "body");
@@extension(InventoryItems.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(InventoryItems.create::parameters.resource, "Request payload.");
