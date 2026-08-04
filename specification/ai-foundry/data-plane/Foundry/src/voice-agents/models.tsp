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
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
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

@doc("The response returned when a voice conversation is deleted.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceDeletedConversation {
  @doc("The id of the deleted conversation.")
  id: string;

  @doc("The object type. Always `voice.conversation.deleted`.")
  object: "voice.conversation.deleted";

  @doc("Always `true` for a successful delete.")
  deleted: true;
}

// ---------------------------------------------------------------------------
// Voice response
// ---------------------------------------------------------------------------
//
// VoiceResponse cannot `extends OpenAI.RealtimeResponse`: overriding `audio` to the Foundry
// `{type, name}` voice shape fails TypeSpec's override-property-mismatch check (the override type must
// be a subtype of the inherited `OpenAI.RealtimeResponseAudio`, whose `voice` is the flat `VoiceIdsShared`
// string enum). So VoiceResponse remains a standalone model, but its other fields still match OpenAI's
// wire names/shapes 1:1 (output_modalities, max_output_tokens, status_details reusing
// OpenAI.RealtimeResponseStatusDetails) wherever no such conflict exists.

// Token usage statistics reuse OpenAI.RealtimeResponseUsage (total/input/output tokens plus
// input/output token detail breakdowns, including image_tokens and cached_tokens_details), already
// available in this program via ./src/openai/responses/main.tsp -> @azure-tools/openai-typespec's
// realtime models.tsp. See VoiceResponse.usage below.

@doc("The status of a voice response.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceResponseStatus {
  string,
  in_progress: "in_progress",
  completed: "completed",
  cancelled: "cancelled",
  incomplete: "incomplete",
  failed: "failed",
}

@doc("The complete typed voice configuration used for a response.")
union VoiceResponseVoice {
  OpenAIVoice,
  AzureVoice,
  AzureRealtimeNativeVoice,
}

@doc("The output audio format used for a response. Follows the OpenAI Realtime GA audio format discriminated union.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceResponseAudioOutput {
  @doc("The voice used for the response's audio output.")
  voice?: VoiceResponseVoice;

  @doc("The audio format used for the response's audio output.")
  format?: OpenAI.RealtimeAudioFormats;
}

@doc("Audio configuration for a response. Follows the OpenAI Realtime GA `audio` object shape.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceResponseAudio {
  @doc("The audio output configuration used for the response.")
  output?: VoiceResponseAudioOutput;
}

