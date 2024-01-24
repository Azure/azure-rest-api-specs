import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VMMServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ScVmm;
/**
 * Defines the inventory item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VMMServer)
@Azure.ResourceManager.Private.armResourceInternal(InventoryItemProperties)
@includeInapplicableMetadataInPayload(false)
model InventoryItem extends ProxyResourceBase {
  /**
   * Name of the inventoryItem.
   */
  @path
  @key("inventoryItemName")
  @segment("inventoryItems")
  name: string;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  kind?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: InventoryItemProperties;
}

@armResourceOperations
interface InventoryItems {
  /**
   * Shows an inventory item.
   */
  get is ArmResourceRead<InventoryItem>;

  /**
   * Create Or Update InventoryItem.
   */
  create is ArmResourceCreateOrReplaceSync<InventoryItem>;

  /**
   * Deletes an inventoryItem.
   */
  delete is ArmResourceDeleteSync<InventoryItem>;

  /**
   * Returns the list of inventoryItems in the given VMMServer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InventoryItems_ListByVMMServer")
  listByVMMServer is ArmResourceListByParent<InventoryItem>;
}

@@projectedName(InventoryItems.create::parameters.resource, "json", "body");
@@extension(InventoryItems.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(InventoryItems.create::parameters.resource, "Request payload.");
