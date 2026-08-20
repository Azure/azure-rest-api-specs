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
  voice_type?: string;

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

// ---------------------------------------------------------------------------
// Agent telephony bindings
// ---------------------------------------------------------------------------

const AgentTelephonyConditionalPreviews = #{
  conditional_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

@doc("A telephony provider supported by an agent binding. New bindings use `teams-phone-extension` or `twilio`. Legacy provider values remain accepted so existing clients and stored bindings continue to work. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyProvider {
  string,

  @doc("Microsoft Teams Phone Extension.")
  teams_phone_extension: "teams-phone-extension",

  @doc("Twilio Programmable Voice.")
  twilio: "twilio",

  @doc("Legacy Azure Communication Service provider value. New bindings use `teams-phone-extension`.")
  azure_communication_service: "azure-communication-service",

  @doc("Legacy shorthand for Azure Communication Service. New bindings use `teams-phone-extension`.")
  acs: "acs",

  @doc("Legacy Infobip Voice and Calls API provider value. New bindings cannot be created for this provider.")
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

@doc("Legacy provider configuration accepted as a compatibility input. New clients use the provider-specific top-level connection field.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyProviderConfig {
  @doc("The Foundry connection name.")
  connection_name?: string;

  @doc("Legacy Azure Communication Service connection-name alias.")
  acs_connection_name?: string;

  @doc("Legacy Azure Communication Service resource identifier.")
  acs_resource_id?: string;

  @doc("Legacy Azure Communication Service endpoint.")
  acs_endpoint?: url;

  @doc("Legacy managed identity client identifier.")
  mi_client_id?: string;

  @doc("Legacy cognitive services customer identifier.")
  cognitive_service_customer_id?: string;

  @doc("Legacy provider account reference.")
  account_ref?: string;

  @doc("Legacy Foundry project connection reference.")
  project_connection_id?: string;

  @doc("Legacy credential secret reference.")
  credential_secret_ref?: string;
}

@doc("The compatibility request to bind a telephony identifier to the voice agent named in the request path. New clients use a provider-specific request model selected by `provider`.")
@discriminator("provider")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model CreateTelephonyBindingRequest {
  @doc("The telephony provider. New bindings use `teams-phone-extension` or `twilio`; legacy aliases remain accepted for existing clients.")
  provider: TelephonyProvider;

  @doc("Legacy provider identifier. New Teams Phone Extension requests use `resource_account_object_id`; new Twilio requests use `phone_number`.")
  identifier?: string;

  @doc("The Teams Phone Extension Foundry connection name. Required when `provider` is `teams-phone-extension`.")
  azure_communication_service_connection_name?: string;

  @doc("The Twilio Foundry connection name. Required when `provider` is `twilio`.")
  twilio_connection_name?: string;

  @doc("The provider-specific phone number. It is optional display metadata for Teams Phone Extension and a required E.164 number for Twilio.")
  @maxLength(64)
  phone_number?: string;

  @doc("An optional display label for the binding.")
  @maxLength(128)
  label?: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID. Required when `provider` is `teams-phone-extension`.")
  resource_account_object_id?: string;

  @doc("Legacy optional display phone number alias. New clients use `phone_number`.")
  @maxLength(64)
  display_phone_number?: string;

  @doc("The destinations to which the voice agent may transfer calls. This compatibility field replaces the agent-scoped transfer-target configuration when supplied.")
  transfer_targets?: TelephonyTransferTarget[];

  @doc("Legacy generic Foundry connection name. New clients use the provider-specific connection field.")
  connection_name?: string;

  @doc("Legacy nested provider configuration. New clients use the provider-specific top-level connection field.")
  provider_config?: TelephonyProviderConfig;
}

@doc("The request to create a Microsoft Teams Phone Extension binding.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model CreateTeamsPhoneExtensionTelephonyBindingRequest
  extends CreateTelephonyBindingRequest {
  @doc("The Microsoft Teams Phone Extension provider.")
  provider: "teams-phone-extension";

  @doc("The Teams Phone Extension Foundry connection name.")
  azure_communication_service_connection_name: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID.")
  resource_account_object_id: string;
}

@doc("The request to create a Twilio binding. New clients supply the provider-specific fields; legacy `identifier` and connection aliases remain accepted.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model CreateTwilioTelephonyBindingRequest
  extends CreateTelephonyBindingRequest {
  @doc("The Twilio provider.")
  provider: "twilio";

  @doc("The Twilio Foundry connection name. Required for new clients; legacy connection aliases remain accepted for compatibility.")
  twilio_connection_name?: string;

  @doc("The Twilio E.164 phone number. Required for new clients; the legacy `identifier` alias remains accepted for compatibility.")
  @pattern("^\\+[1-9]\\d{6,14}$")
  phone_number?: string;
}

@doc("The request to update an existing telephony binding.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model UpdateTelephonyBindingRequest {
  @doc("The ETag returned by the latest read. Updates with a stale ETag fail.")
  etag: string;

  @doc("The new lifecycle status.")
  status?: TelephonyBindingStatus;

  @doc("The replacement Teams Phone Extension Foundry connection name.")
  azure_communication_service_connection_name?: string;

  @doc("The Twilio Foundry connection name. It must match the existing immutable value when supplied.")
  twilio_connection_name?: string;

  @doc("The replacement Teams display phone number. For Twilio it must match the immutable binding number. Omit it to preserve the current value; use a blank Teams value to clear it.")
  @maxLength(64)
  phone_number?: string;

  @doc("The replacement display label. Omit it to preserve the current value; use a blank value to clear it.")
  @maxLength(128)
  label?: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID. It must match the immutable existing value when supplied.")
  resource_account_object_id?: string;

  @doc("Legacy optional display phone number alias. New clients use `phone_number`.")
  @maxLength(64)
  display_phone_number?: string;

  @doc("Replacement transfer targets. This compatibility field updates the agent-scoped configuration; an empty array clears all targets.")
  transfer_targets?: TelephonyTransferTarget[];

  @doc("Legacy replacement generic Foundry connection name. New clients use the provider-specific connection field.")
  connection_name?: string;

  @doc("Legacy nested provider configuration. New clients use the provider-specific top-level connection field.")
  provider_config?: TelephonyProviderConfig;
}

@doc("A telephony identifier bound to the voice agent named in the request path.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyBinding {
  @doc("The binding identifier in `{provider}:{identifier}` form.")
  id: string;

  @doc("The Foundry project that owns the binding.")
  project_id: string;

  @doc("The telephony provider. New bindings return `teams-phone-extension` or `twilio`; legacy bindings can return a legacy provider value.")
  provider: TelephonyProvider;

  @doc("The Teams Phone Extension Foundry connection name. Omitted for other providers.")
  azure_communication_service_connection_name?: string;

  @doc("The Twilio Foundry connection name. Omitted for other providers.")
  twilio_connection_name?: string;

  @doc("The provider-specific phone number. It is optional display metadata for Teams Phone Extension and the dialed E.164 number for Twilio.")
  @maxLength(64)
  phone_number?: string;

  @doc("The optional display label for the binding.")
  @maxLength(128)
  label?: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID. Omitted for other providers and older bindings that do not contain it.")
  resource_account_object_id?: string;

  @doc("The legacy provider-specific dialed identifier retained for existing clients.")
  identifier: string;

  @doc("The legacy optional display phone number alias retained for existing clients.")
  @maxLength(64)
  display_phone_number?: string;

  @doc("The lifecycle status.")
  status: TelephonyBindingStatus;

  @doc("The agent-scoped destinations to which the voice agent may transfer calls.")
  transfer_targets: TelephonyTransferTarget[];

  @doc("The legacy generic Foundry connection name retained for existing clients. Secrets are referenced, not returned.")
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

@doc("The provider-neutral phase reached by an inbound telephony call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallPhase {
  string,

  @doc("The provider webhook was received.")
  received: "received",

  @doc("The provider webhook was validated.")
  validated: "validated",

  @doc("The call was admitted to a configured agent binding.")
  admitted: "admitted",

  @doc("The provider was asked to answer the call.")
  answering: "answering",

  @doc("The provider reported that the call was answered.")
  answered: "answered",

  @doc("The provider media channel was connected.")
  media_connected: "media_connected",

  @doc("The voice-agent session was ready.")
  agent_session_ready: "agent_session_ready",

  @doc("Media was actively bridged between the caller and the voice agent.")
  bridging: "bridging",

  @doc("A mid-call management command was in progress.")
  managing: "managing",

  @doc("The call completed.")
  completed: "completed",

  @doc("The call was rejected before admission or answer.")
  rejected: "rejected",

  @doc("The call failed.")
  failed: "failed",
}

@doc("The source of a telephony lifecycle timestamp.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallTimestampSource {
  string,

  @doc("The telephony provider supplied the timestamp.")
  provider: "provider",

  @doc("The Foundry telephony gateway observed the event.")
  gateway: "gateway",

  @doc("The service derived the timestamp from another observation.")
  derived: "derived",

  @doc("The timestamp came from a record created before detailed timing was available.")
  legacy: "legacy",
}

@doc("The timestamp used as the basis for call duration.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallDurationBasis {
  string,

  @doc("Duration starts when the provider reports the call as answered.")
  answered: "answered",

  @doc("Duration starts when the inbound webhook is received because no answered timestamp is available.")
  received: "received",

  @doc("Duration uses the legacy connected timestamp.")
  legacy_connected: "legacy_connected",

  @doc("Duration uses the legacy call-start timestamp.")
  legacy_started: "legacy_started",
}

@doc("Detailed provider-neutral timing for an inbound telephony call. Millisecond values are Unix timestamps.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallTiming {
  @doc("When the provider webhook was received, as Unix time in milliseconds.")
  received_at_ms?: int64;

  @doc("When webhook validation completed, as Unix time in milliseconds.")
  validated_at_ms?: int64;

  @doc("When the call was admitted to an agent binding, as Unix time in milliseconds.")
  admitted_at_ms?: int64;

  @doc("When the service requested that the provider answer the call, as Unix time in milliseconds.")
  answer_requested_at_ms?: int64;

  @doc("When the provider reported that the call was answered, as Unix time in milliseconds.")
  answered_at_ms?: int64;

  @doc("When the provider media channel connected, as Unix time in milliseconds.")
  media_connected_at_ms?: int64;

  @doc("When the voice-agent session became ready, as Unix time in milliseconds.")
  agent_session_ready_at_ms?: int64;

  @doc("When caller audio was first observed, as Unix time in milliseconds.")
  first_caller_audio_at_ms?: int64;

  @doc("When agent audio was first observed, as Unix time in milliseconds.")
  first_agent_audio_at_ms?: int64;

  @doc("When the call reached a terminal state, as Unix time in milliseconds.")
  ended_at_ms?: int64;

  @doc("The timestamp used as the basis for duration.")
  duration_basis?: TelephonyCallDurationBasis;

  @doc("The source of the lifecycle timestamps.")
  timestamp_source: TelephonyCallTimestampSource;
}

@doc("The mode used to expose a telephony call as a customer-facing Foundry trace.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallTraceMode {
  string,

  @doc("The trace was created while the voice-agent conversation was live.")
  live: "live",

  @doc("The trace summarizes a trusted call that ended before a live voice-agent conversation was created.")
  post_call: "post_call",
}

@doc("The availability status of a customer-facing telephony call trace.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallTraceStatus {
  string,

  @doc("Trace creation has not completed.")
  pending: "pending",

  @doc("Trace creation is in progress.")
  emitting: "emitting",

  @doc("The trace is available.")
  available: "available",

  @doc("Tracing was disabled or no trace listener recorded the call.")
  not_recorded: "not_recorded",

  @doc("The call was not eligible for a customer-facing trace.")
  not_applicable: "not_applicable",

  @doc("Trace creation failed.")
  failed: "failed",
}

@doc("Correlation from a durable telephony call record to its customer-facing Foundry trace.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallTrace {
  @doc("The trace availability status.")
  status: TelephonyCallTraceStatus;

  @doc("The W3C trace identifier, when a trace was recorded.")
  trace_id?: string;

  @doc("The root span identifier, when a trace was recorded.")
  root_span_id?: string;

  @doc("The voice-agent conversation identifier, when a conversation was created.")
  conversation_id?: string;

  @doc("Whether the trace was emitted live or after the call ended.")
  mode?: TelephonyCallTraceMode;
}

@doc("The outcome of one telephony lifecycle observation.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallLifecycleEventOutcome {
  string,

  @doc("The event was observed without a success or failure result.")
  observed: "observed",

  @doc("The operation started.")
  started: "started",

  @doc("The operation succeeded.")
  succeeded: "succeeded",

  @doc("The operation failed.")
  failed: "failed",

  @doc("The operation or call was rejected.")
  rejected: "rejected",

  @doc("The operation was cancelled.")
  cancelled: "cancelled",
}

@doc("The component that supplied a telephony lifecycle observation.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
union TelephonyCallLifecycleEventSource {
  string,

  @doc("The Foundry telephony gateway supplied the observation.")
  gateway: "gateway",

  @doc("Azure Communication Services supplied the observation.")
  azure_communication_services: "azure_communication_services",

  @doc("Twilio supplied the observation.")
  twilio: "twilio",

  @doc("The voice-agent runtime supplied the observation.")
  voice_agent: "voice_agent",
}

@doc("A bounded durable observation in the lifecycle of one telephony call.")
@extension("x-ms-foundry-meta", AgentTelephonyConditionalPreviews)
model TelephonyCallLifecycleEvent {
  @doc("The service-assigned order of the event within the call record.")
  sequence: int64;

  @doc("The stable provider-neutral event name.")
  name: string;

  @doc("The component that supplied the observation.")
  source: TelephonyCallLifecycleEventSource;

  @doc("The outcome of the observed lifecycle operation.")
  outcome: TelephonyCallLifecycleEventOutcome;

  @doc("When the service observed the event, as Unix time in milliseconds.")
  observed_at_ms: int64;

  @doc("When the event occurred according to the provider, as Unix time in milliseconds.")
  occurred_at_ms?: int64;

  @doc("The source of the event timestamp.")
  timestamp_source: TelephonyCallTimestampSource;

  @doc("A stable service-generated reason associated with the event.")
  reason?: string;

  @doc("The provider event identifier used for idempotency, when supplied.")
  provider_event_id?: string;

  @doc("The provider event sequence, when supplied.")
  provider_sequence?: int64;

  @doc("The provider status code associated with the event.")
  provider_status_code?: int32;

  @doc("The provider subcode associated with the event.")
  provider_sub_code?: int32;
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

  @doc("The provider-neutral lifecycle phase reached by the call.")
  phase: TelephonyCallPhase;

  @doc("The Unix timestamp (in seconds) for when the call started.")
  started_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call connected.")
  connected_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider reported the call as answered.")
  answered_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider media channel connected.")
  media_connected_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the voice-agent session became ready.")
  agent_session_ready_at?: FoundryTimestamp;

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

  @doc("The W3C trace identifier, when a customer-facing trace was recorded.")
  trace_id?: string;

  @doc("Detailed provider-neutral call timing. Returned by the call detail operation.")
  timing?: TelephonyCallTiming;

  @doc("Correlation to the customer-facing Foundry trace. Returned by the call detail operation.")
  trace?: TelephonyCallTrace;

  @doc("The bounded lifecycle timeline. Returned by the call detail operation.")
  events?: TelephonyCallLifecycleEvent[];

  @doc("Whether older lifecycle events were omitted because the bounded event limit was reached. Returned by the call detail operation.")
  events_truncated?: boolean;
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

/** The entity tag and transfer targets configured for one voice agent. */
alias TelephonyTransferTargetsResponse = TelephonyTransferTargets & {
  @doc("The entity tag to send in the `If-Match` header when replacing the transfer targets.")
  @header("ETag")
  etag: Azure.Core.eTag;
};

/** The optimistic-concurrency precondition for replacing a voice agent's transfer targets. */
alias TelephonyTransferTargetsIfMatchHeader = {
  @doc("The entity tag returned by the latest read. The replacement fails if the transfer targets changed since that read.")
  @header("If-Match")
  ifMatch: string;
};
