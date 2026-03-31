import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace WebPubSubChat;

/**
 * Chat operations.
 */
@tag("chat")
interface Chat {
  // --- Conversations ---

  /**
   * Get conversation information.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Get conversation information.")
  @route("/api/hubs/{hub}/chat/conversations/{conversationId}")
  @get
  getConversation is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Conversation identifier.
       */
      @minLength(1)
      @path
      conversationId: string;
    },
    ChatConversationInfo
  >;

  // --- Messages ---

  /**
   * Query messages in a conversation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Query messages in a conversation.")
  @route("/api/hubs/{hub}/chat/conversations/{conversationId}/messages")
  @get
  @list
  queryMessages is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Conversation identifier.
       */
      @minLength(1)
      @path
      conversationId: string;

      /**
       * Last message ID for pagination.
       */
      @query
      lastMessageId?: string;

      /**
       * First message ID for pagination.
       */
      @query
      firstMessageId?: string;

      /**
       * Maximum number of messages to return.
       */
      @query
      @pageSize
      pageSize?: int32;
    },
    QueryChatMessageResponse
  >;

  /**
   * Delete a message.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Delete a message.")
  @route("/api/hubs/{hub}/chat/conversations/{conversationId}/messages/{messageId}")
  @delete
  deleteMessage is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Conversation identifier.
       */
      @minLength(1)
      @path
      conversationId: string;

      /**
       * Message identifier.
       */
      @minLength(1)
      @path
      messageId: string;
    },
    void
  >;

  /**
   * Update a message.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Update a message.")
  @route("/api/hubs/{hub}/chat/conversations/{conversationId}/messages/{messageId}")
  @patch(#{ implicitOptionality: true })
  updateMessage is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Conversation identifier.
       */
      @minLength(1)
      @path
      conversationId: string;

      /**
       * Message identifier.
       */
      @minLength(1)
      @path
      messageId: string;

      /**
       * Update message request body.
       */
      @header("Content-Type")
      contentType: "application/json";

      /**
       * Update message request.
       */
      @bodyRoot
      request: UpdateChatMessageRequest;
    },
    ChatMessageInfo
  >;

  // --- Roles ---

  /**
   * Query roles in a hub.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Name matches original API design - Chat_QueryRoles"
  @summary("Query roles in a hub.")
  @route("/api/hubs/{hub}/chat/roles")
  @get
  @list
  queryRoles is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Continuation token for pagination.
       */
      @query
      @continuationToken
      continuationToken?: string;

      /**
       * Maximum number of roles to return.
       */
      @query
      maxCount?: int32;
    },
    QueryChatRolesResponse
  >;

  /**
   * Get role information.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Get role information.")
  @route("/api/hubs/{hub}/chat/roles/{role}")
  @get
  getRole is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Role name.
       */
      @pattern("^[A-Za-z0-9_.-]{1,64}$")
      @path
      role: string;
    },
    ChatRoleInfo
  >;

  /**
   * Create or update a role.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Create or update a role.")
  @route("/api/hubs/{hub}/chat/roles/{role}")
  @put
  createOrUpdateRole is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Role name.
       */
      @pattern("^[A-Za-z0-9_.-]{1,64}$")
      @path
      role: string;

      /**
       * Create or update role request.
       */
      @bodyRoot
      request: CreateOrUpdateChatRoleInfoRequest;
    },
    void
  >;

  /**
   * Delete a role.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Delete a role.")
  @route("/api/hubs/{hub}/chat/roles/{role}")
  @delete
  deleteRole is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Role name.
       */
      @pattern("^[A-Za-z0-9_.-]{1,64}$")
      @path
      role: string;
    },
    void
  >;

  // --- Rooms ---

  /**
   * Create a new room.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Create a new room.")
  @route("/api/hubs/{hub}/chat/rooms")
  @post
  createRoom is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Create room request.
       */
      @bodyRoot
      request: CreateChatRoomRequest;
    },
    ChatRoomInfo
  >;

  /**
   * Get room information.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Get room information.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}")
  @get
  getRoom is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;
    },
    ChatRoomInfo
  >;

  /**
   * Update room information.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Update room information.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}")
  @patch(#{ implicitOptionality: true })
  updateRoom is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;

      /**
       * Update room request content type.
       */
      @header("Content-Type")
      contentType: "application/json";

      /**
       * Update room request.
       */
      @bodyRoot
      request: UpdateChatRoomRequest;
    },
    ChatRoomInfo
  >;

  /**
   * Delete a room.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Delete a room.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}")
  @delete
  deleteRoom is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;
    },
    void
  >;

  // --- Room Members ---

  /**
   * Get room members.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Get room members.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}/members")
  @get
  getRoomMembers is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;
    },
    ChatRoomMember[]
  >;

  /**
   * Add or update a room member.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Add or update a room member.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}/members/{userId}")
  @put
  addOrUpdateRoomMember is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;

      /**
       * User identifier.
       */
      @minLength(1)
      @path
      userId: string;

      /**
       * Update room member request.
       */
      @bodyRoot
      request: UpdateChatRoomMemberRequest;
    },
    void
  >;

  /**
   * Delete a room member.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Delete a room member.")
  @route("/api/hubs/{hub}/chat/rooms/{roomId}/members/{userId}")
  @delete
  deleteRoomMember is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Room identifier.
       */
      @minLength(1)
      @path
      roomId: string;

      /**
       * User identifier.
       */
      @minLength(1)
      @path
      userId: string;
    },
    void
  >;

  // --- Users ---

  /**
   * Get a user's profile.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Get a user's profile.")
  @route("/api/hubs/{hub}/chat/users/{userId}")
  @get
  getUser is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * User identifier.
       */
      @minLength(1)
      @path
      userId: string;
    },
    ChatUserProfile
  >;

  /**
   * Add or update a user.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Add or update a user.")
  @route("/api/hubs/{hub}/chat/users/{userId}")
  @put
  addOrUpdateUser is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * User identifier.
       */
      @minLength(1)
      @path
      userId: string;

      /**
       * User profile.
       */
      @bodyRoot
      profile: ChatUserProfile;
    },
    void
  >;

  /**
   * Delete a user.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom data-plane operation"
  @summary("Delete a user.")
  @route("/api/hubs/{hub}/chat/users/{userId}")
  @delete
  deleteUser is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * User identifier.
       */
      @minLength(1)
      @path
      userId: string;
    },
    void
  >;
}
