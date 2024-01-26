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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VCenter)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(InventoryItemProperties)
model InventoryItem extends ProxyResourceBase {
  /**
   * Name of the inventoryItem.
   */
  @path
  @key("inventoryItemName")
  @segment("inventoryItems")
  @visibility("read")
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
