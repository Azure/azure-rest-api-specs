# Foundry Agent Invoke API Specification

## Motivation

Azure Foundry agents currently use the OpenAI Response API (`POST /openai/responses`) as the invocation protocol.
This has several issues:

- **Too many model-inference parameters** — Response API exposes `temperature`, `top_p`, `max_output_tokens`,
  `reasoning`, `truncation`, `service_tier`, `prompt_cache_key`, etc. None of these are relevant to the agent
  invocation contract. They are model-serving concerns that belong in the agent's own configuration, not in every
  client request.
- **OpenAI-specific** — The Response API is tightly coupled to OpenAI models. If an agent is backed by Claude,
  Gemini, Llama, or a custom model, the caller shouldn't need to speak the OpenAI wire format.
- **Fragile coupling** — Every time OpenAI updates the Response API, AgentService must absorb the change even though
  the agent semantics haven't changed.
- **Tool calls exposed on wire** — Tool execution details are serialized in the response, adding complexity and
  revealing internal implementation details that clients don't need.

### Design goals

A **model-agnostic, agent-centric** invoke API that provides:

**Core principles:**

1. **Agent-first contract** — The request contains only what AgentService and the agent container need: **input
   (text/multimodal), session identity, and optional metadata**. No model-specific parameters in the core contract.
2. **Clean responses** — The response contains only what the caller needs: **agent output as messages with content
   items, conversation state, and optional metadata**. Tool calls are handled entirely within the agent container —
   the client never sees them.
3. **Configuration over requests** — Model parameters (temperature, max_tokens, etc.) and agent behavior should be
   configured at agent creation time, not required in every request. When per-request control is needed, use
   `metadata` — an opaque pass-through that AgentService forwards to the agent container without parsing or
   validation.

**Key features:**

- **Multimodal inputs** — `input` accepts a plain string (text shorthand) or an array of `InvokeMessage` objects
  containing `ContentItem` arrays supporting text, images, audio, documents, and **custom content types**
- **Flat MIME typing** — Each content item has a `content_type` field (e.g., `text/plain`, `image/png`,
  `application/pdf`, or custom types like `application/x-agent-graph`)
- **Agent chaining** — Output from one agent can directly become input to another with zero translation, enabling
  seamless multi-agent workflows
- **Custom content types** — Agents can define their own content types with arbitrary properties via the extensible
  `ContentItem` model using `...Record<unknown>`
- **Streaming** — Server-Sent Events (SSE) for real-time content streaming with incremental deltas indexed by
  content item position
- **Human-in-the-loop** — First-class interrupt mechanism with type-discriminated interrupt models for different
  HITL scenarios
- **Metadata extensibility** — Request and response metadata fields support opaque pass-through for agent-specific
  configuration and state

---

## API overview

| Operation | Method | Path |
|-----------|--------|------|
| Invoke | `POST` | `/invoke` |
| Readiness | `GET` | `/readiness` |

The invoke response is always delivered as a Server-Sent Events (SSE) stream (`Content-Type: text/event-stream`).
This ensures real-time feedback, avoids HTTP gateway timeouts on long-running agent tasks, and simplifies the API to
a single response format.

**Note:** The current design is **synchronous** — the client waits for the SSE stream to complete. For long-running
tasks requiring background invocation (fire-and-forget, polling, cancellation), see the **Background invocations**
section for a future design pattern.

---

## Request

### `POST /invoke`

