import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VCenter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Defines the inventory item.
 */
@parentResource(VCenter)
model InventoryItem
  is Azure.ResourceManager.ProxyResource<InventoryItemProperties, false> {
  ...ResourceNameParameter<
    Resource = InventoryItem,
    KeyName = "inventoryItemName",
    SegmentName = "inventoryItems",
    NamePattern = ""
  >;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface InventoryItemsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
        @path
        @segment("vcenters")
        vcenterName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = InventoryItem,
        KeyName = "inventoryItemName",
        SegmentName = "inventoryItems",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface InventoryItems {
  /**
   * Implements InventoryItem GET method.
   */
  get is ArmResourceRead<InventoryItem>;

  /**
   * Create Or Update InventoryItem.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is InventoryItemsOps.CreateOrUpdateAsync<
    InventoryItem,
    Response = ArmResourceUpdatedResponse<InventoryItem>,
    OptionalRequestBody = true
  >;

  /**
   * Implements inventoryItem DELETE method.
   */
  delete is ArmResourceDeleteSync<InventoryItem>;

  /**
   * Returns the list of inventoryItems of the given vCenter.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByVCenter is ArmResourceListByParent<
    InventoryItem,
    Response = ArmResponse<InventoryItemsList>
  >;
}

@@doc(InventoryItem.name, "Name of the inventoryItem.");
@@doc(InventoryItem.properties, "Resource properties.");
@@doc(InventoryItems.create::parameters.resource, "Request payload.");
