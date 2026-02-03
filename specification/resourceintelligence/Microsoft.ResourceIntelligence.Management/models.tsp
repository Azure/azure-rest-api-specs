import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.ResourceIntelligence;

// ============================================
// THREAD STATUS
// ============================================

/**
 * The lifecycle status of a thread.
 */
union ThreadStatus {
  string,

  /** The thread is idle and not currently running */
  Idle: "Idle",

  /** The thread is actively running */
  Running: "Running",

  /** The thread execution is paused */
  Paused: "Paused",

  /** The thread is awaiting user input */
  AwaitingInput: "AwaitingInput",

  /** The thread has completed execution */
  Completed: "Completed",

  /** The thread execution failed */
  Failed: "Failed",
}

// ============================================
// MESSAGE TYPES
// ============================================

/**
 * The type of message in a thread run.
 */
union MessageType {
  string,

  /** A system-generated message */
  system_message: "system_message",

  /** A tool invocation request */
  tool_call: "tool_call",

  /** A tool invocation response */
  tool_return: "tool_return",

  /** A message from the assistant */
  assistant_message: "assistant_message",

  /** A message from the user */
  user_message: "user_message",
}

/**
 * The source of a message.
 */
union MessageSource {
  string,

  /** Message from the system */
  system: "system",

  /** Message from the user */
  user: "user",

  /** Message from the actor agent */
  actor: "actor",

  /** Message from the planner agent */
  planner: "planner",

  /** Message from the critic agent */
  critic: "critic",
}