```jsonc
{
  // --- Agent reference (required) ---
  "agent_def": {
    "name": "my-agent",
    "version": "1.0"
  },

  // --- Input (required) ---
  // String shorthand for text-only input:
  "input": "Summarize Q4 earnings",
  
  // Or array of messages for multi-turn or multimodal:
  // "input": [
  //   {
  //     "content": [
  //       { "content_type": "text/plain", "text": "Analyze this chart" },
  //       { "content_type": "image/png", "url": "https://example.com/chart.png" }
  //     ]
  //   }
  // ],

  // --- Session (optional) ---
  "session_id": "sess_xyz789",   // omit to start a new session

  // --- Interrupt resume (optional) ---
  // "interrupt": {
  //   "id": "int_abc123",         // from previous response
  //   "payload": {                // arbitrary resume data
  //     "user_confirmed": true
  //   }
  // },

  // --- Metadata pass-through (optional) ---
  "metadata": {
    "temperature": 0.7,           // model knobs
    "custom_flag": "verbose",     // agent-specific flags
    "user_context": { ... }       // any JSON structure
  }
}
```

### Request field reference

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `agent_def` | `AgentDef` | **Yes** | Agent reference containing `name` (string) and `version` (string, e.g., "1.0"). |
| `input` | `string \| InvokeMessage[]` | **Yes** | User input. A plain **string** is shorthand for a single text message. For multimodal or multi-turn inputs, use an array of `InvokeMessage` objects. |
| `session_id` | `string` | No | Identifier of an existing session. Omit to create a new one. When provided, AgentService loads existing conversation history. |
| `interrupt` | `InterruptResume` | No | Resume details for continuing from a human-in-the-loop pause. Required when resuming from `status: "awaiting_input"`. Contains `id` (interrupt ID from previous response) and optional `payload` (arbitrary data for the agent). |
| `metadata` | `object` | No | Opaque JSON object **forwarded to the agent container**. AgentService does **not** parse or validate this. Use for model parameters, custom flags, user context, etc. |

### InvokeMessage structure

```jsonc
{
  "content": "Simple text message"
  // OR
  // "content": [
  //   { "content_type": "text/plain", "text": "Message text" },
  //   { "content_type": "image/png", "url": "https://..." },
  //   { "content_type": "application/pdf", "file_id": "file_abc123" }
  // ],
  
  "metadata": {  // optional
    "timestamp": 1738900000,
    "user_id": "user_123"
  }
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `content` | `string \| ContentItem[]` | **Yes** | Message content. A string is shorthand for `[{"content_type":"text/plain","text":"..."}]`. For multimodal content, use an array of `ContentItem` objects. |
| `metadata` | `object` | No | Optional message-level metadata. Opaque pass-through. |

### ContentItem structure

ContentItem uses **flat MIME typing** where each content item is self-describing with a `content_type` field.

**Predefined content types:**

- `text/plain` — Plain text
- `image/png`, `image/jpeg` — Images
- `audio/wav` — Audio
- `application/pdf` — PDF documents

**Custom content types:**

Agents can define their own content types (e.g., `application/x-agent-graph`, `application/x-tool-result`) and
include arbitrary properties. The `ContentItem` model is extensible via `...Record<unknown>`, allowing custom
properties beyond the standard fields.

**Standard ContentItem fields:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `content_type` | `ContentType (string)` | **Yes** | MIME type or custom type identifier. Union of predefined types + any string. |
| `text` | `string` | No | Text payload (required for text/* types) |
| `url` | `string` | No | Remote URL for media content |
| `file_id` | `string` | No | Platform-managed file reference |
| `filename` | `string` | No | Suggested filename |
| `data` | `string` | No | Inline base64-encoded payload |
| *custom fields* | `any` | No | Additional properties for custom content types |

**Examples:**

```jsonc
// Text content
{
  "content_type": "text/plain",
  "text": "Analyze the quarterly trends"
}

// Image from URL
{
  "content_type": "image/png",
  "url": "https://example.com/chart.png",
  "filename": "q4-chart.png"
}

// PDF from platform file
{
  "content_type": "application/pdf",
  "file_id": "file_abc123",
  "filename": "report.pdf"
}

// Inline base64 image
{
  "content_type": "image/jpeg",
  "data": "iVBORw0KGgoAAAANS...",
  "filename": "photo.jpg"
}

