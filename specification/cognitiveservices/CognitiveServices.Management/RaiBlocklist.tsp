import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services RaiBlocklist.
 */
@parentResource(Account)
model RaiBlocklist
  is Azure.ResourceManager.ProxyResource<RaiBlocklistProperties> {
  ...ResourceNameParameter<
    Resource = RaiBlocklist,
    KeyName = "raiBlocklistName",
    SegmentName = "raiBlocklists",
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
interface RaiBlocklists {
  /**
   * Gets the specified custom blocklist associated with the Azure OpenAI account.
   */
  get is ArmResourceRead<RaiBlocklist>;

  /**
   * Update the state of specified blocklist associated with the Azure OpenAI account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<RaiBlocklist>;

  /**
   * Deletes the specified custom blocklist associated with the Azure OpenAI account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<RaiBlocklist>;

  /**
   * Gets the custom blocklists associated with the Azure OpenAI account.
   */
  list is ArmResourceListByParent<RaiBlocklist, Response = RaiBlockListResult>;

  /**
   * Batch operation to add blocklist items.
   */
  @action("addRaiBlocklistItems")
  batchAdd is ArmResourceActionSync<
    RaiBlocklist,
    RaiBlocklistItemsBulkAddRequest,
    ArmResponse<RaiBlocklist>
  >;

  /**
   * Batch operation to delete blocklist items.
   */
  @action("deleteRaiBlocklistItems")
  batchDelete is ArmResourceActionSync<
    RaiBlocklist,
    RaiBlocklistItemsBulkDeleteRequest,
    NoContentResponse
  >;
}
@@doc(RaiBlocklist.name,
  "The name of the RaiBlocklist associated with the Cognitive Services Account"
);
@@encodedName(RaiBlocklist.etag, "application/json", "etag");
@@doc(RaiBlocklist.properties,
  "Properties of Cognitive Services RaiBlocklist."
);
@@doc(RaiBlocklists.createOrUpdate::parameters.resource,
  "Properties describing the custom blocklist."
);
@@doc(RaiBlocklists.batchAdd::parameters.body,
  "Properties describing the custom blocklist items."
);
@@doc(RaiBlocklists.batchDelete::parameters.body,
  "List of RAI Blocklist Items Names."
);
