import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./threadRun.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// MESSAGE RESOURCE
// ============================================

/**
 * A message within a thread run. Records the conversation history.
 */
@parentResource(ThreadRun)
model Message is ProxyResource<MessageProperties> {
  /**
   * The unique identifier of the message.
   */
  @key("messageId")
  @segment("messages")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

/**
 * Properties of a Message resource.
 */
model MessageProperties {
  /**
   * The type of message (system_message, tool_call, tool_return, assistant_message).
   */
  @visibility(Lifecycle.Read)
  messageType?: MessageType;

  /**
   * The source of the message (system, user, actor, planner, critic).
   */
  @visibility(Lifecycle.Read)
  source?: MessageSource;

  /**
   * The content of the message. For tool_call/tool_return messages, this may contain JSON.
   */
  @visibility(Lifecycle.Read)
  content?: string;

  /**
   * The timestamp when the message was created.
   */
  @visibility(Lifecycle.Read)
  timestamp?: utcDateTime;
}

// ============================================
// MESSAGE OPERATIONS
// ============================================

@armResourceOperations
interface Messages {
  /**
   * Gets a message by ID.
   */
  get is ArmResourceRead<Message>;

  /**
   * Lists messages for a thread run.
   */
  listByParent is ArmResourceListByParent<Message>;
}
