import "@typespec/openapi";
import "../common/models.tsp";
import "../responses/models.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

/** Create a conversation */
model CreateConversationRequest {
  ...MetadataPropertyForRequest;

  /**
   * Initial items to include the conversation context.
   * You may add up to 20 items at a time.
   */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the Azure OpenAI API."
  items?: (ItemParam | EasyInputMessage)[];
}

/** Update a conversation */
model UpdateConversationRequest {
  ...MetadataPropertyForRequest;
}

model ConversationParam {
  /** The unique ID of the conversation. */
  id: string;
}

model ConversationResource {
  /** The unique ID of the conversation. */
  id: string;

  /** The object type, which is always 'conversation'. */
  object: "conversation";

  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  ...MetadataPropertyForResponse;
}

model DeletedConversationResource {
  object: "conversation.deleted";
  deleted: boolean;
  id: string;
}

model ConversationItemList {
  object: "list";
  data: ItemResource[];
  has_more: boolean;
  first_id: string;
  last_id: string;
}
