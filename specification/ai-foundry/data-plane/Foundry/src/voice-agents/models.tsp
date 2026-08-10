import "@typespec/http";
import "@typespec/openapi";
import "../agents/models.tsp";
import "./agents.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ============================================================================
// Persisted voice conversation resources.
//
// These models describe the durable, read-only projection of a voice agent's
// conversation using conversation, response, item, and usage resources. Raw
// audio bytes are streamed through the dedicated item and recording routes.
// ============================================================================

@doc("The lifecycle status of a persisted voice conversation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceConversationStatus {
  string,

  @doc("The conversation's live session is still in progress.")
  in_progress: "in_progress",

  @doc("The conversation's live session has ended.")
  completed: "completed",
}

@doc("""
  A persisted voice conversation. The Foundry envelope that owns a voice agent's stored
  transcript, responses, per-turn metrics, and audio. It is the parent, retention, and delete boundary:
  deleting it cascades to its responses, items, metrics, and audio.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceConversation {
  @doc("The unique id of the conversation.")
  id: string;

  @doc("The object type. Always `voice.conversation`.")
  object: "voice.conversation";

  @doc("The lifecycle status of the conversation.")
  status: VoiceConversationStatus;

  @doc("The Unix timestamp (in seconds) for when the conversation was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the conversation's session ended. Absent while in progress.")
  completed_at?: FoundryTimestamp;

  @doc("A set of key-value pairs attached to the conversation.")
  metadata?: Record<string>;

  @doc("Aggregate token usage totals across all responses in this conversation.")
  usage?: OpenAI.RealtimeResponseUsage;
}

// ---------------------------------------------------------------------------
// Voice response
// ---------------------------------------------------------------------------
//
// The projected base omits audio because Foundry's typed voice objects are not assignable to the
// upstream flat VoiceIdsShared string.

@doc("The complete typed voice configuration used for a response.")
union VoiceResponseVoice {
  OpenAIVoice,
  AzureVoice,
  AzureRealtimeNativeVoice,
}

@doc("The output audio format used for a response. Follows the OpenAI Realtime GA audio format discriminated union.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudioOutput {
  @doc("The voice used for the response's audio output.")
  voice?: VoiceResponseVoice;

  @doc("The audio format used for the response's audio output.")
  format?: OpenAI.RealtimeAudioFormats;
}

@doc("Audio configuration for a response. Follows the OpenAI Realtime GA `audio` object shape.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudio {
  @doc("The audio output configuration used for the response.")
  output?: VoiceResponseAudioOutput;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the shared OpenAI response contract while the projection removes the four intentionally different properties."
@doc("""
  A persisted voice response representing one model inference turn within a conversation. In list results the
  `output` projection may be omitted; retrieve the
  full response (`GET .../responses/{response_id}`) or the paged response-items route
  (`GET .../responses/{response_id}/items`) for its output items. `created_at`/`completed_at` are Foundry
  durable ordering extensions.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponse extends OmitProperties<OpenAI.RealtimeResponse, "audio"> {
  @doc("The unique id of the response.")
  id: string;

  @doc("The output items produced by the response. May be omitted in list results; retrieve the full response (GET .../responses/{response_id}) or use the paged response-items route (GET .../responses/{response_id}/items) for its output items. Each item's `response_id` also links it back to this response in the conversation-level items list.")
  output?: VoiceConversationItem[];

  @doc("The id of the conversation this response belongs to.")
  conversation_id: string;

  @doc("The audio configuration used for the response, including the voice and audio format used for output.")
  audio?: VoiceResponseAudio;

  @doc("The sampling temperature used for the response.")
  temperature?: float32;

  @doc("The Unix timestamp (in seconds) for when the response was created.")
  created_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the response completed.")
  completed_at?: FoundryTimestamp;
}

// Message content parts reuse OpenAI's Realtime message content models directly (per-role, inline
// `text`/`audio`/`image_url`/`transcript`/`detail` fields, matching the OpenAI GA wire format exactly,
// including base64 inline audio), already available in this program via
// ./src/openai/responses/main.tsp -> @azure-tools/openai-typespec's realtime models.tsp:
//   - OpenAI.RealtimeConversationItemMessageSystemContent (system: input_text only)
//   - OpenAI.RealtimeConversationItemMessageUserContent (user: input_text | input_audio | input_image)
//   - OpenAI.RealtimeConversationItemMessageAssistantContent (assistant: output_text | output_audio)
// See the three role variants (VoiceSystemMessageItem, VoiceUserMessageItem, VoiceAssistantMessageItem)
// below, each of which extends its OpenAI role-specific message model directly.

// ---------------------------------------------------------------------------
// Conversation items — OpenAI Realtime fields with Foundry persistence data
// ---------------------------------------------------------------------------

@doc("The type of a persisted voice conversation item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceConversationItemType {
  string,

  @doc("A message item.")
  message: "message",

  @doc("A function-call request item.")
  function_call: "function_call",

  @doc("A function-call output item.")
  function_call_output: "function_call_output",

  @doc("An MCP list-tools item.")
  mcp_list_tools: "mcp_list_tools",

  @doc("An MCP call item.")
  mcp_call: "mcp_call",

  @doc("An MCP approval request item.")
  mcp_approval_request: "mcp_approval_request",

  @doc("An MCP approval response item.")
  mcp_approval_response: "mcp_approval_response",
}

@doc("A persisted item in a voice conversation.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceConversationItem {
  @doc("The type of the conversation item.")
  type: VoiceConversationItemType;

  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

@doc("A persisted message item in a voice conversation.")
@discriminator("role")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMessageItem extends VoiceConversationItem {
  type: VoiceConversationItemType.message;

  @doc("The role of the message sender.")
  role: OpenAI.RealtimeConversationItemMessageType;
}

@doc("A system message item. Only `input_text` content is valid for system messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSystemMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageSystem,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.system;
}

@doc("A user message item. `input_text`, `input_audio`, and `input_image` content are valid for user messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceUserMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageUser,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.user;
}

@doc("An assistant message item. Only `output_text` and `output_audio` content are valid for assistant messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAssistantMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageAssistant,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.assistant;
}

@doc("A function call request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeConversationItemFunctionCall, "type">;
  type: VoiceConversationItemType.function_call;
}

@doc("A function call output item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallOutputItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeConversationItemFunctionCallOutput, "type">;
  type: VoiceConversationItemType.function_call_output;

  @doc("The name of the function that was called. A Foundry extension: OpenAI's function_call_output does not carry the function name, only `call_id`.")
  name?: string;
}

@doc("An MCP list-tools item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpListToolsItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPListTools, "type">;
  type: VoiceConversationItemType.mcp_list_tools;
}

@doc("An MCP call item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpCallItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPToolCall, "type">;
  type: VoiceConversationItemType.mcp_call;
}

@doc("An MCP approval request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalRequestItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPApprovalRequest, "type">;
  type: VoiceConversationItemType.mcp_approval_request;
}

@doc("An MCP approval response item (client-created).")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalResponseItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPApprovalResponse, "type">;
  type: VoiceConversationItemType.mcp_approval_response;
}

// ---------------------------------------------------------------------------
// Audio streaming
// ---------------------------------------------------------------------------

@doc("A voice-audio participant role. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioRole {
  string,

  @doc("Audio produced by the user.")
  user: "user",

  @doc("Audio produced by the agent.")
  agent: "agent",
}

@doc("An audio container format. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioContainerFormat {
  string,

  @doc("Waveform Audio File Format.")
  wav: "wav",
}

@doc("An audio codec. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioCodec {
  string,

  @doc("16-bit pulse-code modulation.")
  pcm16: "pcm16",

  @doc("G.711 mu-law.")
  pcmu: "pcmu",

  @doc("G.711 A-law.")
  pcma: "pcma",
}

#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice recording contract requires integer-millisecond durations."
@doc("A duration encoded as an integer number of milliseconds.")
@encode(DurationKnownEncoding.milliseconds, int32)
scalar VoiceDurationMilliseconds extends duration;

@doc("""
  Metadata for a single conversation item's audio segment. For bring-your-own-storage (BYOS), the response includes
  `blob_uri`, a direct customer-storage URI without a SAS token, that the customer accesses with their own
  credentials. For Foundry-managed storage, `blob_uri` is absent and the bytes are streamed through the item's
  `/audio/content` route.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceItemAudioResponse {
  @doc("The id of the conversation the item belongs to.")
  conversation_id: string;

  @doc("The id of the item this audio belongs to.")
  item_id: string;

  @doc("The role the audio belongs to.")
  role?: VoiceAudioRole;

  @doc("The container format of the audio.")
  format?: VoiceAudioContainerFormat;

  @doc("The audio codec.")
  codec?: VoiceAudioCodec;

  @doc("The sample rate in Hz.")
  sample_rate?: int32;

  @doc("The number of audio channels.")
  channels?: int32;

  @doc("The offset from the session start at which this segment begins.")
  start_offset_ms?: VoiceDurationMilliseconds;

  @doc("The duration of the audio segment.")
  duration_ms?: VoiceDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the item's `/audio/content` route instead.")
  blob_uri?: url;
}

@doc("A streamed WAV (`audio/wav`) audio response. The bytes are streamed through the service; no SAS URL is returned.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioStreamResponse {
  @doc("The content type of the streamed audio.")
  @header("Content-Type")
  contentType: "audio/wav";

  @doc("The WAV audio bytes.")
  @body
  content: bytes;
}

@doc("The role assigned to each channel of a merged stereo voice recording.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceRecordingChannelLayout {
  @doc("The role carried on the left channel. Always `user`.")
  left: "user";

  @doc("The role carried on the right channel. Always `agent`.")
  right: "agent";
}

@doc("""
  Metadata for the merged, whole-call stereo recording of a voice conversation (user audio on the left channel,
  agent audio on the right). Built once from the per-turn segments after the session ends and durably cached.
  The common metadata (format, sample rate, channels, channel layout, duration) is returned for both
  Foundry-managed and bring-your-own-storage (BYOS) recordings. For BYOS the response also includes `blob_uri`,
  the URI of the recording in the customer's own storage (no SAS token), which the customer downloads using their
  own storage credentials. For Foundry-managed storage `blob_uri` is absent and the bytes are streamed via the
  `/audio/content` route instead.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceRecordingResponse {
  @doc("The id of the conversation this recording belongs to.")
  conversation_id: string;

  @doc("The container format of the recording.")
  format: VoiceAudioContainerFormat;

  @doc("The sample rate of the recording in Hz, e.g. 24000.")
  sample_rate: int32;

  @doc("The number of audio channels. The merged recording is stereo (`2`).")
  channels: int32;

  @doc("The role assigned to each stereo channel.")
  channel_layout: VoiceRecordingChannelLayout;

  @doc("The total duration of the recording.")
  duration_ms: VoiceDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the `/audio/content` route instead.")
  blob_uri?: url;
}
