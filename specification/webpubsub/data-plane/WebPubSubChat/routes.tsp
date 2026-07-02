import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace WebPubSubChat;

/** Conditional request headers supported by the service. */
model EtagConditionalRequestHeaders {
  /** The request should only proceed if an entity matches this string. */
  @header("If-Match")
  ifMatch?: string;

  /** The request should only proceed if no entity matches this string. */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** Provides ETag conditional request headers and ETag response headers. */
model EtagConditionalRequestProperties {
  /** ETag conditional request headers. */
  @traitContext(

      | TraitContext.Read
      | TraitContext.Update
      | TraitContext.Delete
      | TraitContext.Create
  )
  @traitLocation(TraitLocation.Parameters)
  parameters: EtagConditionalRequestHeaders;

  /** ETag response headers. */
  @traitContext(TraitContext.Read | TraitContext.Create | TraitContext.Update)
  @traitLocation(TraitLocation.Response)
  response: Azure.Core.EtagResponseEnvelope;
}

/** Provides ETag conditional request headers and ETag response headers. */
@trait("ConditionalRequests")
model SupportsEtagConditionalRequests {
  /** ETag conditional request and response headers. */
  conditionalRequests: EtagConditionalRequestProperties;
}

alias Operations = Azure.Core.ResourceOperations<NoConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId>;

alias ConditionalOperations = Azure.Core.ResourceOperations<SupportsEtagConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId>;

@tag("chat")
interface WebPubSubChatServiceClient {
  // --- Conversations ---

  /** Get conversation information. */
  @summary("Get conversation information.")
  getConversation is Operations.ResourceRead<ChatConversation>;

  // --- Messages ---

  /** Query messages in a conversation from latest to earliest. */
  @summary("Query messages in a conversation from latest to earliest.")
  listMessages is Operations.ResourceList<
    ChatMessage,
    ListQueryParametersTrait<{
      /** Latest message ID (exclusive) for pagination. */
      @query
      @pattern("^\\d+$")
      @minLength(1)
      @maxLength(128)
      latestMessageId?: string;

      /** Earliest message ID (exclusive) for pagination. */
      @query
      @pattern("^\\d+$")
      @minLength(1)
      @maxLength(128)
      earliestMessageId?: string;

      ...MaxPageSizeQueryParameter;
    }>
  >;

  /** Delete a message. */
  @summary("Delete a message.")
  deleteMessage is ConditionalOperations.ResourceDelete<ChatMessage>;

  /** Update a message. */
  @summary("Update a message.")
  updateMessage is ConditionalOperations.ResourceUpdate<ChatMessage>;

  // --- Roles ---

  /** Query roles in a hub. */
  @summary("Query roles in a hub.")
  listRoles is Operations.ResourceList<
    ChatRole,
    ListQueryParametersTrait<{
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }>
  >;

  /** Get role information. */
  @summary("Get role information.")
  getRole is Operations.ResourceRead<ChatRole>;

  /** Create or replace a role. */
  @summary("Create or replace a role.")
  createOrReplaceRole is ConditionalOperations.ResourceCreateOrReplace<ChatRole>;

  /** Delete a role. */
  @summary("Delete a role.")
  deleteRole is ConditionalOperations.ResourceDelete<ChatRole>;

  // --- Rooms ---

  /** List rooms with pagination. */
  @added(Versions.v2026_08_01_preview)
  @summary("List rooms with pagination.")
  listRooms is Operations.ResourceList<
    ChatRoom,
    ListQueryParametersTrait<{
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }>
  >;

  /** Create or replace a room with a client-specified ID. */
  @summary("Create or replace a room.")
  createOrReplaceRoom is ConditionalOperations.ResourceCreateOrReplace<ChatRoom>;

  /** Get room information. */
  @summary("Get room information.")
  getRoom is Operations.ResourceRead<ChatRoom>;

  /** Delete a room. */
  @summary("Delete a room.")
  deleteRoom is ConditionalOperations.ResourceDelete<ChatRoom>;

  // --- Topics ---

  /** List topics in a room with pagination. */
  @added(Versions.v2026_08_01_preview)
  @summary("List topics in a room with pagination.")
  listTopics is Operations.ResourceList<
    ChatTopic,
    ListQueryParametersTrait<{
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }>
  >;

  /** Create or replace a topic with a client-specified ID. */
  @added(Versions.v2026_08_01_preview)
  @summary("Create or replace a topic.")
  createOrReplaceTopic is ConditionalOperations.ResourceCreateOrReplace<ChatTopic>;

  /** Get topic information. */
  @added(Versions.v2026_08_01_preview)
  @summary("Get topic information.")
  getTopic is Operations.ResourceRead<ChatTopic>;

  /** Update a topic. */
  @added(Versions.v2026_08_01_preview)
  @summary("Update a topic.")
  updateTopic is ConditionalOperations.ResourceUpdate<ChatTopic>;

  /** Soft delete a topic. */
  @added(Versions.v2026_08_01_preview)
  @summary("Soft delete a topic.")
  deleteTopic is ConditionalOperations.ResourceDelete<ChatTopic>;

  // --- Room Members ---

  /** Get room members. */
  @summary("Get room members.")
  listRoomMembers is Operations.ResourceList<
    ChatRoomMember,
    ListQueryParametersTrait<{
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }>
  >;

  /** Create or replace a room member. */
  @summary("Create or replace a room member.")
  createOrReplaceRoomMember is ConditionalOperations.ResourceCreateOrReplace<ChatRoomMember>;

  /** Delete a room member. */
  @summary("Delete a room member.")
  deleteRoomMember is ConditionalOperations.ResourceDelete<ChatRoomMember>;

  // --- Users ---

  /** List all users with pagination. */
  @added(Versions.v2026_08_01_preview)
  @summary("List all users with pagination.")
  listUsers is Operations.ResourceList<
    ChatUser,
    ListQueryParametersTrait<{
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }>
  >;

  /** Get a user's profile. The response is a polymorphic `ChatUser` (e.g. `HumanChatUser`) selected by the `kind` discriminator. */
  @summary("Get a user's profile.")
  getUser is Operations.ResourceRead<ChatUser>;

  /** Create or replace a user. The request body is a polymorphic `ChatUser` (e.g. `HumanChatUser`) selected by the `kind` discriminator. */
  @summary("Create or replace a user.")
  createOrReplaceUser is ConditionalOperations.ResourceCreateOrReplace<ChatUser>;

  /** Delete a user. */
  @summary("Delete a user.")
  deleteUser is ConditionalOperations.ResourceDelete<ChatUser>;

  /** List rooms for a user with pagination. */
  @added(Versions.v2026_08_01_preview)
  @summary("List rooms for a user with pagination.")
  @listsResource(ChatUserRoom)
  listRoomsForUser is Operations.ResourceList<
    ChatUserRoom,
    {
      /** Maximum number of items to include in a page. */
      ...MaxPageSizeQueryParameter;

      /** Continuation token for pagination. */
      @query
      @continuationToken
      @minLength(1)
      continuationToken?: string;
    }
  >;
}
