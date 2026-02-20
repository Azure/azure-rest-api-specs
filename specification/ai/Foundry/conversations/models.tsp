import "../responses/models.tsp";
// import "../.external-readonly/openai.external.typespec/conversations/custom.tsp";

import "@typespec/http";
import "@typespec/openapi";
import "@typespec/json-schema";

using TypeSpec.Http;
using TypeSpec.JsonSchema;

namespace Azure.AI.Projects;

alias ItemTypeQueryParameter = {
  @query
  @doc("Filter by item type. If provided, only items of the specified type will be returned.")
  item_type?: OpenAI.ItemType;
};

@jsonSchema
model CreateConversationRequest is OpenAI.CreateConversationBody;

@jsonSchema
model UpdateConversationRequest is OpenAI.UpdateConversationBody;

@jsonSchema
model CreateConversationItemsRequest {
  /**
   * Additional fields to include in the response.
   * See the `include` parameter for listing Conversation items for more information.
   */
  @query include?: string[];

  /** The items to add to the conversation. You may add up to 20 items at a time. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @maxItems(20)
  items: (OpenAI.Item | OpenAI.EasyInputMessage)[];
}
