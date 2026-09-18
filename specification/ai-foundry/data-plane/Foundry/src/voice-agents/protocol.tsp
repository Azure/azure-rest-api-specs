import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

namespace Azure.AI.Projects;

// cspell:ignore kbps viseme

alias VoiceAgentClientEventUsage = Usage.input | Usage.json;
alias VoiceAgentServerEventUsage = Usage.output | Usage.json;
alias VoiceAgentWebSocketMessageUsage = Usage.input | Usage.output | Usage.json;

@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentClientEventTypeExtension {
  session_avatar_connect: "session.avatar.connect",
  rtc_call_sdp_create: "rtc.call.sdp.create",
}

@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentServerEventTypeExtension {
  warning: "warning",
  session_subagent_started: "session.subagent.started",
  session_subagent_completed: "session.subagent.completed",
  session_subagent_aborted: "session.subagent.aborted",
  session_avatar_connecting: "session.avatar.connecting",
  session_avatar_switch_to_speaking: "session.avatar.switch_to_speaking",
  session_avatar_switch_to_idle: "session.avatar.switch_to_idle",
  rtc_call_sdp_created: "rtc.call.sdp.created",
  rtc_call_error: "rtc.call.error",
  response_audio_timestamp_delta: "response.audio_timestamp.delta",
  response_audio_timestamp_done: "response.audio_timestamp.done",
  response_animation_blendshapes_delta: "response.animation_blendshapes.delta",
  response_animation_blendshapes_done: "response.animation_blendshapes.done",
  response_animation_viseme_delta: "response.animation_viseme.delta",
  response_animation_viseme_done: "response.animation_viseme.done",
  response_video_delta: "response.video.delta",
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Registering Voice-only literals in the imported OpenAI discriminator union preserves a single polymorphic hierarchy."
@@copyVariants(
  OpenAI.RealtimeClientEventType,
  VoiceAgentClientEventTypeExtension
);
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Registering Voice-only literals in the imported OpenAI discriminator union preserves a single polymorphic hierarchy."
@@copyVariants(
  OpenAI.RealtimeServerEventType,
  VoiceAgentServerEventTypeExtension
);

@doc("The WebSocket subprotocol supported by a voice-agent connection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentWebSocketSubprotocol {
  realtime: "realtime",
}

@doc("The transport used for a voice-agent connection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentTransport {
  string,

  @doc("Signaling and audio are exchanged as JSON events over the WebSocket. This is the default.")
  websocket: "websocket",

  @doc("WebRTC: the WebSocket carries only SDP signaling; media and the data channel are peer-to-peer.")
  webrtc: "webrtc",
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "A WebSocket message may be sent by either the client or the server."
@doc("A JSON text message exchanged over an established voice-agent WebSocket. Audio bytes are base64-encoded in JSON event fields.")
@usage(VoiceAgentWebSocketMessageUsage)
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentWebSocketMessage {
  client: VoiceAgentClientEvent,
  server: VoiceAgentServerEvent,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Client WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by a client over a voice-agent WebSocket.")
@usage(VoiceAgentClientEventUsage)
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentClientEvent {
  conversation_item_create: OpenAI.RealtimeClientEventConversationItemCreate,
  conversation_item_delete: OpenAI.RealtimeClientEventConversationItemDelete,
  conversation_item_retrieve: OpenAI.RealtimeClientEventConversationItemRetrieve,
  conversation_item_truncate: OpenAI.RealtimeClientEventConversationItemTruncate,
  input_audio_buffer_append: OpenAI.RealtimeClientEventInputAudioBufferAppend,
  input_audio_buffer_clear: OpenAI.RealtimeClientEventInputAudioBufferClear,
  output_audio_buffer_clear: OpenAI.RealtimeClientEventOutputAudioBufferClear,
  input_audio_buffer_commit: OpenAI.RealtimeClientEventInputAudioBufferCommit,
  response_cancel: OpenAI.RealtimeClientEventResponseCancel,
  response_create: OpenAI.RealtimeClientEventResponseCreate,
  session_update: VoiceAgentClientEventSessionUpdate,
  session_avatar_connect: VoiceAgentClientEventSessionAvatarConnect,
  rtc_call_sdp_create: VoiceAgentClientEventRtcCallSdpCreate,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Server WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by the service over a voice-agent WebSocket.")
@usage(VoiceAgentServerEventUsage)
@oneOf
// `conversation.created` is replaced by `session.created.conversation_id`, the canonical persisted-conversation id.
// `input_audio_buffer.dtmf_event_received` is telephony-only and excluded with the rest of the telephony call-control surface.
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentServerEvent {
  conversation_item_added: OpenAI.RealtimeServerEventConversationItemAdded,
  conversation_item_created: OpenAI.RealtimeServerEventConversationItemCreated,
  conversation_item_deleted: OpenAI.RealtimeServerEventConversationItemDeleted,
  conversation_item_done: OpenAI.RealtimeServerEventConversationItemDone,
  conversation_item_input_audio_transcription_completed: OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  conversation_item_input_audio_transcription_delta: OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  conversation_item_input_audio_transcription_failed: OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  conversation_item_input_audio_transcription_segment: OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionSegment,
  conversation_item_retrieved: OpenAI.RealtimeServerEventConversationItemRetrieved,
  conversation_item_truncated: OpenAI.RealtimeServerEventConversationItemTruncated,
  input_audio_buffer_cleared: OpenAI.RealtimeServerEventInputAudioBufferCleared,
  input_audio_buffer_committed: OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  input_audio_buffer_speech_started: OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  input_audio_buffer_speech_stopped: OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  input_audio_buffer_timeout_triggered: OpenAI.RealtimeServerEventInputAudioBufferTimeoutTriggered,
  mcp_list_tools_completed: OpenAI.RealtimeServerEventMCPListToolsCompleted,
  mcp_list_tools_failed: OpenAI.RealtimeServerEventMCPListToolsFailed,
  mcp_list_tools_in_progress: OpenAI.RealtimeServerEventMCPListToolsInProgress,
  output_audio_buffer_cleared: OpenAI.RealtimeServerEventOutputAudioBufferCleared,
  rate_limits_updated: OpenAI.RealtimeServerEventRateLimitsUpdated,
  response_output_audio_delta: OpenAI.RealtimeServerEventResponseAudioDelta,
  response_output_audio_done: OpenAI.RealtimeServerEventResponseAudioDone,
  response_output_audio_transcript_delta: OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  response_output_audio_transcript_done: OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  response_content_part_added: OpenAI.RealtimeServerEventResponseContentPartAdded,
  response_content_part_done: OpenAI.RealtimeServerEventResponseContentPartDone,
  response_created: OpenAI.RealtimeServerEventResponseCreated,
  response_done: OpenAI.RealtimeServerEventResponseDone,
  response_function_call_arguments_delta: OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  response_function_call_arguments_done: OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  response_mcp_call_arguments_delta: OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta,
  response_mcp_call_arguments_done: OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone,
  response_mcp_call_completed: OpenAI.RealtimeServerEventResponseMCPCallCompleted,
  response_mcp_call_failed: OpenAI.RealtimeServerEventResponseMCPCallFailed,
  response_mcp_call_in_progress: OpenAI.RealtimeServerEventResponseMCPCallInProgress,
  response_output_item_added: OpenAI.RealtimeServerEventResponseOutputItemAdded,
  response_output_item_done: OpenAI.RealtimeServerEventResponseOutputItemDone,
  response_output_text_delta: OpenAI.RealtimeServerEventResponseTextDelta,
  response_output_text_done: OpenAI.RealtimeServerEventResponseTextDone,
  session_created: OpenAI.RealtimeServerEventSessionCreated,
  session_subagent_started: VoiceAgentServerEventSessionSubagentStarted,
  session_subagent_completed: VoiceAgentServerEventSessionSubagentCompleted,
  session_subagent_aborted: VoiceAgentServerEventSessionSubagentAborted,
  session_updated: OpenAI.RealtimeServerEventSessionUpdated,
  error: OpenAI.RealtimeServerEventError,
  warning: VoiceAgentServerEventWarning,
  session_avatar_connecting: VoiceAgentServerEventSessionAvatarConnecting,
  rtc_call_sdp_created: VoiceAgentServerEventRtcCallSdpCreated,
  rtc_call_error: VoiceAgentServerEventRtcCallError,
  session_avatar_switch_to_speaking: VoiceAgentServerEventSessionAvatarSwitchToSpeaking,
  session_avatar_switch_to_idle: VoiceAgentServerEventSessionAvatarSwitchToIdle,
  response_audio_timestamp_delta: VoiceAgentServerEventResponseAudioTimestampDelta,
  response_audio_timestamp_done: VoiceAgentServerEventResponseAudioTimestampDone,
  response_animation_blendshapes_delta: VoiceAgentServerEventResponseAnimationBlendshapesDelta,
  response_animation_blendshapes_done: VoiceAgentServerEventResponseAnimationBlendshapesDone,
  response_animation_viseme_delta: VoiceAgentServerEventResponseAnimationVisemeDelta,
  response_animation_viseme_done: VoiceAgentServerEventResponseAnimationVisemeDone,
  response_video_delta: VoiceAgentServerEventResponseVideoDelta,
}

@doc("An animation output produced by a voice-agent session.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentAnimationOutputType {
  blendshapes: "blendshapes",
  viseme_id: "viseme_id",
}

@doc("Animation settings for a voice-agent session.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentAnimationConfig {
  @doc("The animation model name.")
  model_name?: string = "default";

  @doc("The requested animation output kinds.")
  outputs?: VoiceAgentAnimationOutputType[] = #[
    VoiceAgentAnimationOutputType.blendshapes
  ];
}

@doc("An ICE server used for avatar WebRTC negotiation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentAvatarIceServer {
  /** The STUN or TURN server URLs used for ICE negotiation. */
  urls: url[];

  /** The username used to authenticate with the ICE server. */
  username?: string | null;

  /** The credential used to authenticate with the ICE server. */
  @secret
  credential?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "The session model is a wire-compatible specialization of the persisted avatar configuration and adds only runtime transport fields."
@doc("Avatar settings accepted by the stable voice-agent WebSocket contract.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentSessionAvatarConfig extends VoiceAgentAvatarConfig {
  /** The ICE servers used to establish the avatar's WebRTC connection. */
  ice_servers?: VoiceAgentAvatarIceServer[] | null;
}

@doc("The stable realtime session settings accepted in a `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentSessionUpdateConfig {
  @doc("The session type. Always `realtime`.")
  type: "realtime";

  @doc("Instructions applied throughout the session.")
  instructions?: string;

  @doc("The sampling temperature for compatible cascaded pipelines.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches the service's integer-or-inf token limit."
  @doc("The maximum output-token count for one response.")
  max_output_tokens?: VoiceAgentMaxOutputTokens;

  @doc("The output modalities enabled for the session.")
  output_modalities?: VoiceOutputModality[];

  @doc("The input- and output-audio settings for the session.")
  audio?: VoiceAgentAudioConfig;

  @doc("The avatar settings for the session.")
  avatar?: VoiceAgentSessionAvatarConfig;

  @doc("Animation settings for the session.")
  animation?: VoiceAgentAnimationConfig;

  @doc("Tools available to the session.")
  tools?: VoiceAgentTool[];

  @doc("Tool-selection behavior for the session.")
  tool_choice?: VoiceAgentToolChoice;

  @doc("Reasoning settings for compatible realtime models.")
  reasoning?: OpenAI.RealtimeReasoning;

  @doc("Whether the model may call multiple tools in parallel.")
  parallel_tool_calls?: boolean;

  @doc("Additional fields to include in service outputs.")
  include?: VoiceAgentSessionIncludeOption[];

  @doc("Up to 16 string key-value pairs attached to the session.")
  metadata?: Record<string>;

  @doc("Interim-response settings for latency and tool execution.")
  interim_response?: VoiceAgentInterimResponseConfig;

  @doc("A proactive assistant greeting started after session configuration.")
  greeting?: VoiceAgentGreetingConfig;
}

@doc("The session configuration accepted by a voice-agent session update event.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentSessionUpdate {
  voice_agent: VoiceAgentSessionUpdateConfig,
}

@doc("The effective stable realtime session settings returned by the voice-agent service.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentSessionResponseConfig {
  ...VoiceAgentSessionUpdateConfig;

  @doc("The object type. Always `realtime.session`.")
  object: "realtime.session";

  @doc("The session identifier.")
  id: string;

  @doc("The selected model.")
  `model`: string;

  @doc("The session expiration time as a Unix timestamp in seconds.")
  expires_at?: FoundryTimestamp | null;
}

@doc("The effective session configuration returned in voice-agent session lifecycle events.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentSessionResponse {
  voice_agent: VoiceAgentSessionResponseConfig,
}

@doc("Parameters accepted by a voice-agent `response.create` event.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentResponseCreateParams {
  ...OmitProperties<
    OpenAI.RealtimeResponseCreateParams,
    "prompt" | "output_modalities" | "audio" | "input"
  >;

  @doc("Modalities that the response may return.")
  output_modalities?: VoiceOutputModality[];

  @doc("Response-specific audio settings.")
  audio?: PickProperties<VoiceAgentAudioConfig, "output">;

  @doc("Conversation items used as inline response input.")
  input?: OpenAI.RealtimeConversationItem[];

  @doc("A pre-generated assistant message used to begin the response.")
  pre_generated_assistant_message?: OpenAI.RealtimeConversationItem | null;

  @doc("Interim-response settings for this response.")
  interim_response?: VoiceAgentInterimResponseConfig | null;
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeServerEventResponseContentPartDonePart,
  {
    @doc("The audio format, when this is an audio content part.")
    format?: OpenAI.RealtimeAudioFormats,
  }
);

@doc("Properties shared by realtime responses returned by the voice-agent service.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentRealtimeResponseBase {
  ...OmitProperties<OpenAI.RealtimeResponse, "audio" | "output">;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the upstream live response contract, including conversation_id, while replacing audio and output."
@doc("A live realtime response returned by the voice-agent service in both `response.created` and `response.done` events.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentRealtimeResponse extends VoiceAgentRealtimeResponseBase {
  @doc("The audio configuration used by the live response, including flat voice provider, locale, and format fields under `output`.")
  audio?: VoiceResponseAudio;

  @doc("The items produced by the live response.")
  output?: OpenAI.RealtimeConversationItem[];
}

@doc("A time-stamped word in an input-audio transcription.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentTranscriptionWord {
  @doc("The transcribed word text.")
  text: string;

  @doc("The word offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: FoundryDurationMilliseconds;

  @doc("The word duration in milliseconds.")
  duration_milliseconds: FoundryDurationMilliseconds;
}

@doc("A transcribed phrase with timing information.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentTranscriptionPhrase {
  @doc("The phrase offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: FoundryDurationMilliseconds;

  @doc("The phrase duration in milliseconds.")
  duration_milliseconds: FoundryDurationMilliseconds;

  @doc("The transcribed phrase text.")
  text: string;

  @doc("Word-level timing details, when available.")
  words?: VoiceAgentTranscriptionWord[] | null;

  @doc("The detected locale.")
  locale?: string | null;

  @doc("The transcription confidence score.")
  confidence?: float32 | null;
}

@doc("The `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentClientEventSessionUpdate {
  ...OmitProperties<OpenAI.RealtimeClientEventSessionUpdate, "session">;

  @doc("The voice-agent session settings to update.")
  session: VoiceAgentSessionUpdate;
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeClientEventResponseCreate.response,
  VoiceAgentResponseCreateParams
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  {
    @doc("Phrase-level transcription timing and confidence details.")
    phrases?: VoiceAgentTranscriptionPhrase[] | null,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  {
    @doc("The assistant message after truncation, when the service returns the updated item.")
    item?: OpenAI.RealtimeConversationItem,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventResponseCreated.response,
  VoiceAgentRealtimeResponse
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventResponseDone.response,
  VoiceAgentRealtimeResponse
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionCreated.session,
  VoiceAgentSessionResponse
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@copyProperties(
  OpenAI.RealtimeServerEventSessionCreated,
  {
    @doc("The session-scoped conversation id. When present, responses attached to the session conversation use the same value in `response.created` and `response.done`.")
    conversation_id?: string,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionUpdated.session,
  VoiceAgentSessionResponse
);

@doc("Fields shared by server events that report the lifecycle of a subagent consultation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionSubagentLifecycle {
  @doc("The server-generated event identifier.")
  event_id: string;

  @doc("The identifier of the subagent consultation.")
  consultation_id: string;

  @doc("The identifier of the function call that initiated the consultation.")
  call_id: string;

  @doc("The name of the consulted subagent.")
  subagent_name: string;
}

@doc("The reason a subagent consultation was aborted.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentSubagentAbortReason {
  string,

  @doc("The requested subagent was not configured for the voice agent.")
  unknown_target: "unknown_target",

  @doc("The subagent invocation exceeded its configured timeout.")
  timeout: "timeout",

  @doc("The consultation was cancelled because the voice session ended.")
  cancelled: "cancelled",

  @doc("The consultation was stopped at the user's request.")
  stopped_by_user: "stopped_by_user",

  @doc("The consultation was replaced by a newer request.")
  superseded: "superseded",

  @doc("The consultation failed.")
  failed: "failed",
}

@doc("The `session.subagent.started` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionSubagentStarted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.started`.")
  type: "session.subagent.started";

  ...VoiceAgentServerEventSessionSubagentLifecycle;
}

@doc("The `session.subagent.completed` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionSubagentCompleted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.completed`.")
  type: "session.subagent.completed";

  ...VoiceAgentServerEventSessionSubagentLifecycle;
}

@doc("The `session.subagent.aborted` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionSubagentAborted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.aborted`.")
  type: "session.subagent.aborted";

  ...VoiceAgentServerEventSessionSubagentLifecycle;

  @doc("The reason the consultation was aborted.")
  reason: VoiceAgentSubagentAbortReason;
}

@doc("The `session.avatar.connect` client event.")
@usage(VoiceAgentClientEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentClientEventSessionAvatarConnect
  extends OpenAI.RealtimeClientEvent {
  @doc("The event type. Always `session.avatar.connect`.")
  type: "session.avatar.connect";

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for avatar media negotiation.")
  client_sdp: string;
}

@doc("The `rtc.call.sdp.create` client event: begins WebRTC signaling with an SDP offer.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventRtcCallSdpCreate extends OpenAI.RealtimeClientEvent {
  @doc("The event type. Always `rtc.call.sdp.create`.")
  type: "rtc.call.sdp.create";

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for the WebRTC connection.")
  sdp_offer: string;

  @doc("Optional session configuration. For an `/agents` endpoint the service rebuilds it authoritatively from the persisted agent definition.")
  session?: VoiceAgentSessionUpdateConfig;
}

@doc("The `rtc.call.sdp.created` server event: the SDP answer that completes WebRTC negotiation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRtcCallSdpCreated
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `rtc.call.sdp.created`.")
  type: "rtc.call.sdp.created";

  @doc("The server-generated event identifier.")
  event_id: string;

  @doc("The identifier of the established WebRTC call.")
  rtc_call_id: string;

  @doc("The server's SDP answer for the WebRTC connection.")
  sdp_answer: string;
}

@doc("Details of a WebRTC signaling error.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@usage(VoiceAgentServerEventUsage)
model VoiceAgentRtcCallErrorDetails {
  @doc("The error category, following the VoiceLive wire contract: `invalid_request_error` for a client-side signaling fault (for example, a malformed SDP offer) or `server_error` for a service-side failure. Additional categories may be added over time.")
  type: string;

  @doc("A machine-readable error code, when available.")
  code?: string;

  @doc("A human-readable error message.")
  message: string;
}

@doc("The `rtc.call.error` server event: a WebRTC signaling failure.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRtcCallError extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `rtc.call.error`.")
  type: "rtc.call.error";

  @doc("An optional server-generated event identifier.")
  event_id?: string;

  @doc("The signaling operation that failed, when known.")
  operation?: string;

  @doc("The identifier of the WebRTC call, when known.")
  rtc_call_id?: string;

  @doc("The error detail.")
  error: VoiceAgentRtcCallErrorDetails;
}

@doc("Details of a non-fatal warning.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventWarningDetails {
  /** A description of the warning. */
  message: string;

  /** The machine-readable warning code. */
  code?: string;

  /** The request parameter associated with the warning, if any. */
  param?: string;
}

@doc("The `warning` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventWarning extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `warning`. */
  type: "warning";

  /** The unique ID of this server event. */
  event_id: string;

  /** Details of the non-fatal warning. */
  warning: VoiceAgentServerEventWarningDetails;
}

@doc("The `session.avatar.connecting` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionAvatarConnecting
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `session.avatar.connecting`. */
  type: "session.avatar.connecting";

  /** The unique ID of this server event. */
  event_id: string;

  @doc("The server's SDP answer for avatar media negotiation.")
  server_sdp: string;
}

@doc("The `session.avatar.switch_to_speaking` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionAvatarSwitchToSpeaking
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `session.avatar.switch_to_speaking`. */
  type: "session.avatar.switch_to_speaking";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the turn associated with this avatar state change. */
  turn_id?: string;
}

@doc("The `session.avatar.switch_to_idle` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventSessionAvatarSwitchToIdle
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `session.avatar.switch_to_idle`. */
  type: "session.avatar.switch_to_idle";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the turn associated with this avatar state change. */
  turn_id?: string;
}

@doc("The `response.audio_timestamp.delta` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAudioTimestampDelta
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.audio_timestamp.delta`. */
  type: "response.audio_timestamp.delta";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response containing the audio. */
  response_id: string;

  /** The ID of the conversation item containing the audio. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The index of the audio content part within the item. */
  content_index: int32;

  /** The offset of the word within the generated audio, in milliseconds. */
  audio_offset_ms: FoundryDurationMilliseconds;

  /** The duration of the word's audio, in milliseconds. */
  audio_duration_ms: FoundryDurationMilliseconds;

  /** The word associated with this audio timestamp. */
  text: string;

  /** The timestamp granularity, which is always `word`. */
  timestamp_type: "word";
}

@doc("The `response.audio_timestamp.done` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAudioTimestampDone
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.audio_timestamp.done`. */
  type: "response.audio_timestamp.done";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response whose audio timestamps have finished streaming. */
  response_id: string;

  /** The ID of the conversation item containing the audio. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The index of the audio content part within the item. */
  content_index: int32;
}

@doc("The `response.animation_blendshapes.delta` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAnimationBlendshapesDelta
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.animation_blendshapes.delta`. */
  type: "response.animation_blendshapes.delta";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response containing the animation. */
  response_id: string;

  /** The ID of the conversation item containing the animation. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The index of the content part associated with the animation. */
  content_index: int32;

  @doc("Animation frames as numeric blendshape weights.")
  frames: float32[][];

  @doc("The index of the first frame in this delta.")
  frame_index: int32;
}

@doc("The `response.animation_blendshapes.done` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAnimationBlendshapesDone
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.animation_blendshapes.done`. */
  type: "response.animation_blendshapes.done";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response whose blendshape animation has finished streaming. */
  response_id: string;

  /** The ID of the conversation item containing the animation. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;
}

@doc("The `response.animation_viseme.delta` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAnimationVisemeDelta
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.animation_viseme.delta`. */
  type: "response.animation_viseme.delta";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response containing the animation. */
  response_id: string;

  /** The ID of the conversation item containing the animation. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The index of the content part associated with the animation. */
  content_index: int32;

  /** The offset of the viseme within the generated audio, in milliseconds. */
  audio_offset_ms: FoundryDurationMilliseconds;

  /** The identifier of the mouth shape to display for this viseme. */
  viseme_id: int32;
}

@doc("The `response.animation_viseme.done` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseAnimationVisemeDone
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.animation_viseme.done`. */
  type: "response.animation_viseme.done";

  /** The unique ID of this server event. */
  event_id: string;

  /** The ID of the response whose viseme animation has finished streaming. */
  response_id: string;

  /** The ID of the conversation item containing the animation. */
  item_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The index of the content part associated with the animation. */
  content_index: int32;
}

@doc("The `response.video.delta` server event.")
@usage(VoiceAgentServerEventUsage)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentServerEventResponseVideoDelta
  extends OpenAI.RealtimeServerEvent {
  /** The event type, which is always `response.video.delta`. */
  type: "response.video.delta";

  /** The unique ID of this server event. */
  event_id: string;

  /** The index of the output item within the response. */
  output_index: int32;

  /** The codec used to encode the video frames in this event. */
  codec: string;

  @doc("The base64-encoded video frame data.")
  delta: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The response that switches an HTTP connection to the voice-agent WebSocket protocol.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentWebSocketUpgradeResponse {
  @statusCode
  status_code: 101;

  @doc("The negotiated WebSocket subprotocol. Present only when the client requests `realtime`.")
  @header("Sec-WebSocket-Protocol")
  subprotocol?: VoiceAgentWebSocketSubprotocol;
}