// Custom content type (agent-defined)
{
  "content_type": "application/x-agent-graph",
  "nodes": [...],
  "edges": [...],
  "metadata": { ... }
}
```

---

## Response

The response is always delivered as an SSE stream (`Content-Type: text/event-stream`). Each SSE event has an
`event:` line and a JSON `data:` line.

### Event types

| Event | Payload | Description |
|-------|---------|-------------|
| `invoke.created` | `InvocationCreatedEvent` | Invocation started. Contains the `session_id` (especially useful for new sessions) and `created_at` timestamp. |
| `invoke.content.delta` | `ContentDeltaEvent` | Incremental content delta for a specific content item. `index` identifies which content item in the output message, `delta` contains the incremental data, `is_completed` signals when that content item is done. |
| `invoke.completed` | `InvocationCompletedEvent` | Terminal event with complete response including status, output message, interrupt details (if HITL), metadata, timestamps, and error (if failed). |

### Event stream example

```
event: invoke.created
data: {"seq":1,"session_id":"sess_xyz789","created_at":1738900000}

event: invoke.content.delta
data: {"seq":2,"index":0,"delta":{"content_type":"text/plain","text":"Here is"},"is_completed":false}

event: invoke.content.delta
data: {"seq":3,"index":0,"delta":{"content_type":"text/plain","text":" the chart"},"is_completed":false}

event: invoke.content.delta
data: {"seq":4,"index":0,"delta":{"content_type":"text/plain","text":" you requested:"},"is_completed":false}

event: invoke.content.delta
data: {"seq":5,"index":0,"delta":{"content_type":"text/plain"},"is_completed":true}

event: invoke.content.delta
data: {"seq":6,"index":1,"delta":{"content_type":"image/png","file_id":"file_abc123","filename":"chart.png"},"is_completed":true}

