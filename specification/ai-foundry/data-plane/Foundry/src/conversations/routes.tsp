import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "../common/models.tsp";
import "../responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@route("openai/v1/conversations")
@tag("Conversations")
interface Conversations {
  /**
   * Create a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @operationId("createConversation")
  createConversation is FoundryDataPlaneOperation<
    OpenAI.CreateConversationBody,
    OpenAI.ConversationResource
  >;

  /**
   * Update a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @route("{conversation_id}")
  @post
  @operationId("updateConversation")
  updateConversation is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}")
  @get
  @operationId("getConversation")
  getConversation is FoundryDataPlaneOperation<
    {
      /** The id of the conversation to retrieve. */
      @path conversation_id: string;
    },
    OpenAI.ConversationResource
  >;

  /**
   * Deletes a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}")
  @delete
  @operationId("deleteConversation")
  deleteConversation is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @operationId("listConversations")
  @list
  listConversations is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}/items")
  @post
  @operationId("createConversationItems")
  createConversationItems is FoundryDataPlaneOperation<
    {
      /** The id of the conversation on which the item needs to be created. */
      @path conversation_id: string;

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
    },
    OpenAI.ConversationItemList
  >;

  /**
   * Get a single item from a conversation with the given IDs.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}/items/{item_id}")
  @get
  @operationId("getConversationItem")
  getConversationItem is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}/items/{item_id}")
  @delete
  @operationId("deleteConversationItem")
  deleteConversationItem is FoundryDataPlaneOperation<
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @route("{conversation_id}/items")
  @get
  @operationId("listConversationItems")
  @list
  listConversationItems is FoundryDataPlaneOperation<
    {
      /** The id of the conversation on which the items needs to be listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
      ...ItemTypeQueryParameter;
    },
    AgentsPagedResult<OpenAI.ItemResource>
  >;
}
