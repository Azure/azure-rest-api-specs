import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Http;

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
  Idle: "idle",

  /** The thread is actively running */
  Running: "running",

  /** The thread execution is paused */
  Paused: "paused",

  /** The thread is awaiting user input */
  AwaitingInput: "awaitingInput",

  /** The thread has completed execution */
  Completed: "completed",

  /** The thread execution failed */
  Failed: "failed",
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

// ============================================
// THREAD RUN REQUEST / RESPONSE
// ============================================

/**
 * Whether tool invocation is permitted during a thread run.
 */
union AllowToolUse {
  string,

  /** Tool invocation is enabled during the run */
  Enabled: "enabled",

  /** Tool invocation is disabled during the run */
  Disabled: "disabled",
}

/**
 * The resume policy for a thread run.
 */
union ResumePolicy {
  string,

  /** No specific policy — default behavior, starts the thread run */
  None: "none",

  /** Resume the thread run */
  Resume: "resume",

  /** Pause the thread run */
  Pause: "pause",

  /** Cancel the thread run */
  Cancel: "cancel",
}

/**
 * Request body for creating and running a thread.
 */
model ThreadRunRequest {
  /**
   * Whether tool invocation is permitted during the run. Defaults to enabled.
   */
  allowToolUse?: AllowToolUse;

  /**
   * The resume policy for the run. Defaults to none.
   */
  resumePolicy?: ResumePolicy;

  /**
   * Optional input overrides as key-value pairs.
   */
  inputOverrides?: Record<string>;

  /**
   * The input message from the user.
   */
  message?: string;

  /**
   * Optional model URL override. When specified, this URL is used for all agents
   * instead of the model URL from the agent definitions.
   */
  // "model" is a TypeSpec keyword — use @encodedName to keep the wire name as "model"
  @encodedName("application/json", "model")
  modelUrl?: string;
}

/**
 * Response body returned when a thread run is accepted.
 */
model ThreadRunResponse {
  /**
   * The ID of the thread.
   */
  threadId: string;

  /**
   * The ID of the created run.
   */
  runId: string;

  /**
   * The current status of the run.
   */
  status: string;
}
