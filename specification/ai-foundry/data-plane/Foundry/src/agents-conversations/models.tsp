import "@typespec/http";
import "@typespec/openapi";
import "../agents/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ============================================================================
// Persisted voice conversation resources.
//
// These models describe the durable, read-only projection of a voice-first
// prompt agent's conversation. They follow the Azure Voice Live 2026-04-10
// realtime schema (conversation / response / item / usage), NOT the OpenAI
// Responses/Conversations resources. Only fields that are safe and meaningful
// for a persisted customer contract are exposed; internal storage identifiers
// (file ids, containers, hosts, owners, providers) are never surfaced, and raw
// audio bytes are never inlined — the dedicated item/recording audio routes
// stream the bytes.
// ============================================================================

@doc("The lifecycle status of a persisted voice conversation.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceConversationStatus {
  string,

  @doc("The conversation's live session is still in progress.")
  in_progress: "in_progress",

  @doc("The conversation's live session has ended.")
  completed: "completed",
}

@doc("""
  A persisted voice conversation. The Foundry envelope that owns a voice-first prompt agent's stored
  transcript, responses, per-turn metrics, and audio. It is the parent, retention, and delete boundary:
  deleting it cascades to its responses, items, metrics, and audio.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceConversation {
  @doc("The unique id of the conversation.")
  id: string;

  @doc("The object type. Always `voice.conversation`.")
  object: "voice.conversation";

  @doc("The lifecycle status of the conversation.")
  status: VoiceConversationStatus;

  @doc("The Unix timestamp (in seconds) for when the conversation was created.")
  created_at: int32;

  @doc("The Unix timestamp (in seconds) for when the conversation's session ended. Absent while in progress.")
  completed_at?: int32;

  @doc("A set of key-value pairs attached to the conversation.")
  metadata?: Record<string>;
}

@doc("The response returned when a voice conversation is deleted.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceDeletedConversation {
  @doc("The id of the deleted conversation.")
  id: string;

  @doc("The object type. Always `voice.conversation.deleted`.")
  object: "voice.conversation.deleted";

  @doc("Always `true` for a successful delete.")
  deleted: boolean;
}

// ---------------------------------------------------------------------------
// Response (Voice Live RealtimeResponse)
// ---------------------------------------------------------------------------

@doc("The status of a voice response. Follows the Voice Live realtime response status.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceResponseStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  cancelled: "cancelled",
  incomplete: "incomplete",
  failed: "failed",
}

@doc("Additional details about a voice response's terminal status.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceResponseStatusDetails {
  @doc("The status the details describe.")
  type: VoiceResponseStatus;
}

@doc("A breakdown of input or output token usage.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceTokenDetails {
  @doc("Cached tokens used.")
  cached_tokens?: int32;

  @doc("Text tokens used.")
  text_tokens?: int32;

  @doc("Audio tokens used.")
  audio_tokens?: int32;

  @doc("Reasoning tokens generated. Applies to output token details only.")
  reasoning_tokens?: int32;
}

@doc("Token usage statistics for a voice response.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceUsage {
  @doc("Total tokens used.")
  total_tokens: int32;

  @doc("Input tokens used.")
  input_tokens: int32;

  @doc("Output tokens generated.")
  output_tokens: int32;

  @doc("Breakdown of input tokens.")
  input_token_details?: VoiceTokenDetails;

  @doc("Breakdown of output tokens.")
  output_token_details?: VoiceTokenDetails;
}

@doc("The voice used for a response. Follows the Voice Live realtime voice shape (e.g. `{ \"type\": \"openai\", \"name\": \"alloy\" }`).")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceResponseVoice {
  @doc("The voice kind, e.g. `openai` or an Azure voice type.")
  type: string;

  @doc("The voice name.")
  name: string;
}

@doc("The output audio format used for a response. Follows the Voice Live realtime output audio format.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceResponseAudioFormat {
  string,

  @doc("16-bit PCM at the default sampling rate.")
  pcm16: "pcm16",
}

@doc("""
  A persisted voice response, following the Voice Live `RealtimeResponse` schema. Represents one model
  inference turn within a conversation. In list results the `output` projection is omitted — use the
  response-items route for the canonical paged output. `created_at`/`completed_at` are Foundry durable
  ordering extensions.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceResponse {
  @doc("The unique id of the response.")
  id: string;

  @doc("The object type. Always `realtime.response`.")
  object: "realtime.response";

  @doc("The status of the response.")
  status: VoiceResponseStatus;

  @doc("Additional detail about a terminal status.")
  status_details?: VoiceResponseStatusDetails;

  @doc("The output items produced by the response. May be omitted in list results; use the response-items route for the canonical paged projection.")
  output?: VoiceConversationItem[];

  @doc("Token usage statistics for the response.")
  usage?: VoiceUsage;

  @doc("The id of the conversation this response belongs to.")
  conversation_id: string;

  @doc("The voice used for the response.")
  voice?: VoiceResponseVoice;

  @doc("The output modalities used for the response, e.g. `[\"text\", \"audio\"]`.")
  modalities?: string[];

  @doc("The output audio format used for the response.")
  output_audio_format?: VoiceResponseAudioFormat;

  @doc("The sampling temperature used for the response.")
  temperature?: float32;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Voice Live represents this as an integer token count or the literal string 'inf'."
  @doc("The maximum number of output tokens allowed for the response; an integer or the literal `inf`.")
  max_response_output_tokens?: int32 | "inf";

  @doc("The Unix timestamp (in seconds) for when the response was created.")
  created_at?: int32;

  @doc("The Unix timestamp (in seconds) for when the response completed.")
  completed_at?: int32;
}

// ---------------------------------------------------------------------------
// Message content parts (persisted; no inline base64 audio)
// ---------------------------------------------------------------------------

@doc("The kind of a message content part.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceContentPartType {
  string,
  input_text: "input_text",
  text: "text",
  input_audio: "input_audio",
  audio: "audio",
}

@doc("A single content part of a voice message. Audio parts carry only the transcript in this persisted contract; raw audio bytes are streamed by the item-audio route, never inlined.")
@discriminator("type")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceContentPart {
  @doc("The content part kind.")
  type: VoiceContentPartType;
}

@doc("An input (user/system) text content part.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceInputTextContentPart extends VoiceContentPart {
  type: VoiceContentPartType.input_text;

  @doc("The text content.")
  text: string;
}

@doc("An output (assistant) text content part.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceOutputTextContentPart extends VoiceContentPart {
  type: VoiceContentPartType.text;

  @doc("The text content.")
  text: string;
}

@doc("An input (user) audio content part. Only the transcript is persisted here; the audio bytes are streamed by the item-audio route.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceInputAudioContentPart extends VoiceContentPart {
  type: VoiceContentPartType.input_audio;

  @doc("The transcript of the input audio.")
  transcript?: string;
}

@doc("An output (assistant) audio content part. Only the transcript is persisted here; the audio bytes are streamed by the item-audio route.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceOutputAudioContentPart extends VoiceContentPart {
  type: VoiceContentPartType.audio;

  @doc("The transcript of the output audio.")
  transcript?: string;
}

// ---------------------------------------------------------------------------
// Conversation items (Voice Live RealtimeConversationResponseItem + persisted
// client-created request items)
// ---------------------------------------------------------------------------

@doc("The role of a voice message item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceMessageRole {
  string,
  user: "user",
  assistant: "assistant",
  system: "system",
}

@doc("The status of a voice conversation item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceItemStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  incomplete: "incomplete",
}

@doc("Error details for a failed tool item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceItemError {
  @doc("The error type.")
  type?: string;

  @doc("A specific error code.")
  code?: string;

  @doc("A human-readable error description.")
  message?: string;
}

@doc("""
  Per-turn voice metrics for a message item (a Foundry extension). Latency figures are in milliseconds.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMetrics {
  @doc("Time to first token, in milliseconds.")
  ttft_ms?: int32;

  @doc("Time to first audio, in milliseconds.")
  ttfa_ms?: int32;

  @doc("Average inter-token latency, in milliseconds.")
  itl_avg_ms?: int32;

  @doc("The turn's audio (or token span) duration, in milliseconds.")
  duration_ms?: int32;

  @doc("Whether the turn was interrupted (barge-in).")
  interrupted?: boolean;

  @doc("The offset from the start of the turn at which it was interrupted, in milliseconds.")
  interrupt_offset_ms?: int32;
}

@doc("A single file search result entry.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFileSearchResult {
  @doc("The id of the matched file.")
  file_id?: string;

  @doc("The name of the matched file.")
  filename?: string;

  @doc("The relevance score of the result.")
  score?: float32;

  @doc("The matched text content.")
  text?: string;
}

@doc("The kind of a voice conversation item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceConversationItemType {
  string,
  message: "message",
  function_call: "function_call",
  function_call_output: "function_call_output",
  mcp_list_tools: "mcp_list_tools",
  mcp_call: "mcp_call",
  mcp_approval_request: "mcp_approval_request",
  mcp_approval_response: "mcp_approval_response",
  foundry_agent_call: "foundry_agent_call",
  web_search_call: "web_search_call",
  file_search_call: "file_search_call",
}

@doc("""
  A persisted item in a voice conversation. A discriminated union (by `type`) aligned to the Voice Live
  `RealtimeConversationResponseItem` variants plus persisted client-created request items. `created_at` and
  `response_id` are Foundry persistence extensions (`response_id` links an item to the response that produced
  it; absent for client-created request items).
  """)
@discriminator("type")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceConversationItem {
  @doc("The item kind.")
  type: VoiceConversationItemType;

  @doc("The unique id of the item.")
  id: string;

  @doc("The object type, e.g. `conversation.item`.")
  object?: string;

  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: int32;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

@doc("A message item (user, assistant, or system).")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMessageItem extends VoiceConversationItem {
  type: VoiceConversationItemType.message;

  @doc("The role of the message.")
  role: VoiceMessageRole;

  @doc("The content parts of the message.")
  content: VoiceContentPart[];

  @doc("The status of the item.")
  status?: VoiceItemStatus;

  @doc("Per-turn voice metrics (Foundry extension).")
  voice_metrics?: VoiceMetrics;
}

@doc("A function call request item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFunctionCallItem extends VoiceConversationItem {
  type: VoiceConversationItemType.function_call;

  @doc("The name of the function to call.")
  name: string;

  @doc("The arguments for the function call as a JSON string.")
  arguments: string;

  @doc("The unique id of the function call.")
  call_id: string;

  @doc("The status of the item.")
  status?: VoiceItemStatus;
}

@doc("A function call output item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFunctionCallOutputItem extends VoiceConversationItem {
  type: VoiceConversationItemType.function_call_output;

  @doc("The name of the function that was called.")
  name?: string;

  @doc("The output of the function call.")
  output: string;

  @doc("The unique id of the function call.")
  call_id: string;

  @doc("The status of the item.")
  status?: VoiceItemStatus;
}

@doc("An MCP list-tools item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpListToolsItem extends VoiceConversationItem {
  type: VoiceConversationItemType.mcp_list_tools;

  @doc("The label of the MCP server.")
  server_label: string;
}

@doc("An MCP call item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpCallItem extends VoiceConversationItem {
  type: VoiceConversationItemType.mcp_call;

  @doc("The label of the MCP server.")
  server_label: string;

  @doc("The name of the tool to call.")
  name: string;

  @doc("The approval request id associated with the call, when applicable.")
  approval_request_id?: string;

  @doc("The arguments for the MCP call.")
  arguments: string;

  @doc("The output of the MCP call.")
  output?: string;

  @doc("The error details if the MCP call failed.")
  error?: VoiceItemError;
}

@doc("An MCP approval request item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpApprovalRequestItem extends VoiceConversationItem {
  type: VoiceConversationItemType.mcp_approval_request;

  @doc("The label of the MCP server.")
  server_label: string;

  @doc("The name of the tool to call.")
  name: string;

  @doc("The arguments for the MCP call.")
  arguments: string;
}

@doc("An MCP approval response item (client-created).")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpApprovalResponseItem extends VoiceConversationItem {
  type: VoiceConversationItemType.mcp_approval_response;

  @doc("Whether the MCP request is approved.")
  approve: boolean;

  @doc("The id of the MCP approval request being responded to.")
  approval_request_id: string;
}

@doc("A Foundry agent call item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFoundryAgentCallItem extends VoiceConversationItem {
  type: VoiceConversationItemType.foundry_agent_call;

  @doc("The name of the Foundry agent.")
  name: string;

  @doc("The id of the call.")
  call_id: string;

  @doc("The arguments for the Foundry agent call as a JSON string.")
  arguments: string;

  @doc("The response id from the Foundry agent, when available.")
  agent_response_id?: string;

  @doc("The output of the Foundry agent call.")
  output?: string;

  @doc("The error details if the Foundry agent call failed.")
  error?: VoiceItemError;
}

@doc("A web search call item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceWebSearchCallItem extends VoiceConversationItem {
  type: VoiceConversationItemType.web_search_call;

  @doc("The status of the web search tool call, e.g. `in_progress`, `searching`, `completed`, `failed`.")
  status: string;
}

@doc("A file search call item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFileSearchCallItem extends VoiceConversationItem {
  type: VoiceConversationItemType.file_search_call;

  @doc("The queries used for the file search.")
  queries?: string[];

  @doc("The status of the file search tool call, e.g. `in_progress`, `searching`, `completed`, `incomplete`, `failed`.")
  status: string;

  @doc("The results of the file search.")
  results?: VoiceFileSearchResult[];
}

// ---------------------------------------------------------------------------
// Audio streaming
// ---------------------------------------------------------------------------

@doc("""
  Metadata for a single conversation item's audio segment. Exposes only safe, playback-relevant facts;
  internal storage identifiers (file id, container, host, owner, provider) are never surfaced. For
  bring-your-own-storage (BYOS) the response includes `blob_path` (a direct customer-storage path/URL, no SAS)
  that the customer downloads with their own credentials; for Foundry-managed storage `blob_path` is absent and
  the bytes are streamed via the item's `/audio/content` route instead.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceItemAudioResponse {
  @doc("The id of the conversation the item belongs to.")
  conversation_id: string;

  @doc("The id of the item this audio belongs to.")
  item_id: string;

  @doc("The role the audio belongs to, e.g. `user` or `agent`.")
  role?: string;

  @doc("The container format of the audio, e.g. `wav`.")
  format?: string;

  @doc("The audio codec, e.g. `pcm16`.")
  codec?: string;

  @doc("The sample rate in Hz.")
  sample_rate?: int32;

  @doc("The number of audio channels.")
  channels?: int32;

  @doc("The offset from the session start at which this segment begins, in milliseconds.")
  start_offset_ms?: int32;

  @doc("The duration of the audio segment, in milliseconds.")
  duration_ms?: int32;

  @doc("For bring-your-own-storage (BYOS) recordings only: a direct path/URL into the customer's own storage, without a SAS token — the customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the item's `/audio/content` route instead.")
  blob_path?: string;
}

@doc("A streamed WAV (`audio/wav`) audio response. The bytes are streamed through the service; no SAS URL is returned.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAudioStreamResponse {
  @doc("The content type of the streamed audio.")
  @header("Content-Type")
  contentType: "audio/wav";

  @doc("The WAV audio bytes.")
  @body
  content: bytes;
}
