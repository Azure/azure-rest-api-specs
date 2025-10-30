import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "./models.tsp";
import "../responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@route("openai/conversations")
@tag("Conversations")
interface Conversations {
  /**
   * Create a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @post
  @operationId("createConversation")
  createConversation is AgentOperation<
    OpenAI.CreateConversationRequest,
    OpenAI.ConversationResource
  >;

  /**
   * Update a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @route("{conversation_id}")
  @post
  @operationId("updateConversation")
  updateConversation is AgentOperation<
    {
      /** The id of the conversation to update. */
      @path conversation_id: string;

      ...OpenAI.UpdateConversationRequest;
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
  getConversation is AgentOperation<
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
  deleteConversation is AgentOperation<
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
  listConversations is AgentOperation<
    {
      ...OpenAI.CommonPageQueryParameters;
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
  createConversationItems is AgentOperation<
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
      @maxItems(20)
      items: (OpenAI.ItemParam | OpenAI.EasyInputMessage)[];
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
  getConversationItem is AgentOperation<
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
  deleteConversationItem is AgentOperation<
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
  listConversationItems is AgentOperation<
    {
      /** The id of the conversation on which the items needs to be listed. */
      @path conversation_id: string;

      ...OpenAI.CommonPageQueryParameters;
      ...ItemTypeQueryParameter;
    },
    AgentsPagedResult<OpenAI.ItemResource>
  >;
}
