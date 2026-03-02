import "../openai-responses/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias ItemTypeQueryParameter = {
  @query
  @doc("Filter by item type. If provided, only items of the specified type will be returned.")
  item_type?: OpenAI.ItemType;
};

model CreateConversationItemsRequest {
  /**
   * Additional fields to include in the response.
   * See the `include` parameter for listing Conversation items for more information.
   */
  @query include?: string[];

  /** The items to add to the conversation. You may add up to 20 items at a time. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @maxItems(20)
  items: OpenAI.Item[];
}