event: invoke.completed
data: {"seq":7,"status":"completed","session_id":"sess_xyz789","output":{"content":[{"content_type":"text/plain","text":"Here is the chart you requested:"},{"content_type":"image/png","file_id":"file_abc123","filename":"chart.png"}]},"created_at":1738900000,"completed_at":1738900003}
```

### InvokeResponse (invoke.completed event) field reference

| Field | Type | Description |
|-------|------|-------------|
| `seq` | `integer` | Event sequence number (from InvocationEvent base) |
| `status` | `InvocationStatus` | Terminal status: `completed`, `failed`, `cancelled`, `awaiting_input` (for HITL) |
| `session_id` | `string` | Session this invocation belongs to |
| `output` | `InvokeMessage` | Agent's response message with content items. Null when status is `failed`. May be partial when `awaiting_input`. |
| `interrupt` | `Interrupt` | Type-discriminated interrupt details. Present when status is `awaiting_input`. See Interrupt types below. |
| `metadata` | `object` | Opaque metadata from agent (citations, custom state). Optional. |
| `error` | `InvocationError` | Error details with `code`, `message`, `param`. Present when status is `failed`. |
| `created_at` | `integer` | Unix timestamp (seconds) when invocation started |
| `completed_at` | `integer` | Unix timestamp (seconds) when invocation finished. Optional. |

### ContentDelta structure

Used in `invoke.content.delta` events to stream incremental content.

| Field | Type | Description |
|-------|------|----------|
| `content_type` | `ContentType (string)` | MIME type of the content being streamed |
| `text` | `string` | Incremental text chunk (for text/* types) |
| `file_id` | `string` | File reference (emitted when file is ready) |
| `filename` | `string` | Suggested filename |
| `url` | `string` | Remote URL (when available) |
| *custom fields* | `any` | Additional properties for custom content types |

### Status values

| Status | Meaning |
|--------|--------|
| `in_progress` | Agent is executing (only in streaming events, not terminal) |
| `completed` | Agent finished successfully |
| `failed` | Agent encountered an error (see `error` field) |
| `cancelled` | Invocation was cancelled |
| `awaiting_input` | Agent paused and is waiting for human input (HITL) |

---

## Human-in-the-Loop (HITL)

Some agent workflows require human oversight or input at critical decision points. Common scenarios include:

- **Tool approval** — Requiring confirmation before executing sensitive tools (e.g., booking flights, sending emails,
  deleting data)
- **Clarification** — Asking the user to disambiguate (e.g., "Which San Francisco did you mean - California or the
  Philippines?")
- **Input collection** — Requesting additional information needed to complete a task (e.g., "What's your preferred
  departure time?")
- **Decision points** — Offering choices when multiple valid options exist (e.g., "Found 3 hotels - which one?")

The invoke API supports HITL via a **first-class interrupt mechanism** with type-discriminated interrupt models.

### How it works

When an agent needs human input, it **pauses execution** and returns a response with `status: "awaiting_input"` and
an `interrupt` object. The client displays the interrupt to the user, collects their input, and sends a new
`POST /invoke` request with the user's response as `input` and an `interrupt` object containing the interrupt ID and
optional payload.

```
Client                          AgentService                    Agent Container
  |  POST /invoke                    |                                |
  |  input: "Book a flight"          |                                |
  |--------------------------------->|                                |
  |                                  |  forward to container          |
  |                                  |------------------------------->|
  |                                  |                                |  Agent runs...
  |                                  |                                |  Model decides to book
  |                                  |                                |  → interrupt() triggered
  |                                  |  status: awaiting_input        |
  |                                  |  interrupt: { type, id }       |
  |                                  |<-------------------------------|
  |  200 { status:awaiting_input,    |                                |
  |    interrupt: {                  |                                |
  |      type: "confirmation",       |                                |
  |      id: "int_abc",              |                                |
  |      ...                         |                                |
  |    }}                            |                                |
  |<---------------------------------|                                |
  |                                  |                                |
  |  (user reviews and confirms)     |                                |
  |                                  |                                |
  |  POST /invoke                    |                                |
  |  session_id: "sess_001"          |                                |
  |  input: "yes"                    |                                |
  |  interrupt: {                    |                                |
  |    id: "int_abc",                |                                |
  |    payload: { confirmed: true }  |                                |
  |  }                               |                                |
  |--------------------------------->|                                |
  |                                  |  forward to container          |
  |                                  |------------------------------->|
  |                                  |                                |  Agent resumes...
  |                                  |                                |  Executes booking
  |                                  |  status: completed             |
  |                                  |  output: "Booked! ..."         |
  |                                  |<-------------------------------|
  |  200 { status: completed,        |                                |
  |    output: "Booked! ..." }       |                                |
  |<---------------------------------|                                |
```

### Interrupt types

The `Interrupt` model uses a `type` discriminator to support different HITL scenarios. The base model is:

```typescript
@discriminator("type")
model Interrupt {
  type: string;  // "confirmation", "input", "choice", or custom
  id: string;    // unique identifier for resuming
}
```

Agents can extend the base model or use metadata for scenario-specific data:

**Example interrupt response (confirmation):**

```jsonc
{
  "status": "awaiting_input",
  "session_id": "sess_001",
  "output": {
    "content": [
      { "content_type": "text/plain", "text": "Ready to book flight UA123 to NYC for $450?" }
    ]
  },
  "interrupt": {
    "type": "confirmation",
    "id": "int_abc123"
  },
  "metadata": {
    "action": "book_flight",
    "flight_details": { "flight": "UA123", "price": 450, "destination": "NYC" }
  },
  "created_at": 1738900000
}
```

### Resume via InterruptResume

To continue execution after an interrupt, the client sends a new `POST /invoke` with the user's response as `input`
and the interrupt details in the `interrupt` field:

```jsonc
{
  "agent_def": {
    "name": "my-agent",
    "version": "1.0"
  },
  "input": "yes, go ahead",
  "session_id": "sess_001",
  "interrupt": {
    "id": "int_abc123",           // must match interrupt.id from response
    "payload": {                  // optional arbitrary data
      "user_confirmed": true,
      "notes": "Charge to corporate card"
    }
  }
}
```

The agent container's SDK reads the interrupt ID, locates the saved checkpoint, and resumes execution with the new
`input` and `payload`. This keeps the invoke API contract simple while providing maximum flexibility.

### HITL in SSE events

The interrupt is delivered inside the `invoke.completed` event:

```
event: invoke.created
data: {"seq":1,"session_id":"sess_001","created_at":1738900000}

