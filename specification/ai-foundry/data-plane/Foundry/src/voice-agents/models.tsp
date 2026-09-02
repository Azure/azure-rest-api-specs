import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "../agents/models.tsp";
import "./agents.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Experimental;
using Azure.ClientGenerator.Core;

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

@doc("Properties shared by persisted voice responses.")
model VoiceResponseBase {
  ...OmitProperties<OpenAI.RealtimeResponse, "audio" | "output" | "metadata">;
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
model VoiceResponse extends VoiceResponseBase {
  @doc("The unique id of the response.")
  id: string;

  @doc("The output items produced by the response. May be omitted in list results; retrieve the full response (GET .../responses/{response_id}) or use the paged response-items route (GET .../responses/{response_id}/items) for its output items. Each item's `response_id` also links it back to this response in the conversation-level items list.")
  output?: OpenAI.RealtimeConversationItem[];

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

@@extension(
  OpenAI.RealtimeConversationItem,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

@@extension(
  OpenAI.RealtimeConversationItemMessageSystem,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeConversationItemMessageSystem,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeConversationItemMessageUser,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeConversationItemMessageUser,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeConversationItemMessageAssistant,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeConversationItemMessageAssistant,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeConversationItemFunctionCall,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeConversationItemFunctionCall,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeConversationItemFunctionCallOutput,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeConversationItemFunctionCallOutput,
  {
    ...VoiceConversationItemPersistence,

    @doc("The name of the function that was called. A Foundry extension: OpenAI's function_call_output does not carry the function name, only `call_id`.")
    name?: string,
  }
);

@@extension(
  OpenAI.RealtimeMCPListTools,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeMCPListTools,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeMCPToolCall,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeMCPToolCall,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeMCPApprovalRequest,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeMCPApprovalRequest,
  {
    ...VoiceConversationItemPersistence,
  }
);

@@extension(
  OpenAI.RealtimeMCPApprovalResponse,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeMCPApprovalResponse,
  {
    ...VoiceConversationItemPersistence,
  }
);

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

// ---------------------------------------------------------------------------
// Agent telephony bindings
// ---------------------------------------------------------------------------

@doc("A service-generated telephony binding identifier.")
@minLength(1)
@maxLength(128)
scalar TelephonyBindingId extends string;

@doc("A service-generated telephony call identifier.")
@minLength(1)
@maxLength(128)
scalar TelephonyCallId extends string;

@doc("The unique name of a telephony transfer target.")
@minLength(1)
@maxLength(64)
@pattern("^[A-Za-z0-9][A-Za-z0-9_-]{0,63}$")
scalar TelephonyTransferTargetName extends string;

@doc("A telephony provider supported by an agent binding. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyProvider {
  string,

  @doc("Microsoft Teams Phone Extension.")
  teams_phone_extension: "teams_phone_extension",

  @doc("Twilio Programmable Voice.")
  twilio: "twilio",
}

@doc("The lifecycle status of a telephony binding.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyBindingStatus {
  string,

  @doc("The binding accepts new inbound calls.")
  active: "active",

  @doc("The binding remains configured but rejects new inbound calls.")
  suspended: "suspended",
}

@doc("A PSTN destination for a telephony transfer target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model PSTNTelephonyTransferDestination {
  @doc("The PSTN destination type.")
  kind: "pstn";

  @doc("The E.164 phone number to call.")
  @pattern("^\\+[1-9]\\d{6,14}$")
  value: string;
}

@doc("A Microsoft Teams destination for a telephony transfer target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TeamsTelephonyTransferDestination {
  @doc("The Microsoft Teams destination type.")
  kind: "teams";

  @doc("The Microsoft Teams user or resource-account identifier.")
  @minLength(1)
  @maxLength(256)
  value: string;
}

@doc("A SIP destination for a telephony transfer target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model SipTelephonyTransferDestination {
  @doc("The SIP destination type.")
  kind: "sip";

  @doc("The SIP or SIPS URI to call.")
  value: url;
}

@doc("A destination for a telephony transfer target.")
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyTransferDestination {
  @doc("A public switched telephone network destination.")
  pstn: PSTNTelephonyTransferDestination,

  @doc("A Microsoft Teams user or resource-account destination.")
  teams: TeamsTelephonyTransferDestination,

  @doc("A Session Initiation Protocol destination.")
  sip: SipTelephonyTransferDestination,
}

@doc("A named destination to which the voice agent may transfer a call.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyTransferTarget {
  @doc("The unique name exposed to the voice agent for this transfer target.")
  @key
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: TelephonyTransferTargetName;

  @doc("A description that helps the voice agent decide when to use this target.")
  @minLength(1)
  @maxLength(1024)
  description: string;

  @doc("The provider-specific transfer destination.")
  destination: TelephonyTransferDestination;
}

@doc("The request to create a Microsoft Teams Phone Extension binding.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@clientName("CreateTeamsPhoneExtensionTelephonyBindingContent", "csharp")
model CreateTeamsPhoneExtensionTelephonyBindingRequest {
  @doc("The Microsoft Teams Phone Extension provider.")
  provider: "teams_phone_extension";

  @doc("The Foundry connection name for the Teams Phone Extension provider.")
  @minLength(1)
  @maxLength(256)
  connection: string;

  @doc("The optional display phone number for the Teams resource account.")
  @maxLength(64)
  phone_number?: string;

  @doc("An optional display label for the binding.")
  @maxLength(128)
  label?: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID.")
  resource_account_object_id: Azure.Core.uuid;
}

@doc("The request to create a Twilio binding.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@clientName("CreateTwilioTelephonyBindingContent", "csharp")
model CreateTwilioTelephonyBindingRequest {
  @doc("The Twilio provider.")
  provider: "twilio";

  @doc("The Foundry connection name for the Twilio provider.")
  @minLength(1)
  @maxLength(256)
  connection: string;

  @doc("The Twilio E.164 phone number.")
  @pattern("^\\+[1-9]\\d{6,14}$")
  phone_number: string;

  @doc("An optional display label for the binding.")
  @maxLength(128)
  label?: string;
}

@doc("The request to create a telephony binding.")
@discriminated(#{ envelope: "none", discriminatorPropertyName: "provider" })
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union CreateTelephonyBindingRequest {
  @doc("A Microsoft Teams Phone Extension binding request.")
  teams_phone_extension: CreateTeamsPhoneExtensionTelephonyBindingRequest,

  @doc("A Twilio binding request.")
  twilio: CreateTwilioTelephonyBindingRequest,
}

@doc("The request to update an existing telephony binding. Every property is optional and the binding's provider is immutable.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@clientName("UpdateTelephonyBindingContent", "csharp")
model UpdateTelephonyBindingRequest {
  @doc("The new lifecycle status.")
  status?: TelephonyBindingStatus;

  @doc("The replacement display label. Omit it to preserve the current value; use null to clear it.")
  @maxLength(128)
  label?: string | null;

  @doc("The replacement Foundry connection name. This property is valid only for a Teams Phone Extension binding; a Twilio binding's connection is immutable.")
  @minLength(1)
  @maxLength(256)
  connection?: string;

  @doc("The replacement Teams Phone Extension display phone number. Omit it to preserve the current value; use null to clear it. This property is valid only for a Teams Phone Extension binding.")
  @maxLength(64)
  phone_number?: string | null;
}

@doc("A Microsoft Teams Phone Extension binding owned by a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TeamsPhoneExtensionTelephonyBinding {
  @doc("The service-generated binding identifier.")
  id: TelephonyBindingId;

  @doc("The Microsoft Teams Phone Extension provider.")
  provider: "teams_phone_extension";

  @doc("The Foundry connection name for the Teams Phone Extension provider.")
  @minLength(1)
  @maxLength(256)
  connection: string;

  @doc("The optional display phone number for the Teams resource account.")
  @maxLength(64)
  phone_number?: string;

  @doc("The optional display label for the binding.")
  @maxLength(128)
  label?: string;

  @doc("The Microsoft Teams resource-account object identifier as a GUID.")
  resource_account_object_id: Azure.Core.uuid;

  @doc("The lifecycle status.")
  status: TelephonyBindingStatus;

  @doc("The service-generated webhook URL to configure with the telephony provider.")
  incoming_call_url: url;
}

@doc("A Twilio binding owned by a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TwilioTelephonyBinding {
  @doc("The service-generated binding identifier.")
  id: TelephonyBindingId;

  @doc("The Twilio provider.")
  provider: "twilio";

  @doc("The Foundry connection name for the Twilio provider.")
  @minLength(1)
  @maxLength(256)
  connection: string;

  @doc("The Twilio E.164 phone number.")
  @pattern("^\\+[1-9]\\d{6,14}$")
  phone_number: string;

  @doc("The optional display label for the binding.")
  @maxLength(128)
  label?: string;

  @doc("The lifecycle status.")
  status: TelephonyBindingStatus;

  @doc("The service-generated webhook URL to configure with Twilio.")
  incoming_call_url: url;
}

@doc("A telephony binding owned by a voice agent.")
@discriminated(#{ envelope: "none", discriminatorPropertyName: "provider" })
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyBinding {
  @doc("A Microsoft Teams Phone Extension binding.")
  teams_phone_extension: TeamsPhoneExtensionTelephonyBinding,

  @doc("A Twilio binding.")
  twilio: TwilioTelephonyBinding,
}

@doc("A Microsoft Teams Phone Extension binding returned in a list, including its entity tag.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TeamsPhoneExtensionTelephonyBindingListItem {
  ...TeamsPhoneExtensionTelephonyBinding;

  @doc("The entity tag to send in the `If-Match` header when updating or deleting this binding.")
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;
}

@doc("A Twilio binding returned in a list, including its entity tag.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TwilioTelephonyBindingListItem {
  ...TwilioTelephonyBinding;

  @doc("The entity tag to send in the `If-Match` header when updating or deleting this binding.")
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;
}

@doc("A telephony binding returned in a list, including its entity tag.")
@discriminated(#{ envelope: "none", discriminatorPropertyName: "provider" })
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyBindingListItem {
  @doc("A Microsoft Teams Phone Extension binding list item.")
  teams_phone_extension: TeamsPhoneExtensionTelephonyBindingListItem,

  @doc("A Twilio binding list item.")
  twilio: TwilioTelephonyBindingListItem,
}

/** A telephony binding response with its entity tag. */
alias TelephonyBindingResponse = {
  @doc("The telephony binding.")
  @bodyRoot
  body: TelephonyBinding;

  @doc("The entity tag to send in the `If-Match` header when updating or deleting the binding.")
  @header("ETag")
  etag: Azure.Core.eTag;
};

/** A newly created telephony binding response. */
alias TelephonyBindingCreatedResponse = TypeSpec.Http.Response<201> &
  TelephonyBindingResponse;

/** The optimistic-concurrency precondition for mutating a telephony resource. */
alias TelephonyIfMatchHeader = {
  @doc("The entity tag returned by the latest read. The request fails if the resource changed since that read.")
  @header("If-Match")
  ifMatch: Azure.Core.eTag;
};

@doc("The lifecycle status of an inbound telephony call.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCallTimestampSource {
  string,

  @doc("The telephony provider supplied the timestamp.")
  provider: "provider",

  @doc("The Foundry telephony gateway observed the event.")
  gateway: "gateway",

  @doc("The service derived the timestamp from another observation.")
  derived: "derived",
}

@doc("The timestamp used as the basis for call duration.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCallDurationBasis {
  string,

  @doc("Duration starts when the provider reports the call as answered.")
  answered: "answered",

  @doc("Duration starts when the inbound webhook is received because no answered timestamp is available.")
  received: "received",
}

@doc("Detailed provider-neutral timing for an inbound telephony call.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCallTiming {
  @doc("The Unix timestamp (in seconds) for when the provider webhook was received.")
  received_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when webhook validation completed.")
  validated_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call was admitted to an agent binding.")
  admitted_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the service requested that the provider answer the call.")
  answer_requested_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider reported that the call was answered.")
  answered_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider media channel connected.")
  media_connected_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the voice-agent session became ready.")
  agent_session_ready_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when caller audio was first observed.")
  first_caller_audio_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when agent audio was first observed.")
  first_agent_audio_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call reached a terminal state.")
  ended_at?: FoundryTimestamp;

  @doc("The timestamp used as the basis for duration.")
  duration_basis?: TelephonyCallDurationBasis;

  @doc("The primary source of the timing milestones. Individual lifecycle events identify their own timestamp source separately.")
  timestamp_source: TelephonyCallTimestampSource;
}

@doc("The mode used to expose a telephony call as a customer-facing Foundry trace.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCallTraceMode {
  string,

  @doc("The trace was created while the voice-agent conversation was live.")
  live: "live",

  @doc("The trace summarizes a validated, customer-owned call that ended before a live voice-agent conversation was created.")
  post_call: "post_call",
}

@doc("The availability status of a customer-facing telephony call trace.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCallTrace {
  @doc("The trace availability status.")
  status: TelephonyCallTraceStatus;

  @doc("The W3C trace identifier, when a trace was recorded.")
  @pattern("^[0-9a-f]{32}$")
  trace_id?: string;

  @doc("The root span identifier, when a trace was recorded.")
  @pattern("^[0-9a-f]{16}$")
  root_span_id?: string;

  @doc("The voice-agent conversation identifier, when a conversation was created.")
  @maxLength(256)
  conversation_id?: string;

  @doc("Whether the trace was emitted live or after the call ended.")
  mode?: TelephonyCallTraceMode;
}

@doc("The outcome of one telephony lifecycle observation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
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
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCallLifecycleEventSource {
  string,

  @doc("The Foundry telephony gateway supplied the observation.")
  gateway: "gateway",

  @doc("Microsoft Teams Phone Extension supplied the observation.")
  teams_phone_extension: "teams_phone_extension",

  @doc("Twilio supplied the observation.")
  twilio: "twilio",

  @doc("The voice-agent runtime supplied the observation.")
  voice_agent: "voice_agent",
}

@doc("A provider-neutral lifecycle event name. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union TelephonyCallLifecycleEventName {
  string,

  @doc("The provider webhook was received.")
  webhook_received: "telephony.webhook.received",

  @doc("The provider webhook was validated.")
  webhook_validation: "telephony.webhook.validation",

  @doc("The service attempted to resolve the agent binding.")
  binding_resolve: "telephony.binding.resolve",

  @doc("The service requested or observed provider answer state.")
  provider_answer: "telephony.provider.answer",

  @doc("The provider media channel changed connection state.")
  media_connect: "telephony.media.connect",

  @doc("The voice-agent session changed connection state.")
  agent_session_connect: "telephony.agent_session.connect",

  @doc("The first caller audio was observed.")
  first_caller_audio: "telephony.media.first_caller_audio",

  @doc("The first agent audio was observed.")
  first_agent_audio: "telephony.media.first_agent_audio",

  @doc("A call transfer changed state.")
  call_transfer: "telephony.call.transfer",

  @doc("A call hang-up changed state.")
  call_hangup: "telephony.call.hangup",

  @doc("The call disconnected.")
  call_disconnect: "telephony.call.disconnect",
}

@doc("A bounded durable observation in the lifecycle of one telephony call.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCallLifecycleEvent {
  @doc("The service-assigned order of the event within the call record.")
  @key
  @visibility(Lifecycle.Read)
  @minValue(1)
  sequence: int64;

  @doc("The stable provider-neutral event name.")
  name: TelephonyCallLifecycleEventName;

  @doc("The component that supplied the observation.")
  source: TelephonyCallLifecycleEventSource;

  @doc("The outcome of the observed lifecycle operation.")
  outcome: TelephonyCallLifecycleEventOutcome;

  @doc("The Unix timestamp (in seconds) for when the service observed the event.")
  observed_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the event occurred according to the provider.")
  occurred_at?: FoundryTimestamp;

  @doc("The source of the event timestamp.")
  timestamp_source: TelephonyCallTimestampSource;

  @doc("A stable service-generated reason associated with the event.")
  @maxLength(128)
  reason?: string;

  @doc("The provider event identifier used for idempotency, when supplied.")
  @maxLength(256)
  provider_event_id?: string;

  @doc("The provider event sequence, when supplied.")
  @minValue(0)
  provider_sequence?: int64;

  @doc("The provider status code associated with the event.")
  @minValue(0)
  provider_status_code?: int32;

  @doc("The provider subcode associated with the event.")
  @minValue(0)
  provider_sub_code?: int32;
}

@doc("A summary of a durable inbound call to a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCallSummary {
  @doc("The service-generated call identifier.")
  id: TelephonyCallId;

  @doc("The telephony provider.")
  provider: TelephonyProvider;

  @doc("The provider-assigned call identifier, when available.")
  @maxLength(256)
  provider_call_id?: string;

  @doc("The caller's phone number, when supplied by the provider.")
  @maxLength(64)
  caller_number?: string;

  @doc("The Teams Phone Extension or Twilio number that received the call.")
  @maxLength(64)
  provider_number?: string;

  @doc("The lifecycle status of the call.")
  status: TelephonyCallStatus;

  @doc("The provider-neutral lifecycle phase reached by the call.")
  phase: TelephonyCallPhase;

  @doc("The Unix timestamp (in seconds) for when the inbound webhook was received.")
  started_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider reported the call as answered.")
  answered_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the provider media channel connected.")
  media_connected_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the voice-agent session became ready.")
  agent_session_ready_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the call ended.")
  ended_at?: FoundryTimestamp;

  @doc("The call duration.")
  duration_ms?: FoundryDurationMilliseconds;

  @doc("The service-generated reason that the call ended.")
  @maxLength(128)
  end_reason?: string;

  @doc("The provider status code associated with the terminal result.")
  @minValue(0)
  provider_status_code?: int32;

  @doc("The provider subcode associated with the terminal result.")
  @minValue(0)
  provider_sub_code?: int32;

  @doc("The provider message associated with the terminal result.")
  @maxLength(2048)
  provider_message?: string;
}

@doc("Detailed diagnostics for a durable inbound call to a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TelephonyCallRecord {
  ...TelephonyCallSummary;

  @doc("Detailed provider-neutral call timing.")
  timing: TelephonyCallTiming;

  @doc("Correlation to the customer-facing Foundry trace.")
  trace?: TelephonyCallTrace;

  @doc("The lifecycle timeline.")
  events: TelephonyCallLifecycleEvent[];

  @doc("Whether older lifecycle events were omitted from the timeline.")
  events_truncated: boolean;
}

@doc("A request to transfer an active telephony call to a configured target.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@clientName("TelephonyCallTransferContent", "csharp")
model TelephonyCallTransferRequest {
  @doc("The name of a transfer target configured for the voice agent.")
  target: TelephonyTransferTargetName;
}

@doc("The telephony transfer targets configured for one voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
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
