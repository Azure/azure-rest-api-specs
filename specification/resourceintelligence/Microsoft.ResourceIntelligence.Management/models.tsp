import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ResourceIntelligence;

// ============================================
// RUN STATUS
// ============================================

/**
 * The lifecycle status of a run.
 */
union RunStatus {
  string,

  /** The run is idle and not currently executing */
  Idle: "idle",

  /** The run is actively executing */
  Running: "running",

  /** The run execution is paused */
  Paused: "paused",

  /** The run is awaiting user input */
  AwaitingInput: "awaitingInput",

  /** The run has completed execution */
  Completed: "completed",

  /** The run execution failed */
  Failed: "failed",
}

// ============================================
// MESSAGE TYPES
// ============================================

/**
 * The type of message in a run.
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
// RUN REQUEST / RESPONSE
// ============================================

/**
 * Whether tool invocation is permitted during a run.
 */
union AllowToolUse {
  string,

  /** Tool invocation is enabled during the run */
  Enabled: "enabled",

  /** Tool invocation is disabled during the run */
  Disabled: "disabled",
}

/**
 * The resume policy for a run.
 */
union ResumePolicy {
  string,

  /** No specific policy - default behavior, starts the run */
  None: "none",

  /** Resume the run */
  Resume: "resume",

  /** Pause the run */
  Pause: "pause",

  /** Cancel the run */
  Cancel: "cancel",
}

/**
 * Request body for creating and running an agent.
 */
model RunRequest {
  /**
   * Whether tool invocation is permitted during the run. Defaults to enabled.
   */
  allowToolUse?: AllowToolUse;

  /**
   * The resume policy for the run. Defaults to none.
   */
  resumePolicy?: ResumePolicy;

  /**
   * Optional input overrides for the run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Input overrides require a flexible key-value structure matching the previous API version"
  inputOverrides?: Record<string>;

  /**
   * The input message from the user.
   */
  message?: string;

  /**
   * Optional model URL override. When specified, this URL is used for all agents
   * instead of the model URL from the agent definitions.
   */
  // "model" is a TypeSpec keyword - use @encodedName to keep the wire name as "model"
  @encodedName("application/json", "model")
  modelUrl?: string;
}

/**
 * Result returned when an agent run is created.
 */
model RunResult {
  /**
   * The ID of the created run.
   */
  runId: string;

  /**
   * The current status of the run.
   */
  status: RunStatus;
}
