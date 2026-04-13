import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

using Azure.Core.Traits;

namespace WebPubSubChat;

alias Operations = Azure.Core.ResourceOperations<Azure.Core.Traits.NoConditionalRequests &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoClientRequestId>;

alias ConditionalOperations = Azure.Core.ResourceOperations<Azure.Core.Traits.SupportsConditionalRequests &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoClientRequestId>;

/**
 * Chat operations.
 */
@tag("chat")
interface Chat {
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

  /** Create a new room with a service-generated ID. */
  @summary("Create a new room.")
  createRoom is Operations.ResourceCreateWithServiceProvidedName<ChatRoom>;

  /** Create or replace a room with a client-specified ID. */
  @summary("Create or replace a room.")
  createOrReplaceRoom is ConditionalOperations.ResourceCreateOrReplace<ChatRoom>;

  /** Get room information. */
  @summary("Get room information.")
  getRoom is Operations.ResourceRead<ChatRoom>;

  /** Delete a room. */
  @summary("Delete a room.")
  deleteRoom is ConditionalOperations.ResourceDelete<ChatRoom>;

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

  /** Get a user's profile. */
  @summary("Get a user's profile.")
  getUser is Operations.ResourceRead<ChatUser>;

  /** Create or replace a user. */
  @summary("Create or replace a user.")
  createOrReplaceUser is ConditionalOperations.ResourceCreateOrReplace<ChatUser>;

  /** Delete a user. */
  @summary("Delete a user.")
  deleteUser is ConditionalOperations.ResourceDelete<ChatUser>;
}
