import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RaiBlocklist.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services RaiBlocklist Item.
 */
@parentResource(RaiBlocklist)
model RaiBlocklistItem
  is Azure.ResourceManager.ProxyResource<RaiBlocklistItemProperties> {
  ...ResourceNameParameter<
    Resource = RaiBlocklistItem,
    KeyName = "raiBlocklistItemName",
    SegmentName = "raiBlocklistItems",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface RaiBlocklistItems {
  /**
   * Gets the specified custom blocklist Item associated with the custom blocklist.
   */
  get is ArmResourceRead<RaiBlocklistItem>;

  /**
   * Update the state of specified blocklist item associated with the Azure OpenAI account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<RaiBlocklistItem>;

  /**
   * Deletes the specified blocklist Item associated with the custom blocklist.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RaiBlocklistItem>;

  /**
   * Gets the blocklist items associated with the custom blocklist.
   */
  list is ArmResourceListByParent<
    RaiBlocklistItem,
    Response = ArmResponse<RaiBlockListItemsResult>
  >;
}

@@doc(RaiBlocklistItem.name,
  "The name of the RaiBlocklist Item associated with the custom blocklist"
);
@@encodedName(RaiBlocklistItem.etag, "application/json", "etag");
@@doc(RaiBlocklistItem.properties,
  "Properties of Cognitive Services RaiBlocklist Item."
);
@@doc(RaiBlocklistItems.createOrUpdate::parameters.resource,
  "Properties describing the custom blocklist."
);
