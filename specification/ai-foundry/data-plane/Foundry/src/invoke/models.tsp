import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Core types
// ---------------------------------------------------------------------------

@doc("""
  MIME type for content items.
  Supports common predefined types and any custom string for developer-defined content types.
  """)
union ContentType {
  string,

  @doc("Plain text content.")
  text_plain: "text/plain",

  @doc("PNG image.")
  image_png: "image/png",

  @doc("JPEG image.")
  image_jpeg: "image/jpeg",

  @doc("WAV audio.")
  audio_wav: "audio/wav",

  @doc("PDF document.")
  application_pdf: "application/pdf",
}

@doc("Reference to the agent being invoked.")
model AgentDef {
  @doc("Agent name.")
  name: string;

  @doc("Agent version.")
  version: string;
}

@doc("""
  A single content item using flat MIME typing.
  Enables agent chaining (agent A's output becomes agent B's input with zero translation).
  
  Additional custom properties can be included for developer-defined content types.
  This enables custom container agent developers to define their own content items with
  custom content_type values and fully control the payload structure.
  """)
model ContentItem {
  @doc("MIME type (text/plain, image/png, audio/wav, application/pdf, etc.).")
  content_type: ContentType;

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

  // Additional custom properties for developer-defined content types
  ...Record<unknown>;
}

@doc("""
  A message containing one or more content items.
  Messages enable structured conversations and agent chaining.
  """)
model InvokeMessage {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Content can be string or array of ContentItem"
  @doc("""
    Content items in this message. Can contain text, images, audio, files, etc.
    String shorthand is normalized to [{"content_type":"text/plain","text":"..."}] by the platform.
    """)
  content: string | ContentItem[];

  @doc("Optional message metadata (e.g., timestamps, identifiers).")
  metadata?: Record<unknown>;
}

@doc("Terminal status of an invocation.")
union InvocationStatus {
  string,

  @doc("Agent is executing.")
  in_progress: "in_progress",

  @doc("Agent finished successfully.")
  completed: "completed",

  @doc("Agent error (exception, timeout).")
  failed: "failed",

  @doc("Externally cancelled.")
  cancelled: "cancelled",

  @doc("Agent paused, awaiting user input (HITL).")
  awaiting_input: "awaiting_input",
}

// ---------------------------------------------------------------------------
// Request
// ---------------------------------------------------------------------------

@doc("Interrupt resume payload for continuing execution after a human-in-the-loop pause.")
model InterruptResume {
  @doc("""
    Interrupt ID from the previous response.
    Must match the interrupt.id field to resume from the correct checkpoint.
    """)
  id: string;

  @doc("""
    Arbitrary payload to pass to the agent when resuming.
    Can contain user's decision, additional context, or custom data needed by the agent.
    """)
  payload?: Record<unknown>;
}

@doc("Invoke API request body.")
model InvokeRequest {
  @doc("Agent to invoke.")
  agent_def: AgentDef;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Input can be string or array of messages"
  @doc("""
    Input for the agent. Can be:
    - A simple string (normalized to a user message with text content)
    - An array of messages (user or assistant messages for multi-turn conversations)
    
    Examples:
    - String: "Hello, agent!"
    - Messages: [{"role": "user", "content": "Hello!"}]
    """)
  input: string | InvokeMessage[];

  @doc("Session identifier. Omit to create a new session.")
  session_id?: string;

  @doc("""
    Interrupt resume details when continuing from a human-in-the-loop pause.
    Required when resuming from status 'awaiting_input'.
    """)
  interrupt?: InterruptResume;

  @doc("""
    Opaque typed pass-through. Platform does not parse this.
    Use for model config, custom agent flags, user context, etc.
    """)
  metadata?: Record<unknown>;
}

// ---------------------------------------------------------------------------
// Response
// ---------------------------------------------------------------------------

@doc("Base interrupt model with type discriminator for different interrupt scenarios.")
@discriminator("type")
model Interrupt {
  @doc("Interrupt type discriminator.")
  type: string;

  @doc("""
    Unique identifier for this interrupt.
    Client must include this in InterruptResume when resuming execution.
    """)
  id: string;
}

@doc("Confirmation interrupt - requires user approval to proceed with an action.")
model ConfirmationInterrupt extends Interrupt {
  @doc("Interrupt type.")
  type: "confirmation";

  @doc("Action or operation requiring confirmation.")
  action?: string;

  @doc("Additional details about what will happen if confirmed.")
  details?: Record<unknown>;
}

@doc("Invoke API response — the terminal SSE event payload.")
model InvokeResponse {
  @doc("Terminal status of this invocation.")
  status: InvocationStatus;

  @doc("Session this invocation belongs to.")
  session_id: string;

  @doc("""
    Agent response messages. Each message contains content items (text, images, files, etc.).
    Null when status is 'failed'. May be partial when status is 'awaiting_input'.
    """)
  output?: InvokeMessage;

  @doc("""
    Interrupt details when agent pauses for human input.
    Present when status is 'awaiting_input'. Type can be 'confirmation', 'input', or 'choice'.
    Client must provide InterruptResume with interrupt.id when resuming execution.
    """)
  interrupt?: Interrupt;

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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Event types are self-documenting"
#suppress "@azure-tools/typespec-autorest/union-unsupported" "SSE event unions are supported"
@doc("Union of all possible SSE event types in the invoke streaming response.")
union InvokeStreamingResponse {
  `invoke.created`: InvocationCreatedEvent,
  `invoke.content.delta`: ContentDeltaEvent,
  `invoke.completed`: InvocationCompletedEvent,
}

@doc("Base event model with sequence number.")
model InvocationEvent {
  @doc("Monotonically increasing event sequence number.")
  seq: int64;
}

@doc("SSE event: invocation started.")
model InvocationCreatedEvent {
  ...InvocationEvent;

  @doc("Session this invocation belongs to.")
  session_id: string;

  @doc("Unix timestamp (seconds) when invocation started.")
  created_at: int64;
}

@doc("SSE event: incremental content delta.")
model ContentDeltaEvent {
  ...InvocationEvent;

  @doc("The index of the content item in the output message.")
  index: int64;

  @doc("Incremental content delta.")
  delta: ContentDelta;

  @doc("Whether this content item is completed.")
  is_completed: boolean;
}

@doc("Incremental content delta containing the content type and incremental data.")
model ContentDelta {
  @doc("MIME type of the content being streamed.")
  content_type: ContentType;

  @doc("Incremental text content (for text/* content types).")
  text?: string;

  @doc("File reference (when file is ready).")
  file_id?: string;

  @doc("Suggested filename.")
  filename?: string;

  @doc("Remote URL (when available).")
  url?: url;

  // Additional custom properties for developer-defined content types
  ...Record<unknown>;
}

@doc("SSE event: terminal event (invocation completed).")
model InvocationCompletedEvent {
  ...InvocationEvent;
  ...InvokeResponse;
}

// ---------------------------------------------------------------------------
// Health check
// ---------------------------------------------------------------------------

@doc("Readiness probe response.")
model ReadinessResponse {
  @doc("Status indicator.")
  status: "ok";
}