event: invoke.content.delta
data: {"seq":2,"index":0,"delta":{"content_type":"text/plain","text":"Looking up flights..."},"is_completed":false}

event: invoke.completed
data: {"seq":3,"status":"awaiting_input","session_id":"sess_001","output":{"content":[{"content_type":"text/plain","text":"Ready to book flight UA123 to NYC for $450?"}]},"interrupt":{"type":"confirmation","id":"int_abc123"},"metadata":{"action":"book_flight","flight_details":{"flight":"UA123","price":450}},"created_at":1738900000}
```

---

## Agent Chaining

One of the key design goals of the invoke API is enabling **seamless agent chaining** — where the output of one
agent becomes the input of another with **zero translation**.

### How it works

Because both input and output use the same `InvokeMessage` structure with `ContentItem` arrays:

1. Agent A produces output: `{ "content": [{ "content_type": "text/plain", "text": "..." }, { "content_type": "application/x-results", "data": [...] }] }`
2. Client extracts `output.content` from Agent A's response
3. Client sends `output.content` as input to Agent B: `{ "input": [{ "content": [/* Agent A's output */] }] }`
4. Agent B receives the exact same content items with no transformation

### Example: Multi-agent workflow

```jsonc
// Step 1: Call data analysis agent
{
  "agent_def": { "name": "data-analyzer", "version": "1.0" },
  "input": "Analyze Q4 sales data",
  "session_id": "sess_workflow_001"
}

// Response from data-analyzer:
{
  "status": "completed",
  "output": {
    "content": [
      { "content_type": "text/plain", "text": "Sales increased 15% YoY" },
      {
        "content_type": "application/json",
        "text": "{\"sales\": 1500000, \"growth\": 0.15, \"top_products\": [...]}"
      }
    ]
  }
}

// Step 2: Forward to visualization agent (zero translation)
{
  "agent_def": { "name": "chart-generator", "version": "1.0" },
  "input": [
    {
      "content": [
        { "content_type": "text/plain", "text": "Create a chart from this data" }
      ]
    },
    // Copy output from previous agent directly - no transformation needed
    {
      "content": [
        { "content_type": "text/plain", "text": "Sales increased 15% YoY" },
        {
          "content_type": "application/json",
          "text": "{\"sales\": 1500000, \"growth\": 0.15, \"top_products\": [...]}"
        }
      ]
    }
  ],
  "session_id": "sess_workflow_001"
}

// Response includes generated chart
{
  "status": "completed",
  "output": {
    "content": [
      { "content_type": "text/plain", "text": "Here's your sales trend chart" },
      { "content_type": "image/png", "file_id": "file_chart789", "filename": "q4-sales.png" }
    ]
  }
}
```

### Custom content types enable rich chaining

Agents can define custom content types to pass structured data between agents:

```jsonc
// Agent A outputs custom graph structure
{
  "content_type": "application/x-agent-graph",
  "nodes": [{"id": "A", "value": 10}, {"id": "B", "value": 20}],
  "edges": [{"from": "A", "to": "B"}],
  "format_version": "1.0"
}

// Agent B receives and understands this custom type
// because it's part of the same agent ecosystem
```

---

## Custom Content Types

The invoke API is designed to be **extensible** for custom agent implementations. Custom container agents can define
their own content types and payload structures.

### Defining custom content types

1. Choose a unique content type identifier (use `application/x-*` pattern for custom types)
2. Include arbitrary properties in `ContentItem` beyond standard fields using `...Record<unknown>`
3. Document the content type schema for agents that need to consume it

**Example custom content types:**

```jsonc
// Tool execution result
{
  "content_type": "application/x-tool-result",
  "tool_name": "web_search",
  "tool_id": "tool_123",
  "result": {
    "query": "TypeScript documentation",
    "results": [...]
  },
  "execution_time_ms": 450
}

