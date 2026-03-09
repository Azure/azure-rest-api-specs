import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./thread.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// MESSAGE RESOURCE
// ============================================

/**
 * A message within a thread. Records the conversation history.
 */
@parentResource(Thread)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Messages are read-only projections with no create/update/delete lifecycle, so provisioningState is not applicable."
model MessageProperties {
  /**
   * The ID of the run this message belongs to.
   */
  @visibility(Lifecycle.Read)
  runId?: string;

  /**
   * The type of message (system_message, tool_call, tool_return, assistant_message).
   */
  @visibility(Lifecycle.Read)
  messageType?: MessageType;

  /**
   * The source of the message (system, user, actor, planner, critic).
   */
  @visibility(Lifecycle.Read)
  source?: string;

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
   * Lists messages for a thread.
   */
  listByParent is ArmResourceListByParent<Message>;
}
