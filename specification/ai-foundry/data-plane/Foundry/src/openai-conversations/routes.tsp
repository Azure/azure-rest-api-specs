import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "../common/models.tsp";
import "../openai-responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@route("openai/v1/conversations")
@tag("Conversations")
interface Conversations {
  /**
   * Create a conversation.
   */
  @post
  @operationId("createConversation")
  createConversation is OpenAIOperation<
    OpenAI.CreateConversationBody,
    OpenAI.ConversationResource
  >;

  /**
   * Update a conversation.
   */
  @route("{conversation_id}")
  @post
  @operationId("updateConversation")
  updateConversation is OpenAIOperation<
    {
      /** The id of the conversation to update. */
      @path conversation_id: string;

      ...OpenAI.UpdateConversationBody;
    },
    OpenAI.ConversationResource
  >;

  /**
   * Retrieves a conversation.
   */
  @route("{conversation_id}")
  @get
  @operationId("getConversation")
  getConversation is OpenAIOperation<
    {
      /** The id of the conversation to retrieve. */
      @path conversation_id: string;
    },
    OpenAI.ConversationResource
  >;

  /**
   * Deletes a conversation.
   */
  @route("{conversation_id}")
  @delete
  @operationId("deleteConversation")
  deleteConversation is OpenAIOperation<
    {
      /** The id of the conversation to delete. */
      @path conversation_id: string;
    },
    OpenAI.DeletedConversationResource
  >;

  // Development note: the following listConversations operation is currently Foundry-specific.
  // It does not exist in the upstream OpenAI API as of 2025-09-23.

  /**
   * Returns the list of all conversations.
   */
  @get
  @operationId("listConversations")
  @list
  listConversations is OpenAIOperation<
    {
      ...CommonPageQueryParameters;
      ...AgentNameQueryParam;
      ...AgentIdQueryParam;
    },
    AgentsPagedResult<OpenAI.ConversationResource>
  >;

  /**
   * Create items in a conversation with the given ID.
   */
  @route("{conversation_id}/items")
  @post
  @operationId("createConversationItems")
  createConversationItems is OpenAIOperation<
    {
      /** The id of the conversation on which the item needs to be created. */
      @path conversation_id: string;

      /**
       * Additional fields to include in the response.
       * See the `include` parameter for listing Conversation items for more information.
       */
      @query include?: string[];

      /** The items to add to the conversation. You may add up to 20 items at a time. */
      #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
      @maxItems(20)
      items: OpenAI.Item[];
    },
    OpenAI.ConversationItemList
  >;

  /**
   * Get a single item from a conversation with the given IDs.
   */
  @route("{conversation_id}/items/{item_id}")
  @get
  @operationId("getConversationItem")
  getConversationItem is OpenAIOperation<
    {
      /** The ID of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item to retrieve. */
      @path item_id: string;
    },
    OpenAI.ItemResource
  >;

  /**
   * Delete an item from a conversation with the given IDs.
   */
  @route("{conversation_id}/items/{item_id}")
  @delete
  @operationId("deleteConversationItem")
  deleteConversationItem is OpenAIOperation<
    {
      /** The id of the conversation on which the item needs to be deleted from. */
      @path conversation_id: string;

      /** The id of the conversation item to delete. */
      @path item_id: string;
    },
    OpenAI.ConversationResource
  >;

  /**
   * List all items for a conversation with the given ID.
   */
  @route("{conversation_id}/items")
  @get
  @operationId("listConversationItems")
  @list
  listConversationItems is OpenAIOperation<
    {
      /** The id of the conversation on which the items needs to be listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
      ...ItemTypeQueryParameter;
    },
    AgentsPagedResult<OpenAI.ItemResource>
  >;
}