// Code execution output
{
  "content_type": "application/x-code-output",
  "language": "python",
  "stdout": "Hello, world!\n",
  "stderr": "",
  "exit_code": 0,
  "execution_time_ms": 120
}

// Structured data with schema
{
  "content_type": "application/x-agent-data",
  "schema_version": "2.1",
  "entities": [...],
  "relationships": [...],
  "confidence_scores": {...}
}
```

### Custom content in streaming

When streaming custom content types, the `ContentDelta` model is also extensible via `...Record<unknown>`:

```
event: invoke.content.delta
data: {
  "seq": 5,
  "index": 1,
  "delta": {
    "content_type": "application/x-tool-result",
    "tool_name": "web_search",
    "partial_result": {
      "query": "TypeScript",
      "results_count": 3
    }
  },
  "is_completed": false
}
```

---

## Tool Execution (Container-Internal)

Tools are executed **entirely within the agent container**. The client never sees tool calls — only the final agent
output. This is a key difference from the OpenAI Response API.

### Architecture

```
Client                          AgentService                    Agent Container
  |  POST /invoke                    |                                |
  |--------------------------------->|                                |
  |                                  |  forward request               |
  |                                  |------------------------------->|
  |                                  |                                | Agent runs...
  |                                  |                                | → Calls tool_A()
  |                                  |                                | → Tool executes
  |                                  |                                | → Calls tool_B()
  |                                  |                                | → Tool executes
  |                                  |                                | → Produces final output
  |                                  |  SSE: content deltas           |
  |  SSE: content deltas             |<-------------------------------|
  |<---------------------------------|                                |
  |                                  |  SSE: completed                |
  |  SSE: completed                  |<-------------------------------|
  |<---------------------------------|                                |
```

### What stays the same

**User's agent code does not change.** Tools are defined in agent code exactly as they are today.

The agent framework internally handles the full tool-call loop:
1. Send user message to model
2. Model returns a tool-call request (e.g. `get_weather("Seattle")`)
3. Framework executes the tool
4. Framework feeds the tool result back into the model
5. Model produces final text response
6. Steps 2–5 repeat if the model requests multiple tool calls

### Tool types

| Type | Where defined | Where executed | Auth |
|------|--------------|----------------|------|
| **Local tool** | Agent container code | In-process | N/A |
| **MCP tool** | Remote MCP server | External service | Agent provides credentials |
| **Foundry tool** | Platform service | Foundry platform | Managed identity (automatic) |

All tool execution happens before the final output is produced. The client receives only the result.

### Tool approval pattern

For sensitive tools requiring human confirmation before execution, the agent can use the interrupt mechanism:

```python
# In agent code
if requires_confirmation:
    # Trigger interrupt before executing sensitive tool
    interrupt_agent(
        type="confirmation",
        id="int_" + generate_id(),
        message=f"Confirm: {action_description}?",
        metadata={"action": action_name, "params": action_params}
    )
    
