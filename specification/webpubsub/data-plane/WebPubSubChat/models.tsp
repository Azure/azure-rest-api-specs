import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.Core;

namespace WebPubSubChat;

/** Represents a hub (virtual parent resource for URL routing). */
@resource("api/hubs")
model Hub {
  /** Target hub name, which should start with alphabetic characters and only contain alpha-numeric characters or underscore. */
  @key("hub")
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
  @minLength(1)
  @maxLength(128)
  @clientName("hubName", "csharp")
  hub: string;
}

/** Represents a chat conversation. */
@resource("chat/conversations")
@parentResource(Hub)
model ChatConversation {
  /** Conversation identifier. */
  @key("conversationId")
  @visibility(Lifecycle.Read)
  @pattern("^c\\.[A-Za-z0-9_-]{1,64}\\.[A-Za-z0-9_-]{1,64}$")
  @minLength(1)
  @maxLength(131)
  id: string;

  /** Parent room identifier. */
  parentRoom: string;

  ...EtagProperty;
}

/** Represents a chat message. */
@resource("messages")
@parentResource(ChatConversation)
model ChatMessage {
  /** Message identifier. */
  @key("messageId")
  @visibility(Lifecycle.Read)
  @pattern("^\\d+$")
  @minLength(1)
  @maxLength(128)
  id: string;

  /** User who created the message. */
  @pattern("^[^\\p{Cc}\\/\\\\#\\?:;]{1,64}$")
  @minLength(1)
  @maxLength(64)
  createdBy: string;

  /** Message content. */
  content: MessageContent;

  /** Timestamp when the message was created. */
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  ...EtagProperty;
}

/**
 * Represents a chat role.
 * A role name must start with 'user.' or 'room.' prefix.
 * A role must contain either user permissions or room permissions, but not both.
 */
@resource("chat/roles")
@parentResource(Hub)
model ChatRole {
  /** Role name. Must start with 'user.' or 'room.' prefix. */
  @key("roleName")
  @visibility(Lifecycle.Read)
  @pattern("^(?:room|user)\\.[a-z0-9_-]{1,59}$")
  @minLength(1)
  @maxLength(64)
  name: string;

  /** Permissions associated with the role. Do not mix user permissions and room permissions in one role. */
  permissions: string[];

  ...EtagProperty;
}

/** Represents a chat room. */
@resource("chat/rooms")
@parentResource(Hub)
model ChatRoom {
  /** Room identifier. */
  @key("roomId")
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9_-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  id: string;

  /** Room title. */
  title: string;

  /** Default conversation ID for this room. */
  @visibility(Lifecycle.Read)
  defaultConversation: string;

  ...EtagProperty;
}

/** Represents a room member. */
@resource("members")
@parentResource(ChatRoom)
model ChatRoomMember {
  /** User ID of the member. */
  @key("userId")
  @visibility(Lifecycle.Read)
  @pattern("^[^\\p{Cc}\\/\\\\#\\?:;]{1,64}$")
  @minLength(1)
  @maxLength(64)
  userId: string;

  /** Room role assigned to the user within this room. */
  @pattern("^room\\.[a-z0-9_-]{1,59}$")
  @minLength(1)
  @maxLength(64)
  roleName: string;

  ...EtagProperty;
}

/** Represents a user profile in the chat system. */
@resource("chat/users")
@parentResource(Hub)
model ChatUser {
  /** User identifier. */
  @key("userId")
  @visibility(Lifecycle.Read)
  @pattern("^[^\\p{Cc}\\/\\\\#\\?:;]{1,64}$")
  @minLength(1)
  @maxLength(64)
  id: string;

  /** User's display nickname. */
  @pattern("^[^\\p{Cc}]{1,64}$")
  @minLength(1)
  @maxLength(64)
  nickname: string;

  /** Global user role assigned to the user. */
  @pattern("^user\\.[a-z0-9_-]{1,59}$")
  @minLength(1)
  @maxLength(64)
  roleName: string;

  ...EtagProperty;
}

/** Message content body. */
model MessageContent {
  /** Text content. */
  text?: string;

  /** Binary content (base64 encoded). */
  binary?: bytes;
}
