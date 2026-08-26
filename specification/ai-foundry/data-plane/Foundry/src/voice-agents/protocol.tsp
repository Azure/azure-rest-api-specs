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

union VoiceAgentClientEventTypeExtension {
  session_avatar_connect: "session.avatar.connect",
}

union VoiceAgentServerEventTypeExtension {
  warning: "warning",
  session_avatar_connecting: "session.avatar.connecting",
  session_avatar_switch_to_speaking: "session.avatar.switch_to_speaking",
  session_avatar_switch_to_idle: "session.avatar.switch_to_idle",
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
union VoiceAgentWebSocketSubprotocol {
  realtime: "realtime",
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "A WebSocket message may be sent by either the client or the server."
@doc("A JSON text message exchanged over an established voice-agent WebSocket. Audio bytes are base64-encoded in JSON event fields.")
@usage(VoiceAgentWebSocketMessageUsage)
@oneOf
union VoiceAgentWebSocketMessage {
  client: VoiceAgentClientEvent,
  server: VoiceAgentServerEvent,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Client WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by a client over a voice-agent WebSocket.")
@usage(VoiceAgentClientEventUsage)
@oneOf
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
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Server WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by the service over a voice-agent WebSocket.")
@usage(VoiceAgentServerEventUsage)
@oneOf
// `conversation.created` is replaced by `session.created.conversation_id`, the canonical persisted-conversation id.
// `input_audio_buffer.dtmf_event_received` is telephony-only and excluded with the rest of the telephony call-control surface.
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
  session_updated: OpenAI.RealtimeServerEventSessionUpdated,
  error: OpenAI.RealtimeServerEventError,
  warning: VoiceAgentServerEventWarning,
  session_avatar_connecting: VoiceAgentServerEventSessionAvatarConnecting,
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
union VoiceAgentAnimationOutputType {
  blendshapes: "blendshapes",
  viseme_id: "viseme_id",
}

@doc("Animation settings for a voice-agent session.")
model VoiceAgentAnimationConfig {
  @doc("The animation model name.")
  model_name?: string = "default";

  @doc("The requested animation output kinds.")
  outputs?: VoiceAgentAnimationOutputType[] = #[
    VoiceAgentAnimationOutputType.blendshapes
  ];
}

@doc("An ICE server used for avatar WebRTC negotiation.")
model VoiceAgentAvatarIceServer {
  urls: url[];
  username?: string | null;

  @secret
  credential?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "The session model is a wire-compatible specialization of the persisted avatar configuration and adds only runtime transport fields."
@doc("Avatar settings accepted by the stable voice-agent WebSocket contract.")
model VoiceAgentSessionAvatarConfig extends VoiceAvatarConfig {
  ice_servers?: VoiceAgentAvatarIceServer[] | null;
}

@doc("The stable realtime session settings accepted in a `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
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
  audio?: VoiceAudioConfig;

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
  greeting?: VoiceGreetingConfig;
}

@doc("The session configuration accepted by a voice-agent session update event.")
union VoiceAgentSessionUpdate {
  voice_agent: VoiceAgentSessionUpdateConfig,
}

@doc("The effective stable realtime session settings returned by the voice-agent service.")
@usage(VoiceAgentServerEventUsage)
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
union VoiceAgentSessionResponse {
  voice_agent: VoiceAgentSessionResponseConfig,
}

@doc("Parameters accepted by a voice-agent `response.create` event.")
model VoiceAgentResponseCreateParams {
  ...OmitProperties<
    OpenAI.RealtimeResponseCreateParams,
    "prompt" | "output_modalities" | "audio" | "input"
  >;

  @doc("Modalities that the response may return.")
  output_modalities?: VoiceOutputModality[];

  @doc("Response-specific audio settings.")
  audio?: PickProperties<VoiceAudioConfig, "output">;

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

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the upstream live response contract, including conversation_id, while replacing audio and output."
@doc("A live realtime response returned by the voice-agent service in both `response.created` and `response.done` events.")
model VoiceAgentRealtimeResponse extends OmitProperties<
  OpenAI.RealtimeResponse,
  "audio" | "output"
> {
  @doc("The audio configuration used by the live response, including flat voice provider, locale, and format fields under `output`.")
  audio?: VoiceResponseAudio;

  @doc("The items produced by the live response.")
  output?: OpenAI.RealtimeConversationItem[];
}

@doc("A time-stamped word in an input-audio transcription.")
model VoiceAgentTranscriptionWord {
  @doc("The transcribed word text.")
  text: string;

  @doc("The word offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: FoundryDurationMilliseconds;

  @doc("The word duration in milliseconds.")
  duration_milliseconds: FoundryDurationMilliseconds;
}

@doc("A transcribed phrase with timing information.")
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
    @doc("The id of the persisted conversation. Only present when conversation persistence is enabled for the session.")
    conversation_id?: string,
  }
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Customizing OpenAI type."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionUpdated.session,
  VoiceAgentSessionResponse
);

@doc("The `session.avatar.connect` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionAvatarConnect
  extends OpenAI.RealtimeClientEvent {
  @doc("The event type. Always `session.avatar.connect`.")
  type: "session.avatar.connect";

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for avatar media negotiation.")
  client_sdp: string;
}

@doc("Details of a non-fatal warning.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWarningDetails {
  message: string;
  code?: string;
  param?: string;
}

@doc("The `warning` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWarning extends OpenAI.RealtimeServerEvent {
  type: "warning";
  event_id: string;
  warning: VoiceAgentServerEventWarningDetails;
}

@doc("The `session.avatar.connecting` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarConnecting
  extends OpenAI.RealtimeServerEvent {
  type: "session.avatar.connecting";
  event_id: string;

  @doc("The server's SDP answer for avatar media negotiation.")
  server_sdp: string;
}

@doc("The `session.avatar.switch_to_speaking` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToSpeaking
  extends OpenAI.RealtimeServerEvent {
  type: "session.avatar.switch_to_speaking";
  event_id: string;
  turn_id?: string;
}

@doc("The `session.avatar.switch_to_idle` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToIdle
  extends OpenAI.RealtimeServerEvent {
  type: "session.avatar.switch_to_idle";
  event_id: string;
  turn_id?: string;
}

@doc("The `response.audio_timestamp.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.audio_timestamp.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: FoundryDurationMilliseconds;
  audio_duration_ms: FoundryDurationMilliseconds;
  text: string;
  timestamp_type: "word";
}

@doc("The `response.audio_timestamp.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDone
  extends OpenAI.RealtimeServerEvent {
  type: "response.audio_timestamp.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.animation_blendshapes.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_blendshapes.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;

  @doc("Animation frames as numeric blendshape weights.")
  frames: float32[][];

  @doc("The index of the first frame in this delta.")
  frame_index: int32;
}

@doc("The `response.animation_blendshapes.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDone
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_blendshapes.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
}

@doc("The `response.animation_viseme.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_viseme.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: FoundryDurationMilliseconds;
  viseme_id: int32;
}

@doc("The `response.animation_viseme.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDone
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_viseme.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.video.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseVideoDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.video.delta";
  event_id: string;
  output_index: int32;
  codec: string;

  @doc("The base64-encoded video frame data.")
  delta: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The response that switches an HTTP connection to the voice-agent WebSocket protocol.")
model VoiceAgentWebSocketUpgradeResponse {
  @statusCode
  status_code: 101;

  @doc("The negotiated WebSocket subprotocol. Present only when the client requests `realtime`.")
  @header("Sec-WebSocket-Protocol")
  subprotocol?: VoiceAgentWebSocketSubprotocol;
}
