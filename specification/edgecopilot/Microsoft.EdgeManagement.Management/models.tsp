import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EdgeManagement;

/**
 * Type of message. Can only be 'text' or 'action'.
 */
union Type {
  /**
   * Custom type.
   */
  string,

  /**
   * Text message.
   */
  text: "text",

  /**
   * Action message.
   */
  action: "action",
}

/**
 * Sub-type of message.
 */
union Subtype {
  /**
   * Custom sub-type.
   */
  string,

  /**
   * Artifact sub-type.
   */
  artifact: "artifact",

  /**
   * Default sub-type.
   */
  default: "default",
}

/**
 * Role of message. Can be 'system', 'assistant', or 'user'.
 */
union Role {
  /**
   * Custom role.
   */
  string,

  /**
   * System message.
   */
  system: "system",

  /**
   * Assistant message.
   */
  assistant: "assistant",

  /**
   * User message.
   */
  user: "user",
}

/**
 * Chat request schema. Contains input message from user
 */
@renamedFrom(Versions.v2025_06_01_preview, "ChatRequest")
model ChatRequestContent {
  /**
   * Chat context schema. Contains context information of the chat.
   */
  context?: ChatContext;

  /**
   * Session Id of current chat.
   */
  sessionId?: string;

  /**
   * User message schema. Contains input message from user.
   */
  userMessage: ChatMessage;

  /**
   * Language of the portal user setting.
   */
  language?: string;
}

/**
 * Chat context schema. Contains context information of the chat.
 */
model ChatContext {
  /**
   * The blade id of the current blade.
   */
  bladeId: string;

  /**
   * Resource Ids of the chat is referring to.
   */
  resourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * The start time of the issue that needs troubleshoot.
   */
  startTime?: utcDateTime;

  /**
   * The end time of the issue that needs troubleshoot.
   */
  endTime?: utcDateTime;
}

/**
 * Chat message schema. Contains message content from user or assistant.
 */
model ChatMessage {
  /**
   * Type of message. Can only be 'text' or 'action'.
   */
  @encodedName("application/json", "type")
  messageType?: Type = Type.text;

  /**
   * Sub-type of message.
   */
  subType?: Subtype = Subtype.default;

  /**
   * Role of message. Can be 'system', 'assistant', or 'user'.
   */
  role?: Role = Role.user;

  /**
   * Message content from user or assistant.
   */
  content: string;
}

/**
 * Chat response schema. Contains reply messages from chatbot.
 */
model ChatResult {
  /**
   * Session Id of current chat.
   */
  sessionId?: string;

  /**
   * Reply message schema. Contains reply messages from chatbot
   */
  @Azure.ResourceManager.identifiers(#[])
  replyMessages: ChatMessage[];
}
