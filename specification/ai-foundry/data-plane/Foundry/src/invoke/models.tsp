import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Core types
// ---------------------------------------------------------------------------

@doc("""
  Type discriminator for content items.
  Supports common predefined types and any custom string for developer-defined content types.
  """)
union ContentItemType {
  string,

  @doc("Plain text content")
  text: "text",

  @doc("Image content")
  image: "image",

  @doc("Document content")
  file: "file",

  @doc("Structured data content")
  structured_data: "structured_data",

  @doc("An interrupt (supported only as an agent output).")
  interrupt: "interrupt",

  @doc("An interrupt resume (supported only as an agent input).")
  interrupt_resume: "interrupt_resume",
}

@doc("Reference to the agent being invoked.")
model AgentDef {
  @doc("Agent name.")
  name: string;

  @doc("Agent version.")
  version: string;
}

@doc("""
  Content item
  """)
@discriminator("item_type")
model ContentItem {
  item_type: ContentItemType;
}

@doc("Text content item for plain text content.")
model TextContentItem extends ContentItem {
  item_type: ContentItemType.text;

  @doc("Text content.")
  text?: string;
}

@doc("Structured data content item.")
model StructuredDataContentItem extends ContentItem {
  item_type: ContentItemType.structured_data;

  @doc("Structured data.")
  data?: Record<unknown>;
}

@doc("""
  Image content item.
  Supports platform-managed files (file_id), remote URLs, or inline base64 data.
  """)
model ImageContentItem extends ContentItem {
  item_type: ContentItemType.image;

  @doc("Platform-managed file reference (preferred for large images).")
  file_id?: string;

  @doc("Remote URL for the image.")
  url?: url;

  @doc("Inline base64-encoded image data.")
  data?: string;

  @doc("Image MIME type (e.g., 'image/jpeg', 'image/png').")
  content_type?: string;
}

@doc("""
  File content item for document attachments.
  Supports platform-managed files (file_id), remote URLs, or inline base64 data.
  """)
model FileContentItem extends ContentItem {
  item_type: ContentItemType.file;

  @doc("Suggested filename for the file (commonly used in output).")
  file_name?: string;

  @doc("Platform-managed file reference (preferred for large files).")
  file_id?: string;

  @doc("Remote URL for the file.")
  url?: url;

  @doc("Inline base64-encoded file data.")
  data?: string;

  @doc("File MIME type (e.g., 'application/pdf', 'text/csv').")
  content_type?: string;
}

@doc("""
  Interrupt resume content item for continuing execution after an interrupt.
  Used to resume from a human-in-the-loop (HITL) pause or other interrupt scenarios.
  """)
model InterruptResumeContentItem extends ContentItem {
  item_type: ContentItemType.interrupt_resume;

  @doc("""
    Interrupt ID from the previous response.
    Must match the interrupt.interrupt_id field to resume from the correct checkpoint.
    """)
  interrupt_id: string;

  @doc("""
    Optional payload to pass to the agent when resuming.
    Can contain user decisions, additional context, or custom data needed by the agent.
    """)
  payload?: Record<unknown>;
}

@doc("""
  Interrupt content item for HITL and other pause scenarios.
  Interrupts pause agent execution and await client action before resuming.
  """)
model InterruptContentItem extends ContentItem {
  item_type: ContentItemType.interrupt;

  @doc("""
    Unique identifier for this interrupt.
    Client must include this in InterruptResumeContentItem.interrupt_id when resuming execution.
    """)
  interrupt_id: string;

  @doc("Interrupt type discriminator (e.g., 'tool_call', 'oauth_consent', 'approval_required').")
  interrupt_type: string;

  ...Record<unknown>;
}

@doc("""
  A message containing one or more content items.
  Messages enable structured conversations, agent chaining, and support for interrupts.
  Each message can contain text, images, files, interrupts, or interrupt resumes.
  """)
model InvokeMessage {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Content can be string or array of ContentItem"
  @doc("""
    Content items in this message. Can contain text, images, files, interrupts, etc.
    String shorthand is automatically normalized to text content by the platform.
    
    Examples:
    - String: "Hello, agent!"
    - Array: [{"item_type": "text", "text": "Hello!"}]
    """)
  content: string | ContentItem[];
}

@doc("Terminal status of an agent invocation.")
union InvocationStatus {
  string,

  @doc("Agent is currently executing.")
  in_progress: "in_progress",

  @doc("Agent completed successfully.")
  completed: "completed",

  @doc("Agent execution failed (exception, timeout, or error).")
  failed: "failed",

  @doc("Invocation was cancelled externally.")
  cancelled: "cancelled",

  @doc("Agent paused and awaiting user input (interrupt/HITL scenario).")
  awaiting_input: "awaiting_input",
}

// ---------------------------------------------------------------------------
// Request
// ---------------------------------------------------------------------------

@doc("Invoke API request body.")
model InvokeRequest {
  @doc("Agent definition specifying which agent to invoke.")
  agent_def: AgentDef;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Input can be string or array of messages"
  @doc("""
    Input for the agent invocation. Supports:
    - Simple string: Automatically normalized to a user message with text content
    - Array of messages: For multi-turn conversations or structured inputs
    
    Examples:
    - String: "Hello, agent!"
    - Messages: [{"content": "Hello!"}]
    - With interrupt resume: [{"content": [{"item_type": "interrupt_resume", "interrupt_id": "int_123", "payload": {...}}]}]
    """)
  input: string | InvokeMessage[];

  @doc("Session identifier for multi-turn conversations. Omit to create a new session.")
  session_id?: string;

  @doc("""
    Opaque parameters pass-through. Platform does not parse this field.
    Use for model configuration, custom agent flags, user context, tracing, etc.
    """)
  params?: Record<unknown>;
}

