import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-core/experimental";
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
  rtc_call_sdp_create: "rtc.call.sdp.create",
}

@extension("x-ms-foundry-meta", VoiceAgentConditionalPreview)
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

  @doc("An incremental fragment of model-generated system-tool arguments.")
  response_system_tool_arguments_delta: "response.system_tool_arguments.delta",

  @doc("The complete model-generated system-tool arguments, not a provider outcome.")
  response_system_tool_arguments_done: "response.system_tool_arguments.done",

  @doc("An asynchronous collection or telephony-operation outcome.")
  input_collection_status: "input_collection.status",

  session_handoff_started: "session.handoff.started",
  session_handoff_completed: "session.handoff.completed",
  session_handoff_aborted: "session.handoff.aborted",
}

// Retain the extension union itself so its named members remain assignable to
// the imported discriminator type. Copying only its literals loses that relation.
@doc("Voice-specific members added to the OpenAI client-event discriminator.")
union VoiceAgentClientEventTypeExtensions {
  @doc("The Voice Agent client-event kinds.")
  voice_agent: VoiceAgentClientEventTypeExtension,
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Registering Voice-only literals in the imported OpenAI discriminator union preserves a single polymorphic hierarchy."
@@copyVariants(
  OpenAI.RealtimeClientEventType,
  VoiceAgentClientEventTypeExtensions
);

@doc("Voice-specific members added to the OpenAI server-event discriminator.")
union VoiceAgentServerEventTypeExtensions {
  @doc("The Voice Agent server-event kinds.")
  voice_agent: VoiceAgentServerEventTypeExtension,
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Registering Voice-only literals in the imported OpenAI discriminator union preserves a single polymorphic hierarchy."
@@copyVariants(
  OpenAI.RealtimeServerEventType,
  VoiceAgentServerEventTypeExtensions
);

@doc("The WebSocket subprotocol supported by a voice-agent connection.")
union VoiceAgentWebSocketSubprotocol {
  realtime: "realtime",
}

@doc("The transport used for a voice-agent connection.")
union VoiceAgentTransport {
  string,

  @doc("Signaling and audio are exchanged as JSON events over the WebSocket. This is the default.")
  websocket: "websocket",

  @doc("WebRTC: the WebSocket carries only SDP signaling; media and the data channel are peer-to-peer.")
  webrtc: "webrtc",
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "A WebSocket message may be sent by either the client or the server."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
@doc("A JSON text message exchanged over an established voice-agent WebSocket. Audio bytes are base64-encoded in JSON event fields.")
@usage(VoiceAgentWebSocketMessageUsage)
@oneOf
union VoiceAgentWebSocketMessage {
  client: VoiceAgentClientEvent,
  server: VoiceAgentServerEvent,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Client WebSocket messages are selected by their `type` property."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
@doc("A stable v1 message sent by a client over a voice-agent WebSocket.")
@usage(VoiceAgentClientEventUsage)
@oneOf
@extension("x-foundry-event-direction", "client")
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
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
@doc("A stable v1 message sent by the service over a voice-agent WebSocket.")
@usage(VoiceAgentServerEventUsage)
@oneOf
@extension("x-foundry-event-direction", "server")
// `conversation.created` is replaced by `session.created.conversation_id`, the canonical persisted-conversation id.
// `input_audio_buffer.dtmf_event_received` is telephony-only and excluded with the rest of the telephony call-control surface.
@extension("x-ms-foundry-meta", VoiceAgentConditionalPreview)
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

  @doc("An incremental fragment of model-generated system-tool arguments.")
  response_system_tool_arguments_delta: VoiceAgentServerEventSystemToolArgumentsDelta,

  @doc("The complete model-generated system-tool arguments, not a provider outcome.")
  response_system_tool_arguments_done: VoiceAgentServerEventSystemToolArgumentsDone,