@doc("""
  A persisted voice response representing one model inference turn within a conversation. In list results the
  `output` projection may be omitted; retrieve the
  full response (`GET .../responses/{response_id}`) or the paged response-items route
  (`GET .../responses/{response_id}/items`) for its output items. `created_at`/`completed_at` are Foundry
  durable ordering extensions.
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
  status_details?: OpenAI.RealtimeResponseStatusDetails;

  @doc("The output items produced by the response. May be omitted in list results; retrieve the full response (GET .../responses/{response_id}) or use the paged response-items route (GET .../responses/{response_id}/items) for its output items. Each item's `response_id` also links it back to this response in the conversation-level items list.")
  output?: VoiceConversationItem[];

  @doc("Token usage statistics for the response.")
  usage?: OpenAI.RealtimeResponseUsage;

  @doc("The id of the conversation this response belongs to.")
  conversation_id: string;

  @doc("The audio configuration used for the response, including the voice and audio format used for output.")
  audio?: VoiceResponseAudio;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches OpenAI.RealtimeResponse.output_modalities: an inline literal array, not exported as a named union upstream."
  @doc("The output modalities used for the response, e.g. `[\"text\", \"audio\"]`. Audio output always includes a text transcript.")
  output_modalities?: ("text" | "audio")[];

  @doc("The sampling temperature used for the response.")
  temperature?: float32;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The contract represents this as an integer token count or the literal string 'inf'."
  @doc("The maximum number of output tokens allowed for the response; an integer or the literal `inf`.")
  max_output_tokens?: int32 | "inf";

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
// Conversation items — reused directly from OpenAI Realtime GA item models
// ---------------------------------------------------------------------------
//
// Each Voice item extends its OpenAI Realtime counterpart directly, adding only the two Foundry
// persistence extensions (`created_at`, `response_id`). `id`/`object`/`type`/`role`/`status` and all
// content/error/tool fields are inherited as-is from OpenAI, already available in this program via
// ./src/openai/responses/main.tsp -> @azure-tools/openai-typespec's realtime models.tsp.
//
// NOTE: OpenAI's vendor package splits items across two disconnected discriminator roots —
// `RealtimeConversationItem` (@discriminator("type"): function_call | function_call_output | mcp_*)
// and `RealtimeConversationItemMessage` (@discriminator("role"): system | user | assistant), which does
// NOT extend `RealtimeConversationItem` and isn't part of its `type` union. Because TypeSpec only
// supports single inheritance, one polymorphic base spanning all 9 item kinds (including `message`)
// isn't available upstream, so `VoiceConversationItem` below is a plain (non-discriminated) union of
// the 9 leaves rather than a single `@discriminator`-based type. This is a known upstream gap worth
// raising with @azure-tools/openai-typespec (unify message items under the shared item discriminator).

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeConversationItemMessageSystem via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("A system message item. Only `input_text` content is valid for system messages.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceSystemMessageItem
  extends OpenAI.RealtimeConversationItemMessageSystem {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeConversationItemMessageUser via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("A user message item. `input_text`, `input_audio`, and `input_image` content are valid for user messages.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceUserMessageItem extends OpenAI.RealtimeConversationItemMessageUser {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeConversationItemMessageAssistant via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("An assistant message item. Only `output_text` and `output_audio` content are valid for assistant messages.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceAssistantMessageItem
  extends OpenAI.RealtimeConversationItemMessageAssistant {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeConversationItemFunctionCall via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("A function call request item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFunctionCallItem
  extends OpenAI.RealtimeConversationItemFunctionCall {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeConversationItemFunctionCallOutput via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("A function call output item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceFunctionCallOutputItem
  extends OpenAI.RealtimeConversationItemFunctionCallOutput {
  @doc("The name of the function that was called. A Foundry extension: OpenAI's function_call_output does not carry the function name, only `call_id`.")
  name?: string;

  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeMCPListTools via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("An MCP list-tools item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpListToolsItem extends OpenAI.RealtimeMCPListTools {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeMCPToolCall via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("An MCP call item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpCallItem extends OpenAI.RealtimeMCPToolCall {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeMCPApprovalRequest via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("An MCP approval request item.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpApprovalRequestItem extends OpenAI.RealtimeMCPApprovalRequest {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentional: `extends` here reuses OpenAI.RealtimeMCPApprovalResponse via allOf+$ref (preserving a stable reference to the canonical OpenAI schema) rather than flattening its fields inline via spread."
@doc("An MCP approval response item (client-created).")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceMcpApprovalResponseItem extends OpenAI.RealtimeMCPApprovalResponse {
  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Spans two disconnected OpenAI discriminator roots (type vs role); see note above."
@doc("""
  A persisted item in a voice conversation. A plain union of the 9 OpenAI Realtime item kinds
  (message x3 roles, function_call, function_call_output, mcp_list_tools, mcp_call,
  mcp_approval_request, mcp_approval_response), each extended with the Foundry persistence extensions
  `created_at`/`response_id`. See the note above for why this is a plain union rather than a single
  `@discriminator`-based type.
  """)
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
union VoiceConversationItem {
  VoiceSystemMessageItem,
  VoiceUserMessageItem,
  VoiceAssistantMessageItem,
  VoiceFunctionCallItem,
  VoiceFunctionCallOutputItem,
  VoiceMcpListToolsItem,
  VoiceMcpCallItem,
  VoiceMcpApprovalRequestItem,
  VoiceMcpApprovalResponseItem,
}

// ---------------------------------------------------------------------------
// Audio streaming
// ---------------------------------------------------------------------------

@doc("""
  Metadata for a single conversation item's audio segment. For bring-your-own-storage (BYOS), the response includes
  `blob_uri`, a direct customer-storage URI without a SAS token, that the customer accesses with their own
  credentials. For Foundry-managed storage, `blob_uri` is absent and the bytes are streamed through the item's
  `/audio/content` route.
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

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the item's `/audio/content` route instead.")
  blob_uri?: url;
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

@doc("The role assigned to each channel of a merged stereo voice recording.")
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceRecordingChannelLayout {
  @doc("The role carried on the left channel, e.g. `user`.")
  left: string;

  @doc("The role carried on the right channel, e.g. `agent`.")
  right: string;
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
@extension("x-ms-foundry-meta", PromptVoiceAgentRequiredPreview)
model VoiceRecordingResponse {
  @doc("The id of the conversation this recording belongs to.")
  conversation_id: string;

  @doc("The container format of the recording, e.g. `wav`.")
  format: string;

  @doc("The sample rate of the recording in Hz, e.g. 24000.")
  sample_rate: int32;

  @doc("The number of audio channels. The merged recording is stereo (`2`).")
  channels: int32;

  @doc("The role assigned to each stereo channel.")
  channel_layout: VoiceRecordingChannelLayout;

  @doc("The total duration of the recording in milliseconds.")
  duration_ms: int32;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the `/audio/content` route instead.")
  blob_uri?: url;
}

// ---------------------------------------------------------------------------
// Agent telephony bindings
// ---------------------------------------------------------------------------

const AgentTelephonyConditionalPreviews = #{
  conditional_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

@doc("A telephony provider supported by an agent binding. The legacy input value `acs` is accepted for compatibility, but responses use `azure-communication-service`. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyProvider {
  string,

  @doc("Azure Communication Service, including Teams Phone Extensibility.")
  azure_communication_service: "azure-communication-service",

  @doc("Twilio Programmable Voice.")
  twilio: "twilio",

  @doc("Infobip Voice and Calls API.")
  infobip: "infobip",
}

@doc("The lifecycle status of a telephony binding.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyBindingStatus {
  string,
  active: "active",
  suspended: "suspended",
}

@doc("A destination type supported by a telephony transfer target.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyTransferDestinationKind {
  string,
  pstn: "pstn",
  teams: "teams",
  sip: "sip",
}

@doc("The provider-specific destination for a telephony transfer target.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyTransferDestination {
  @doc("The destination type.")
  kind: TelephonyTransferDestinationKind;

  @doc("The destination value, such as an E.164 phone number, Teams user identifier, or SIP URI.")
  value: string;
}

@doc("A named destination to which the voice agent may transfer a call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyTransferTarget {
  @doc("The unique name exposed to the voice agent for this transfer target.")
  name: string;

  @doc("A description that helps the voice agent decide when to use this target.")
  description: string;

  @doc("The provider-specific transfer destination.")
  destination: TelephonyTransferDestination;
}

@doc("The request to bind a telephony identifier to the voice agent named in the request path.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model CreateTelephonyBindingRequest {
  @doc("The telephony provider.")
  provider: TelephonyProvider;

  @doc("The provider-specific dialed identifier, such as an Azure Communication Service resource-account identifier or E.164 phone number.")
  identifier: string;

  @doc("The destinations to which the voice agent may transfer calls. This compatibility field replaces the agent-scoped transfer-target configuration when supplied.")
  transfer_targets?: TelephonyTransferTarget[];

  @doc("The Foundry connection that configures provider access. Azure Communication Service connections own the resource endpoint and identity. Twilio connections use the Account SID as their target and an ApiKey credential for the Auth Token.")
  connection_name: string;
}

@doc("The request to update an existing telephony binding.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model UpdateTelephonyBindingRequest {
  @doc("The ETag returned by the latest read. Updates with a stale ETag fail.")
  etag: string;

  @doc("The new lifecycle status.")
  status?: TelephonyBindingStatus;

  @doc("Replacement transfer targets. This compatibility field updates the agent-scoped configuration; an empty array clears all targets.")
  transfer_targets?: TelephonyTransferTarget[];

  @doc("The replacement Foundry connection that configures provider access.")
  connection_name?: string;
}

@doc("A telephony identifier bound to the voice agent named in the request path.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyBinding {
  @doc("The binding identifier in `{provider}:{identifier}` form.")
  id: string;

  @doc("The Foundry project that owns the binding.")
  project_id: string;

  @doc("The telephony provider.")
  provider: TelephonyProvider;

  @doc("The provider-specific dialed identifier.")
  identifier: string;

  @doc("The lifecycle status.")
  status: TelephonyBindingStatus;

  @doc("The agent-scoped destinations to which the voice agent may transfer calls.")
  transfer_targets: TelephonyTransferTarget[];

  @doc("The Foundry connection that configures provider access. Secrets are referenced, not returned.")
  connection_name: string;

  @doc("The service-generated webhook URL to configure with the telephony provider.")
  incoming_call_url: url;

  @doc("The current ETag for optimistic-concurrency updates.")
  etag?: string;
}

@doc("A page of telephony bindings for one voice agent.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyBindingList {
  @doc("The telephony bindings in this page.")
  @pageItems
  data: TelephonyBinding[];

  @doc("Whether another page of bindings is available.")
  has_more: boolean;

  @doc("The cursor to pass as `after` to retrieve the next page.")
  @continuationToken
  next_cursor?: string;
}

@doc("The lifecycle status of an inbound telephony call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallStatus {
  string,

  @doc("The call has started and has not reached a terminal state.")
  in_progress: "in_progress",

  @doc("The call ended successfully.")
  success: "success",

  @doc("The call ended because of a provider or management failure.")
  failed: "failed",
}

@doc("A durable history record for an inbound call to a voice agent.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallRecord {
  @doc("The service-generated call identifier.")
  id: string;

  @doc("The name of the voice agent that handled the call.")
  agent_name: string;

  @doc("The telephony provider.")
  provider: TelephonyProvider;

  @doc("The provider-assigned call identifier, when available.")
  provider_call_id?: string;

  @doc("The caller's phone number, when supplied by the provider.")
  caller_number?: string;

  @doc("The Azure Communication Service or Twilio number that received the call.")
  provider_number?: string;

  @doc("The lifecycle status of the call.")
  status: TelephonyCallStatus;

  @doc("The Unix timestamp (in seconds) for when the call started.")
  started_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call connected.")
  connected_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call ended.")
  ended_at?: FoundryTimestamp;

  @doc("The call duration in seconds.")
  duration_seconds?: int64;

  @doc("The service-generated reason that the call ended.")
  end_reason?: string;

  @doc("The provider status code associated with the terminal result.")
  provider_status_code?: int32;

  @doc("The provider subcode associated with the terminal result.")
  provider_sub_code?: int32;

  @doc("The provider message associated with the terminal result.")
  provider_message?: string;
}

@doc("A page of inbound telephony call records for one voice agent.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallRecordList {
  @doc("The call records in this page.")
  @pageItems
  data: TelephonyCallRecord[];

  @doc("Whether another page of call records is available.")
  has_more: boolean;

  @doc("The cursor to pass as `after` to retrieve the next page.")
  @continuationToken
  next_cursor?: string;
}

@doc("A command that can be applied to an active telephony call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallManageCommand {
  string,

  @doc("Hang up the call.")
  hangup: "hangup",

  @doc("Transfer the call to a configured transfer target.")
  transfer: "transfer",
}

@doc("A request to manage an active telephony call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallManageRequest {
  @doc("The operation to perform on the call.")
  command: TelephonyCallManageCommand;

  @doc("For a transfer command, the name of a transfer target configured for the voice agent.")
  target?: string;
}

@doc("The telephony transfer targets configured for one voice agent.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyTransferTargets {
  @doc("The complete set of destinations to which the voice agent may transfer calls. An empty array clears all targets when replacing the configuration.")
  transfer_targets: TelephonyTransferTarget[];
}