// ---------------------------------------------------------------------------
// Response
// ---------------------------------------------------------------------------

@doc("Invoke API response — the terminal SSE event payload.")
model InvokeResponse {
  @doc("The id of the response.")
  id: string;

  @doc("Terminal status of this agent invocation.")
  status: InvocationStatus;

  @doc("Session identifier this invocation belongs to.")
  session_id: string;

  @doc("""
    Agent output message containing content items (text, images, files, interrupts, etc.).
    - Null when status is 'failed'
    - May contain an interrupt when status is 'awaiting_input'
    - Contains final results when status is 'completed'
    """)
  output?: InvokeMessage;

  @doc("Structured error details. Present only when status is 'failed'.")
  error?: InvocationError;

  @doc("Unix timestamp (seconds) when invocation started.")
  created_at: int64;

  @doc("Unix timestamp (seconds) when invocation finished.")
  completed_at?: int64;
}

// ---------------------------------------------------------------------------
// Error (agent-level, in terminal SSE event)
// ---------------------------------------------------------------------------

@doc("Structured error information for agent-level failures in the terminal event.")
model InvocationError {
  @doc("Machine-readable error code (e.g., 'container_timeout', 'agent_exception', 'validation_error').")
  code: string;

  @doc("Human-readable error message describing the failure.")
  message: string;

  @doc("Parameter name that caused the error, if applicable.")
  param?: string;
}

// ---------------------------------------------------------------------------
// SSE events
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Event types are self-documenting"
#suppress "@azure-tools/typespec-autorest/union-unsupported" "SSE event unions are supported"
@doc("""
  Union of all possible SSE event types in the invoke streaming response.
  
  Agents can emit either delta events or final events for content items:
  - Delta events: Incremental updates that are merged with existing content
  - Final events: Complete content items that replace any existing content
  """)
union InvokeStreamingResponse {
  `invoke.created`: InvocationCreatedEvent,
  `output.content.delta`: ContentDeltaEvent,
  `output.content.final`: ContentFinalEvent,
  `invoke.completed`: InvocationCompletedEvent,
}

@doc("Base event model with sequence number.")
model InvocationEvent {
  @doc("Monotonically increasing event sequence number.")
  seq: int64;
}

@doc("SSE event emitted when an agent invocation starts.")
model InvocationCreatedEvent {
  ...InvocationEvent;

  @doc("Session identifier this invocation belongs to.")
  session_id: string;

  @doc("Unix timestamp (seconds since epoch) when the invocation started.")
  created_at: int64;
}

@doc("""
  SSE event emitted for incremental content deltas during streaming.
  
  Delta events provide incremental updates that are merged with existing content:
  - Text properties: New text is concatenated to existing text
  - Numeric properties: New value is added to existing value
  - Array properties: New items are appended to existing array
  - New properties: Initialized with the provided value
  
  Example sequence:
  1. Delta event: {"text": "Hello"} → content becomes "Hello"
  2. Delta event: {"text": " World", "final": true} → content becomes "Hello World" and is complete
  
  The final flag on any delta event signals that no more deltas will be sent for this item_index.
  """)
model ContentDeltaEvent {
  ...InvocationEvent;

  @doc("The zero-based index of the content item in the output message.")
  index: int64;

  @doc("MIME type of the content being streamed.")
  item_type: ContentItemType;

  @doc("""
    Incremental delta object containing property updates to merge.
    Properties in delta are merged with existing content according to merge semantics.
    """)
  delta: Record<unknown>;

  @doc("""
    Whether this is the final delta for this content item.
    When true, no more deltas will be sent for this item_index.
    Can be set on any delta event in the sequence.
    """)
  final: boolean;
}

@doc("""
  SSE event emitted for a finalized content item.
  
  Final events provide complete content items that replace existing content:
  - If content item at index exists: Completely replaced with new item
  - If content item at index does not exist: New item is added at that index
  
  Use final events when:
  - Content items don't support incremental updates
  - You want to replace entire content atomically
  - Simpler streaming logic is preferred over deltas
  
  Example:
  Final event with {"item_type": "text", "text": "Complete message"} 
  → content at index is set to this complete item
  """)
model ContentFinalEvent {
  ...InvocationEvent;

  @doc("The zero-based index of the content item in the output message.")
  index: int64;

  @doc("""
    Complete content item that replaces any existing content at this index.
    The entire item is set atomically.
    """)
  item: ContentItem;
}

@doc("SSE event emitted when an agent invocation completes (terminal event).")
model InvocationCompletedEvent {
  ...InvocationEvent;

  @doc("Terminal status of this agent invocation.")
  status: InvocationStatus;

  @doc("""
    Opaque metadata pass-through from the agent. Platform does not parse this field.
    Commonly used for citations, tool execution details, framework-specific state, etc.
    """)
  metadata: Record<unknown>;

  @doc("Structured error details. Present only when status is 'failed'.")
  error?: InvocationError;

  @doc("Unix timestamp (seconds) when invocation finished.")
  completed_at?: int64;
}

// ---------------------------------------------------------------------------
// Health check
// ---------------------------------------------------------------------------

@doc("Readiness probe response.")
model ReadinessResponse {
  @doc("Status indicator.")
  status: "ok";
}