# When resumed with interrupt.id and payload.user_confirmed == True:
# Execute the tool
result = execute_sensitive_tool(params)
```

---

## What AgentService manages vs. what the container handles

| Concern | AgentService | Agent Container |
|---------|-------------|-----------------|
| Session persistence | ✅ Creates, loads, appends to session history | ❌ Stateless per-request (load session history when enabled) |
| Input parsing | ✅ Validates `input`, stores it | ❌ Receives assembled context |
| Tool execution | ❌ Not involved — tools are in agent definition / container code | ✅ Owns tool definitions, executes tools internally, returns final output |
| HITL (interrupt) | ✅ Relays interrupt events from container to client, validates interrupt resume | ✅ Triggers interrupt, saves checkpoint, resumes from checkpoint when interrupt.id matches |
| Streaming relay | ✅ Translates container SSE to client SSE | ✅ Produces SSE events |
| Model selection & parameters | ❌ Not in invoke payload (pass-through via `metadata`) | ✅ Uses configured model + any `metadata` overrides |
| Auth & rate limiting | ✅ Validates caller identity, enforces quotas | ❌ Trusts AgentService |

---

## Container Protocol

The agent container must implement the **same `/invoke` API** described above. AgentService acts as a proxy — it
manages sessions and auth, then forwards the request to the container using the identical contract.

### Request forwarded to container

The container receives the exact same request structure:

```jsonc
{
  "agent_def": { "name": "my-agent", "version": "1.0" },
  "input": "...",
  "session_id": "sess_xyz789",
  "interrupt": { "id": "int_abc", "payload": {...} },  // if resuming
  "metadata": { ... }
}
```

### Response from container

The container responds with the same SSE event stream (`invoke.created`, `invoke.content.delta`,
`invoke.completed`). AgentService relays these events to the client with minimal processing.

### HITL in the container protocol

When the agent triggers an interrupt, the container emits `invoke.completed` with `status: "awaiting_input"` and
the `interrupt` field:

```
event: invoke.completed
data: {"seq":5,"status":"awaiting_input","session_id":"sess_xyz789","output":{"content":[{"content_type":"text/plain","text":"Confirm: send email to alice@example.com?"}]},"interrupt":{"type":"confirmation","id":"int_abc123"},"metadata":{"action":"send_email","recipient":"alice@example.com"},"created_at":1738900000}
```

**Resume request forwarded to container:**

When the client responds to an interrupt, AgentService forwards the request to the container with the interrupt
details:

```jsonc
{
  "agent_def": { "name": "my-agent", "version": "1.0" },
  "input": "yes",
  "session_id": "sess_xyz789",
  "interrupt": {
    "id": "int_abc123",
    "payload": { "user_confirmed": true }
  }
}
```

The container's AgentServer SDK reads the interrupt ID, locates the saved checkpoint, and resumes execution with the
new `input` and interrupt `payload`. The framework-native resume mechanism (LangGraph `Command` or Agent Framework
state restoration) is handled internally by the SDK.

---

## Error Model

All errors follow a consistent structure:

```jsonc
{
  "error": {
    "code": "invalid_request",
    "message": "Missing required field 'input'.",
    "param": "input"  // optional
  }
}
```

### HTTP error codes

| HTTP Status | Code | When |
|-------------|------|------|
| `400` | `invalid_request` | Malformed request or missing required fields |
| `400` | `invalid_interrupt` | Interrupt ID doesn't match or is expired |
| `404` | `agent_not_found` | Agent name/version does not exist |
| `404` | `session_not_found` | Session ID not found or expired |
| `409` | `session_locked` | Another invocation is in progress on this session |
| `429` | `rate_limited` | Caller exceeded rate limits |
| `500` | `agent_error` | Agent container returned an error |
| `502` | `container_unavailable` | Agent container is not reachable |
| `504` | `container_timeout` | Agent container did not respond in time |

### Agent-level errors (in response)

When an agent fails during execution, the terminal `invoke.completed` event includes an error:

```jsonc
{
  "seq": 10,
  "status": "failed",
  "session_id": "sess_001",
  "output": null,
  "error": {
    "code": "agent_exception",
    "message": "Tool execution failed: database connection timeout",
    "param": "database_tool"
  },
  "created_at": 1738900000,
  "completed_at": 1738900003
}
```

---

## Comparison with OpenAI Response API

| Aspect | OpenAI Response API | Foundry Agent Invoke API |
|--------|-------------------|--------------------------|
| **Purpose** | Model inference | Agent invocation |
| **Model params** | Required in every request | Optional via metadata pass-through |
| **Model selection** | `model` field required | Agent config only |
| **Session state** | `previous_response_id` | `session_id` |
| **Input format** | Mixed content array | `string \| InvokeMessage[]` with flat MIME typing |
| **Output format** | Array of mixed content types (text, tool_call, etc.) | Single `InvokeMessage` with `ContentItem[]` |
| **Tool visibility** | Exposed on wire (`tool_call`, `function_call`) | Hidden (internal to container) |
| **Streaming** | Optional (`stream: true`) | Always streaming (SSE) |
| **Custom content** | Not supported | Fully supported via extensible ContentItem |
| **Agent chaining** | Requires translation | Zero translation (output = input format) |
| **HITL** | Not supported | First-class via type-discriminated interrupts |
| **Vendor lock-in** | OpenAI only | Model-agnostic |

---

## Background Invocations (Future)

### Current design: Synchronous only

The current invoke API is **synchronous** — the client makes a `POST /invoke` request and receives an SSE stream.
The connection remains open until the agent completes, fails, or triggers an interrupt.

**Characteristics:**
- **Streaming** — Response is always delivered as SSE events with real-time feedback
- **Blocking** — Client blocks on the SSE connection until the stream completes
- **Timeout resilience** — SSE keep-alive avoids HTTP gateway timeouts on long agent runs

This model works well for:
- ✅ Short-to-medium tasks (< 2-3 minutes)
- ✅ Interactive experiences (streaming text, real-time feedback)
- ✅ Client implementations with SSE support

But has limitations for:
- ❌ Long-running tasks (> 5 minutes)
- ❌ Fire-and-forget scenarios (start task, check result later)
- ❌ Background processing (user closes browser, agent keeps running)
- ❌ Reliable cancellation (network timeout vs intentional cancel)

### Future: Background invocation pattern

For long-running or background agent invocations, a background pattern would be needed. This would involve:

1. **Start background invoke** — `POST /invoke` with `background: true` returns immediately with invocation ID
2. **Poll for status** — `GET /invocations/{invocationId}` to check progress
3. **Retrieve incremental deltas** — `GET /invocations/{invocationId}?from_sequence=N` for progressive updates
4. **Cancel invocation** — `POST /invocations/{invocationId}/cancel`
5. **Webhook notifications** — Optional `webhook_url` in request for completion events

See the original draft for detailed background invocation design.

---

## Migration from Response API to Invoke API

### Phase 1: New agents use invoke API

- New hosted agents created with invoke API support
- Existing agents continue using Response API (no changes)

### Phase 2: Translation layer for v1 agents

- AgentService translates invoke API → Response API for backward compatibility
- Allows clients to use invoke API with older agents
- Containers remain unchanged

### Phase 3: Full migration

- All agents eventually migrated to native invoke API
- Response API deprecated

### AgentServer SDK strategy

The **AgentServer SDK** should support **both Response API and Invoke API** in a single SDK version, **automatically
detecting which API** is being called based on the endpoint and request format.

**Auto-detection wins** because:
- **Zero migration friction** — Same container supports both APIs, no rebuild needed
- **Automatic routing** — AgentService routes to correct endpoint based on agent metadata
- **True backward compatibility** — Old containers automatically work with new invoke API
- **Simpler developer experience** — Write handler once, SDK handles everything

---

## Summary

The invoke API provides a clean, model-agnostic interface for agent invocation that:

- ✅ Removes model-specific parameters from the request
- ✅ Uses flat MIME typing for flexible content handling
- ✅ Enables zero-translation agent chaining
- ✅ Supports custom content types for extensibility via `...Record<unknown>`
- ✅ Hides tool execution complexity from clients
- ✅ Provides first-class HITL support via type-discriminated interrupts
- ✅ Always streams responses for real-time feedback with indexed content deltas
- ✅ Uses opaque metadata for agent-specific pass-through
- ✅ Supports multimodal inputs (text, images, audio, documents, custom types)
- ✅ Works with any model (OpenAI, Claude, Gemini, Llama, custom)

This design significantly simplifies both client and container implementations while enabling more powerful
multi-agent workflows.
