import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;

namespace WebPubSubChat;

/** Chat conversation identifier. */
model ChatConversation {
  /** Conversation identifier. */
  @pattern("^c\\.[A-Za-z0-9_-]{1,64}(?:\\.[A-Za-z0-9_-]{1,64})?$")
  conversationId?: string;

  /** Room identifier. */
  @pattern("^[A-Za-z0-9_-]{1,64}$")
  roomId?: string;

  /** Topic identifier. */
  @pattern("^[A-Za-z0-9_-]{1,64}$")
  topicId?: string;
}

/** Represents conversation information. */
model ChatConversationInfo {
  /** Conversation identifier. */
  conversationId: string;

  /** Parent room identifier. */
  parentRoom: string;
}

/** Chat message information. */
model ChatMessageInfo {
  /** Message identifier. */
  messageId?: string;

  /** User who created the message. */
  createdBy?: string;

  /** Message content. */
  content?: ContentBody;

  /** Timestamp when the message was created. */
  createdAt?: utcDateTime;
}

/**
 * Represents role information.
 * A role must contain either user permissions or room permissions, but not both.
 */
model ChatRoleInfo {
  /** Role name. */
  role: string;

  /** Permissions associated with the role. Do not mix user permissions and room permissions in one role. */
  permissions: string[];
}

/** Represents room information. */
model ChatRoomInfo {
  /** Room identifier. */
  id: string;

  /** Room title. */
  title: string;

  /** Default conversation ID for this room. */
  defaultConversation: string;
}

/** Represents a room member. */
model ChatRoomMember {
  /** User ID of the member. */
  userId: string;

  /** Room role assigned to the user within this room. */
  role: string;
}

/** Represents a user profile in the chat system. */
model ChatUserProfile {
  /** User identifier. */
  id: string;

  /** User's display nickname. */
  nickname: string;

  /** Global user role assigned to the user. */
  role?: string;
}

/** Message content body. */
model ContentBody {
  /** Text content. */
  text?: string;

  /** Binary content (base64 encoded). */
  binary?: bytes;
}

/** Request to create a new room. */
model CreateChatRoomRequest {
  /** Optional room ID. If not provided, one will be generated. */
  id?: string;

  /** Room title. */
  title: string;
}

/** Request to create or update a role. */
model CreateOrUpdateChatRoleInfoRequest {
  /** Permissions associated with the role. Do not mix user permissions and room permissions in one role. */
  permissions: string[];
}

/** Response for querying messages. */
model QueryChatMessageResponse {
  /** List of messages. */
  @pageItems
  messages?: ChatMessageInfo[];

  /** URL to fetch the next page of messages. */
  @nextLink
  nextLink?: url;
}

/** Response for querying roles. */
model QueryChatRolesResponse {
  /** List of roles. */
  @pageItems
  roles: ChatRoleInfo[];

  /** URL to fetch the next page of roles. */
  @nextLink
  nextLink?: url;
}

/**
 * Request to update a message.
 * Contains parts of MessageInfo excluding conversation (which is already known from the URL).
 */
model UpdateChatMessageRequest {
  /** Optional. The user who created the message. */
  createdBy?: string;

  /** Message content. */
  content?: ContentBody;
}

/** Request to update a room member. */
model UpdateChatRoomMemberRequest {
  /** Room role assigned to the user within this room. */
  role: string;
}

/** Request to update a room. */
model UpdateChatRoomRequest {
  /** New room title. */
  title?: string;
}