  @doc("An asynchronous collection or telephony-operation outcome.")
  input_collection_status: VoiceAgentServerEventInputCollectionStatus,

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
  session_handoff_started: VoiceAgentServerEventSessionHandoffStarted,
  session_handoff_completed: VoiceAgentServerEventSessionHandoffCompleted,
  session_handoff_aborted: VoiceAgentServerEventSessionHandoffAborted,
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
model VoiceAgentSessionAvatarConfig extends VoiceAgentAvatarConfig {
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

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
@doc("The session configuration accepted by a voice-agent session update event.")
union VoiceAgentSessionUpdate {
  voice_agent: VoiceAgentSessionUpdateConfig,
}

@doc("The effective stable realtime session settings returned by the voice-agent service.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseConfig {
  ...VoiceAgentSessionUpdateConfig;

  @doc("The effective handoff topology and runtime state, when handoff is configured.")
  handoff?: VoiceAgentHandoffState | null;

  @doc("The object type. Always `realtime.session`.")
  object: "realtime.session";

  @doc("The session identifier.")
  id: string;

  @doc("The selected model.")
  `model`: string;

  @doc("The session expiration time as a Unix timestamp in seconds.")
  expires_at?: FoundryTimestamp | null;
}

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the existing API and SDK union representation."
@doc("The effective session configuration returned in voice-agent session lifecycle events.")
union VoiceAgentSessionResponse {
  voice_agent: VoiceAgentSessionResponseConfig,
}

@doc("Parameters accepted by a voice-agent `response.create` event.")
model VoiceAgentResponseCreateParams {
  ...OmitProperties<
    OpenAI.RealtimeResponseCreateParams,
    "prompt" | "output_modalities" | "audio"
  >;

  @doc("Modalities that the response may return.")
  output_modalities?: VoiceOutputModality[];

  @doc("Response-specific audio settings.")
  audio?: PickProperties<VoiceAgentAudioConfig, "output">;

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
@doc("A live realtime response returned by the voice-agent service in both `response.created` and `response.done` events.")
model VoiceAgentRealtimeResponse {
  ...OmitProperties<OpenAI.RealtimeResponse, "audio">;

  @doc("The audio configuration used by the live response, including flat voice provider, locale, and format fields under `output`.")
  audio?: VoiceResponseAudio;
}

@doc("Additional item kinds used by the Voice Agent service.")
union VoiceAgentConversationItemTypeExtension {
  @doc("A service-managed system-tool intent, not a provider result.")
  system_tool: "system_tool",
}

@doc("Voice-specific members added to the OpenAI conversation-item discriminator.")
union VoiceAgentConversationItemTypeExtensions {
  @doc("The Voice Agent conversation-item kinds.")
  voice_agent: VoiceAgentConversationItemTypeExtension,
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Extend the existing Realtime item discriminator, following the shared MCP item hierarchy."
@@copyVariants(
  OpenAI.RealtimeConversationItemType,
  VoiceAgentConversationItemTypeExtensions
);

@doc("Service-generated system-tool intent, not a provider result. Clients cannot create it or complete it with `function_call_output`.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSystemToolItem extends OpenAI.RealtimeConversationItem {
  @doc("The output-item kind. Always `system_tool`.")
  type: VoiceAgentConversationItemTypeExtension.system_tool;

  @doc("The identifier of the generated item.")
  id?: string;

  @doc("The realtime item marker.")
  object?: "realtime.item";

  @doc("The generation status of the item, not the provider execution outcome.")
  status: VoiceAgentSystemToolItemStatus;

  @doc("The built-in capability invoked by the model.")
  name: VoiceAgentSystemToolName;

  @doc("The invocation identifier used for correlation and duplicate suppression.")
  call_id: string;

  @doc("Original JSON-encoded intent: literals remain visible and references stay unexpanded. Excludes private values, resolved arguments and executor-only settings.")
  arguments: string;

  ...VoiceConversationItemPersistence;
}

@doc("The generation status of a system-tool item. It does not indicate provider success.")
union VoiceAgentSystemToolItemStatus {
  string,

  @doc("The item is still being generated.")
  in_progress: "in_progress",

  @doc("The item finished generation.")
  completed: "completed",

  @doc("The item did not finish generation.")
  incomplete: "incomplete",
}

@doc("An incremental model-argument fragment for a service-managed system tool.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSystemToolArgumentsDelta
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `response.system_tool_arguments.delta`.")
  type: VoiceAgentServerEventTypeExtension.response_system_tool_arguments_delta;

  @doc("The unique identifier of this server event.")
  event_id: string;

  @doc("The response containing the tool invocation.")
  response_id: string;

  @doc("The generated tool item's identifier.")
  item_id: string;

  @doc("The item's zero-based position in the response output.")
  output_index: int32;

  @doc("The invocation identifier.")
  call_id: string;

  @doc("An incremental JSON fragment of the intent arguments.")
  delta: string;

  @doc("Optional padding metadata with no application semantics.")
  obfuscation?: string;
}

@doc("The completed intent arguments for a system tool, not provider success or a request for a customer function result.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSystemToolArgumentsDone
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `response.system_tool_arguments.done`.")
  type: VoiceAgentServerEventTypeExtension.response_system_tool_arguments_done;

  @doc("The unique identifier of this server event.")
  event_id: string;

  @doc("The response containing the tool invocation.")
  response_id: string;

  @doc("The generated tool item's identifier.")
  item_id: string;

  @doc("The item's zero-based position in the response output.")
  output_index: int32;

  @doc("The invocation identifier.")
  call_id: string;

  @doc("The invoked built-in capability.")
  name: VoiceAgentSystemToolName;

  @doc("The complete, unexpanded model arguments as a JSON string.")
  arguments: string;
}

@doc("Decoded model-generated language-switch arguments, not a new client ingress. Unsupported speech components do not gain language support from this tool.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentLanguageDetectionArguments {
  @doc("Target language in lowercase ISO 639-1 format, such as es or fr.")
  @minLength(2)
  @maxLength(2)
  @pattern("^[a-z]{2}$")
  language: string;

  @doc("Non-blank reason for switching the conversation language.")
  @minLength(1)
  @pattern("\\S")
  reason: string;
}

@doc("Arguments for starting a collection on a model call.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentCollectionStartArguments {
  @doc("Required; no default. True returns a private reference, false returns the value. Privacy cannot be downgraded after collection starts.")
  secret: boolean;

  @doc("Preferred bare name for the output variable, required for `secret: true` and forbidden otherwise.")
  output_variable_name?: VoiceAgentOutputReference;

  @doc("The collection timeout in seconds, from 1 to 300, including receiver setup. Overrides the agent timeout; if both are omitted, defaults to 60 seconds. Duplicate calls do not reset the timeout.")
  @minValue(1)
  @maxValue(300)
  timeout_seconds?: int32;
}

@doc("Model-call SMS collection arguments, validated before receiver setup. The model supplies the sender, not the collected SMS.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentCollectSmsStartArguments {
  ...VoiceAgentCollectionStartArguments;

  @doc("The expected SMS sender in canonical E.164 form, explicitly selected at start without Caller ID fallback. This is routing, not authenticated identity.")
  @pattern("^\\+[1-9][0-9]{1,14}$")
  from_phone_number: string;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Model-generated keypad completion selects one typed object, not a new client-ingress union."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Preserve the reviewed completion-mode objects and their SDK representation instead of introducing a new base model."
@doc("One typed keypad completion policy. Unknown types, mixed-mode fields and legacy strings are rejected before receiver setup.")
@oneOf
union VoiceAgentDtmfCompletionMode {
  @doc("Completes after the configured number of digits.")
  fixed_length: VoiceAgentDtmfFixedLengthCompletionMode,

  @doc("Completes when the configured confirmation key follows a non-empty digit string.")
  terminator: VoiceAgentDtmfTerminatorCompletionMode,

  @doc("Completes after the configured pause following a non-empty digit string.")
  inter_digit_silence: VoiceAgentDtmfInterDigitSilenceCompletionMode,
}

@doc("The wait after each received digit, scoped to the selected completion policy.")
model VoiceAgentDtmfCompletionTiming {
  @doc("The timeout in seconds between received digits, from 1 to 300, reset after each digit. Defaults to 5 seconds.")
  @minValue(1)
  @maxValue(300)
  inter_digit_timeout_seconds?: int32 = 5;
}

@doc("Complete immediately after exactly length digits. Other modes' fields are not accepted.")
model VoiceAgentDtmfFixedLengthCompletionMode {
  ...VoiceAgentDtmfCompletionTiming;

  @doc("Select fixed-length completion.")
  type: "fixed_length";

  @doc("The number of digits to collect; defaults to six. There is no terminator or separate minimum/maximum pair.")
  @minValue(1)
  @maxValue(64)
  length?: int32 = 6;
}

@doc("Completes when the configured end key follows nonempty digits within service limits. No digit count or length bounds are configured.")
model VoiceAgentDtmfTerminatorCompletionMode {
  ...VoiceAgentDtmfCompletionTiming;

  @doc("Select confirmation-key completion.")
  type: "terminator";

  @doc("Required confirmation key; excluded from the collected value.")
  terminator: VoiceAgentDtmfTerminator;
}

@doc("Completes after nonempty input and an inter-digit pause, within service limits. No key or count is configured; total deadline expiry takes precedence.")
model VoiceAgentDtmfInterDigitSilenceCompletionMode {
  ...VoiceAgentDtmfCompletionTiming;

  @doc("Select silence completion.")
  type: "inter_digit_silence";
}

@doc("The two non-numeric keypad keys permitted as confirmation terminators.")
union VoiceAgentDtmfTerminator {
  @doc("The number-sign confirmation key.")
  number_sign: "#",

  @doc("The asterisk confirmation key.")
  asterisk: "*",
}

@doc("Arguments for starting DTMF collection on a model call.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentCollectDtmfStartArguments {
  ...VoiceAgentCollectionStartArguments;

  @doc("Required typed object selecting one completion policy and its parameters, not an array of simultaneous rules.")
  completion_mode: VoiceAgentDtmfCompletionMode;

  @doc("The maximum wait for the first digit in seconds, starting at receiver readiness and bounded by the remaining total deadline. Defaults to 15 seconds.")
  @minValue(1)
  @maxValue(300)
  first_digit_timeout_seconds?: int32 = 15;
}

@doc("Reports collection or telephony outcomes for a model call.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputCollectionStatus
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `input_collection.status`.")
  type: VoiceAgentServerEventTypeExtension.input_collection_status;

  @doc("An optional event identifier.")
  event_id?: string;

  @doc("The originating system-tool invocation.")
  call_id: string;

  @doc("The collection operation identifier, when this outcome concerns a collection.")
  collection_id?: string;

  @doc("The current receiver request identifier, when applicable.")
  request_id?: string;

  @doc("The collection receiver, omitted for telephony-operation feedback.")
  channel?: VoiceAgentInputCollectionChannel;

  @doc("The reported outcome. Generation completion of a system-tool item is separate.")
  status: VoiceAgentInputCollectionStatus;

  @doc("Completed ASCII digits, including leading zeros, only for `secret: false`; absent for private collection and telephony-operation feedback.")
  value?: string;

  @doc("Actual bare variable name from successful private collection, not its value. May be suffixed on collision; reference it with `{{name}}`.")
  output_ref?: VoiceAgentOutputReference;
}

@doc("The receiver used by an input collection. Voice collection is not supported.")
union VoiceAgentInputCollectionChannel {
  @doc("Receives one complete SMS from the selected sender.")
  sms: "sms",

  @doc("Receives individual keypad digits from the active call.")
  dtmf: "dtmf",
}

@doc("Collection lifecycle and value-free telephony-operation outcomes. Additional outcomes may be introduced over time.")
union VoiceAgentInputCollectionStatus {
  string,

  @doc("The invocation was accepted; the receiver is not yet ready and no value has been collected.")
  accepted: "accepted",

  @doc("The receiver is ready, allowing the service to prompt the caller for input.")
  listening: "listening",

  @doc("Collection completed with an ordinary value or a privately stored variable reference.")
  completed: "completed",

  @doc("A collection deadline or input timer expired without completing collection.")
  expired: "expired",

  @doc("The service cancelled collection and cleaned up its receiver.")
  cancelled: "cancelled",

  @doc("Collection failed without creating an output variable.")
  failed: "failed",

  @doc("The invocation was rejected because another operation is active.")
  busy: "busy",

  @doc("The received input did not satisfy the collection policy.")
  invalid_input: "invalid_input",

  @doc("The model-generated tool arguments were invalid.")
  invalid_arguments: "invalid_arguments",

  @doc("The result does not match the current collection or receiver request.")
  stale_collection: "stale_collection",

  @doc("No supported receiver. Also used when omitting an unsupported tool before model exposure; no collection or variable is created.")
  unsupported_channel: "unsupported_channel",

  @doc("The service could not dispatch the operation to its executor; this does not confirm a provider outcome.")
  dispatch_failed: "dispatch_failed",

  @doc("The provider accepted the operation; this does not confirm SMS delivery, IVR recognition or authentication.")
  provider_accepted: "provider_accepted",

  @doc("The transfer target did not answer and the original conversation remains available.")
  transfer_not_answered: "transfer_not_answered",

  @doc("The provider reported failure or does not support the requested operation.")
  provider_failed_or_unsupported: "provider_failed_or_unsupported",

  @doc("The provider outcome could not be confirmed after possible dispatch; the service does not automatically retry.")
  provider_result_uncertain: "provider_result_uncertain",

  @doc("Rejected before any provider side effect; nothing was sent or dialed. Includes unavailable executors and unavailable-sender tool-resolution failures before model exposure.")
  provider_not_executed: "provider_not_executed",
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
model VoiceAgentServerEventSessionSubagentStarted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.started`.")
  type: VoiceAgentServerEventTypeExtension.session_subagent_started;

  ...VoiceAgentServerEventSessionSubagentLifecycle;
}

@doc("The `session.subagent.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionSubagentCompleted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.completed`.")
  type: VoiceAgentServerEventTypeExtension.session_subagent_completed;

  ...VoiceAgentServerEventSessionSubagentLifecycle;
}

@doc("The `session.subagent.aborted` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionSubagentAborted
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `session.subagent.aborted`.")
  type: VoiceAgentServerEventTypeExtension.session_subagent_aborted;

  ...VoiceAgentServerEventSessionSubagentLifecycle;

  @doc("The reason the consultation was aborted.")
  reason: VoiceAgentSubagentAbortReason;
}

@doc("The `session.avatar.connect` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionAvatarConnect
  extends OpenAI.RealtimeClientEvent {
  @doc("The event type. Always `session.avatar.connect`.")
  type: VoiceAgentClientEventTypeExtension.session_avatar_connect;

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for avatar media negotiation.")
  client_sdp: string;
}

@doc("The `rtc.call.sdp.create` client event: begins WebRTC signaling with an SDP offer.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventRtcCallSdpCreate extends OpenAI.RealtimeClientEvent {
  @doc("The event type. Always `rtc.call.sdp.create`.")
  type: VoiceAgentClientEventTypeExtension.rtc_call_sdp_create;

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for the WebRTC connection.")
  sdp_offer: string;

  @doc("Optional session configuration. For an `/agents` endpoint the service rebuilds it authoritatively from the persisted agent definition.")
  session?: VoiceAgentSessionUpdateConfig;
}

@doc("The `rtc.call.sdp.created` server event: the SDP answer that completes WebRTC negotiation.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRtcCallSdpCreated
  extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `rtc.call.sdp.created`.")
  type: VoiceAgentServerEventTypeExtension.rtc_call_sdp_created;

  @doc("The server-generated event identifier.")
  event_id: string;

  @doc("The identifier of the established WebRTC call.")
  rtc_call_id: string;

  @doc("The server's SDP answer for the WebRTC connection.")
  sdp_answer: string;
}

@doc("The error categories reported for WebRTC signaling failures.")
union VoiceAgentRtcCallErrorType {
  string,

  @doc("A client-side signaling fault, such as a malformed SDP offer.")
  invalid_request_error: "invalid_request_error",

  @doc("A service-side signaling failure.")
  server_error: "server_error",
}

@doc("Details of a WebRTC signaling error.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentRtcCallErrorDetails {
  @doc("The error category, following the VoiceLive wire contract: `invalid_request_error` for a client-side signaling fault (for example, a malformed SDP offer) or `server_error` for a service-side failure. Additional categories may be added over time.")
  type: VoiceAgentRtcCallErrorType;

  @doc("A machine-readable error code, when available.")
  code?: string;

  @doc("A human-readable error message.")
  message: string;
}

@doc("The `rtc.call.error` server event: a WebRTC signaling failure.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRtcCallError extends OpenAI.RealtimeServerEvent {
  @doc("The event type. Always `rtc.call.error`.")
  type: VoiceAgentServerEventTypeExtension.rtc_call_error;

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
model VoiceAgentServerEventWarningDetails {
  message: string;
  code?: string;
  param?: string;
}

@doc("The `warning` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWarning extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.warning;
  event_id: string;
  warning: VoiceAgentServerEventWarningDetails;
}

@doc("The `session.avatar.connecting` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarConnecting
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.session_avatar_connecting;
  event_id: string;

  @doc("The server's SDP answer for avatar media negotiation.")
  server_sdp: string;
}

@doc("The `session.avatar.switch_to_speaking` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToSpeaking
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.session_avatar_switch_to_speaking;
  event_id: string;
  turn_id?: string;
}

@doc("The `session.avatar.switch_to_idle` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToIdle
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.session_avatar_switch_to_idle;
  event_id: string;
  turn_id?: string;
}

@doc("The `response.audio_timestamp.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDelta
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.response_audio_timestamp_delta;
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: FoundryDurationMilliseconds;
  audio_duration_ms: FoundryDurationMilliseconds;
  text: string;
  timestamp_type: VoiceAgentAudioTimestampType.word;
}

@doc("The `response.audio_timestamp.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDone
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.response_audio_timestamp_done;
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
  type: VoiceAgentServerEventTypeExtension.response_animation_blendshapes_delta;
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
  type: VoiceAgentServerEventTypeExtension.response_animation_blendshapes_done;
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
}

@doc("The `response.animation_viseme.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDelta
  extends OpenAI.RealtimeServerEvent {
  type: VoiceAgentServerEventTypeExtension.response_animation_viseme_delta;
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
  type: VoiceAgentServerEventTypeExtension.response_animation_viseme_done;
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
  type: VoiceAgentServerEventTypeExtension.response_video_delta;
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

// ---------------------------------------------------------------------------
// Native Live protocol and Foundry conversation correlation
// ---------------------------------------------------------------------------

/*
 * Native Live events with Foundry conversation correlation and delegation ownership; no additional event types.
 * For foundry_managed_agent sessions, session delegation reports the pinned Foundry target and delegation
 * targets report foundry_managed_agent; GPT Live itself runs native client delegation.
 * response.event correlates backend output by delegation_id, preserving IDs, sequence numbers and tags.
 * Lifecycle snapshots omit input and clear instructions, tools and output.
 * Correlate append acknowledgments via client_event_id to record accepted results, not speech or playback.
 * Use native errors for orchestration failures; never fabricate backend response events.
 */
// Keep event models reachable without HTTP frame bodies.
@@usage(OpenAI.LiveClientEvent, Usage.input | Usage.json);
@@usage(OpenAI.LiveServerEvent, Usage.output | Usage.json);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Add Foundry persistence correlation to the primary session-started event without replacing native session metadata."
@@copyProperties(
  OpenAI.LiveServerEventLiveSessionStarted,
  {
    @doc("Stored conversation ID when effective store is true. Use protocols/voice/live/conversations; this ID differs from session.id.")
    conversation_id?: string,
  }
);

@doc("Live session resource reported to Foundry clients. GPT Live runs native client delegation for foundry_managed_agent sessions; Foundry reports the effective owner.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveSessionResource {
  ...OmitProperties<OpenAI.LiveSessionResourceParam, "delegation">;

  @doc("Delegation owner. foundry_managed_agent sessions report the pinned target, including the resolved agent_version.")
  delegation?: VoiceAgentLiveDelegation | null;
}

@doc("Live delegation trigger metadata reported to Foundry clients. This object contains metadata, not the task text.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentLiveDelegationItem {
  ...OmitProperties<OpenAI.LiveDelegationItem, "target">;

  @doc("Where the work is handled. foundry_managed_agent sessions report foundry_managed_agent; GPT Live itself uses client.")
  target: VoiceAgentLiveDelegationTarget;
}

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Report the effective Foundry delegation owner without changing native session metadata."
@@changePropertyType(
  OpenAI.LiveServerEventLiveSessionStarted.session,
  VoiceAgentLiveSessionResource
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Report the effective Foundry delegation owner without changing native session metadata."
@@changePropertyType(
  OpenAI.LiveServerEventLiveSessionUpdated.session,
  VoiceAgentLiveSessionResource
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Report the effective Foundry delegation owner without changing native session metadata."
@@changePropertyType(
  OpenAI.LiveServerEventLiveSessionClosed.session,
  VoiceAgentLiveSessionResource
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Report the effective Foundry delegation owner without changing native trigger metadata."
@@changePropertyType(
  OpenAI.LiveServerEventLiveDelegationCreated.delegation,
  VoiceAgentLiveDelegationItem
);
