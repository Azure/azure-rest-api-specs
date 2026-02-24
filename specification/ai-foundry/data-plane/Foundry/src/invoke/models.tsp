import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Core types
// ---------------------------------------------------------------------------

@doc("Reference to the agent being invoked.")
model AgentDef {
  @doc("Agent name.")
  name: string;

  @doc("Agent version.")
  version: string;

  @doc("Agent type (e.g. 'hosted').")
  type: string;
}

@doc("""
  A single content item using flat MIME typing.
  Shared by both `input` and `output` — enables agent chaining
  (agent A's output becomes agent B's input with zero translation).
  """)
model ContentItem {
  @doc("MIME type (text/plain, image/png, audio/wav, application/pdf, etc.).")
  content_type: string;

  @doc("Text payload. Required when content_type is text/*.")
  text?: string;

  @doc("Remote URL for media content.")
  url?: url;

  @doc("Platform-managed file reference.")
  file_id?: string;

  @doc("Suggested filename (typically used in output).")
  filename?: string;

  @doc("Inline base64-encoded payload.")
  data?: string;
}

@doc("Terminal status of an invocation.")
union InvocationStatus {
  string,

  @doc("Agent finished successfully.")
  completed: "completed",

  @doc("Agent error (exception, timeout).")
  failed: "failed",

  @doc("Externally cancelled.")
  cancelled: "cancelled",

  @doc("Agent paused, awaiting user input (HITL).")
  awaiting_input: "awaiting_input",
}

@doc("Role in a conversation history entry.")
union HistoryRole {
  string,

  @doc("User role.")
  user: "user",

  @doc("Assistant role.")
  assistant: "assistant",
}

@doc("A single turn in the conversation history.")
model HistoryEntry {
  @doc("Role: 'user' or 'assistant'.")
  role: HistoryRole;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Content can be string or array of ContentItem"
  @doc("The content for this turn (input for user, output for assistant).")
  content: string | ContentItem[];
}

// ---------------------------------------------------------------------------
// Request
// ---------------------------------------------------------------------------

@doc("Invoke API request body.")
model InvokeRequest {
  @doc("Agent to invoke.")
  agent_def: AgentDef;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Input can be string or array of ContentItem"
  @doc("""
    Primary user input. String shorthand is normalized to
    [{"content_type":"text/plain","text":"..."}] by the platform.
    """)
  input: string | ContentItem[];

  @doc("Session identifier. Omit to create a new session.")
  session_id?: string;

  @doc("""
    Opaque typed pass-through. Platform does not parse this.
    Use @type discriminator for typed dispatch by wrappers.
    Examples: model config, HITL resume state.
    """)
  metadata?: Record<unknown>;

  @doc("Session history injected by AgentService (not sent by caller).")
  history?: HistoryEntry[];
}

// ---------------------------------------------------------------------------
// Response
// ---------------------------------------------------------------------------

@doc("Invoke API response — the terminal SSE event payload.")
model InvokeResponse {
  @doc("Terminal status of this invocation.")
  status: InvocationStatus;

  @doc("Session this invocation belongs to.")
  session_id: string;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Output can be string or array of ContentItem"
  @doc("""
    Agent response content. Same shape as input — string shorthand
    or array of ContentItem. Null when status is 'failed'.
    """)
  output?: string | ContentItem[];

  @doc("""
    Opaque typed pass-through from agent. Platform does not parse this.
    Used for citations, interrupt details, framework-specific state.
    """)
  metadata?: Record<unknown>;

  @doc("Structured error details. Present when status is 'failed'.")
  error?: InvocationError;

  @doc("Unix timestamp (seconds) when invocation started.")
  created_at: int64;

  @doc("Unix timestamp (seconds) when invocation finished.")
  completed_at?: int64;
}

// ---------------------------------------------------------------------------
// Error (agent-level, in terminal SSE event)
// ---------------------------------------------------------------------------

@doc("Structured error for agent-level failures in the terminal event.")
model InvocationError {
  @doc("Machine-readable error code (e.g. 'container_timeout', 'agent_exception').")
  code: string;

  @doc("Human-readable error message.")
  message: string;

  @doc("Parameter that caused the error, if applicable.")
  param?: string;
}

// ---------------------------------------------------------------------------
// SSE events
// ---------------------------------------------------------------------------

@doc("SSE event: invocation started.")
model InvocationCreatedEvent {
  @doc("Monotonically increasing event sequence number.")
  seq: int64;

  @doc("Session identifier.")
  session_id: string;

  @doc("Current status.")
  status: "in_progress";
}

@doc("SSE event: incremental text chunk.")
model MessageDeltaEvent {
  @doc("Monotonically increasing event sequence number.")
  seq: int64;

  @doc("Incremental text content.")
  delta: string;
}

@doc("SSE event: file or media content.")
model ContentDeltaEvent {
  @doc("Monotonically increasing event sequence number.")
  seq: int64;

  @doc("MIME type of the content.")
  content_type: string;

  @doc("Platform-managed file reference.")
  file_id?: string;

  @doc("Suggested filename.")
  filename?: string;

  @doc("Remote URL for media content.")
  url?: url;
}

@doc("SSE event: terminal event (same shape as InvokeResponse).")
model InvocationCompletedEvent is InvokeResponse;

// ---------------------------------------------------------------------------
// Health check
// ---------------------------------------------------------------------------

@doc("Readiness probe response.")
model ReadinessResponse {
  @doc("Status indicator.")
  status: "ok";
}
