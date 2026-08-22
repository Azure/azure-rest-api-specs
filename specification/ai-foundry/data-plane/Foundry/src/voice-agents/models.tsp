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

@doc("""
  The lifecycle status of a persisted voice conversation:
  - `in_progress`: the live session is active, or post-session persistence finalization is pending.
  - `completed`: finalization succeeded after normal or client close, `end_conversation`, a max-duration `1001`
    close, or a client or network disconnect that the service can still finalize.
  - `failed`: a terminal service, bridge, storage, or unrecoverable transport failure prevented finalization.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceConversationStatus {
  string,

  @doc("The live session is active, or post-session persistence finalization is still pending.")
  in_progress: "in_progress",

  @doc("Persistence finalization succeeded. This includes normal or client-initiated close, the `end_conversation` system tool, a max-duration `1001` close, and client or network disconnects that the service can still finalize.")
  completed: "completed",

  @doc("A terminal service, bridge, storage, or unrecoverable transport failure prevented persistence finalization.")
  failed: "failed",
}

@doc("""
  A persisted voice conversation. The Foundry envelope that owns a voice agent's stored
  transcript, responses, per-turn metrics, and audio. It is the parent, retention, and delete boundary:
  deleting it cascades to its responses, items, metrics, and audio. When finalization fails, any partial persisted
  responses, items, and item audio remain readable.
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

  @doc("The Unix timestamp (in seconds) for when session and persistence finalization reached the terminal `completed` or `failed` status. Absent while `status` is `in_progress`.")
  completed_at?: FoundryTimestamp;

  @doc("A set of key-value pairs attached to the conversation.")
  metadata?: Record<string>;

  @doc("Final aggregate token usage across all responses in this conversation. Absent while `status` is `in_progress` and populated after successful `completed` finalization; it may be absent when `status` is `failed`, and values are not guaranteed to be reported incrementally.")
  usage?: OpenAI.RealtimeResponseUsage;

  @doc("The terminal error that prevented persistence finalization. Present only when `status` is `failed`.")
  last_error?: ApiError;
}

// ---------------------------------------------------------------------------
// Shared voice response audio
// ---------------------------------------------------------------------------
//
// Live WebSocket events and persisted responses use the same flat output projection so provider and
// locale extensions stay aligned with the OpenAI-compatible voice and format fields.

@doc("The flat response audio-output projection, with optional `voice`, `voice_type`, `voice_locale`, and `format` fields.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudioOutput {
  @doc("The voice name used for the response's audio output.")
  voice?: string;

  @doc("The extensible provider/type of the voice used for the response's audio output.")
  voice_type?: VoiceType;

  @doc("The BCP-47 locale of the voice used for the response's audio output.")
  voice_locale?: string;

  @doc("The audio format used for the response's audio output.")
  format?: OpenAI.RealtimeAudioFormats;
}

@doc("Audio configuration for a response. Follows the OpenAI Realtime GA `audio` object shape.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudio {
  @doc("The audio output configuration used for the response.")
  output?: VoiceResponseAudioOutput;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the shared OpenAI response contract while the persisted projection replaces audio, output, and metadata."
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
@doc("""
  A persisted voice response representing one model inference turn within a conversation. In list results the
  `output` projection may be omitted; retrieve the
  full response (`GET .../responses/{response_id}`) or the paged response-items route
  (`GET .../responses/{response_id}/items`) for its output items. `created_at`/`completed_at` are Foundry
  durable ordering extensions.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponse extends OmitProperties<
  OpenAI.RealtimeResponse,
  "audio" | "output" | "metadata"
> {
  @doc("The unique id of the response.")
  id: string;

  @doc("The output items produced by the response. May be omitted in list results; retrieve the full response (GET .../responses/{response_id}) or use the paged response-items route (GET .../responses/{response_id}/items) for its output items. Each item's `response_id` also links it back to this response in the conversation-level items list.")
  output?: VoiceConversationItem[];

  @doc("The id of the conversation this response belongs to.")
  conversation_id: string;

  @doc("The audio configuration used for the response, including the voice and audio format used for output.")
  audio?: VoiceResponseAudio;

  @doc("A set of key-value pairs attached to the response.")
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches OpenAI.RealtimeResponse.output_modalities: an inline literal array, not exported as a named union upstream."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Type kept for backward compatibility"
  @doc("The output modalities used for the response, e.g. `[\"text\", \"audio\"]`. Audio output always includes a text transcript.")
  output_modalities?: ("text" | "audio")[];

  @doc("The sampling temperature used for the response.")
  temperature?: float32;

  @doc("The Unix timestamp (in seconds) for when the response was created.")
  created_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the response completed.")
  completed_at?: FoundryTimestamp;
}

// ---------------------------------------------------------------------------
// Conversation items — OpenAI Realtime hierarchy with Foundry persistence data
// ---------------------------------------------------------------------------

alias VoiceConversationItemPersistence = {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  @visibility(Lifecycle.Read)
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  @visibility(Lifecycle.Read)
  response_id?: string;
};

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Voice conversation items extend the corresponding OpenAI Realtime item models and are selected by their inherited `type` and `role` properties."
@doc("A persisted item in a voice conversation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@oneOf
union VoiceConversationItem {
  system: VoiceSystemMessageItem,
  user: VoiceUserMessageItem,
  assistant: VoiceAssistantMessageItem,
  function_call: VoiceFunctionCallItem,
  function_call_output: VoiceFunctionCallOutputItem,
  mcp_list_tools: VoiceMcpListToolsItem,
  mcp_call: VoiceMcpCallItem,
  mcp_approval_request: VoiceMcpApprovalRequestItem,
  mcp_approval_response: VoiceMcpApprovalResponseItem,
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("A system message item. Only `input_text` content is valid for system messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSystemMessageItem
  extends OpenAI.RealtimeConversationItemMessageSystem {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("A user message item. `input_text`, `input_audio`, and `input_image` content are valid for user messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceUserMessageItem extends OpenAI.RealtimeConversationItemMessageUser {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("An assistant message item. Only `output_text` and `output_audio` content are valid for assistant messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAssistantMessageItem
  extends OpenAI.RealtimeConversationItemMessageAssistant {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("A function call request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallItem
  extends OpenAI.RealtimeConversationItemFunctionCall {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("A function call output item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallOutputItem
  extends OpenAI.RealtimeConversationItemFunctionCallOutput {
  ...VoiceConversationItemPersistence;

  @doc("The name of the function that was called. A Foundry extension: OpenAI's function_call_output does not carry the function name, only `call_id`.")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("An MCP list-tools item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpListToolsItem extends OpenAI.RealtimeMCPListTools {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("An MCP call item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpCallItem extends OpenAI.RealtimeMCPToolCall {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("An MCP approval request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalRequestItem extends OpenAI.RealtimeMCPApprovalRequest {
  ...VoiceConversationItemPersistence;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the matching OpenAI Realtime leaf preserves one SDK inheritance path while adding Foundry persistence fields."
@doc("An MCP approval response item (client-created).")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalResponseItem extends OpenAI.RealtimeMCPApprovalResponse {
  ...VoiceConversationItemPersistence;
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

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
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
  start_offset_ms?: FoundryDurationMilliseconds;

  @doc("The duration of the audio segment.")
  duration_ms?: FoundryDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the item's `/audio/content` route instead.")
  blob_uri?: url;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
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

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Keeping for backward compatibility."
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
  duration_ms: FoundryDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the `/audio/content` route instead.")
  blob_uri?: url;
}
