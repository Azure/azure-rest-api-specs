import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "../openai/realtime/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

// cspell:ignore kbps viseme

alias VoiceAgentClientEventUsage = Usage.input | Usage.json;
alias VoiceAgentServerEventUsage = Usage.output | Usage.json;
alias VoiceAgentWebSocketMessageUsage = Usage.input | Usage.output | Usage.json;

@doc("The WebSocket subprotocol supported by a voice-agent connection.")
union VoiceAgentWebSocketSubprotocol {
  realtime: "realtime",
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "A WebSocket message may be sent by either the client or the server."
@doc("A JSON text message exchanged over an established voice-agent WebSocket.")
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
  conversation_item_create: VoiceAgentClientEventConversationItemCreate,
  conversation_item_delete: VoiceAgentClientEventConversationItemDelete,
  conversation_item_retrieve: VoiceAgentClientEventConversationItemRetrieve,
  conversation_item_truncate: VoiceAgentClientEventConversationItemTruncate,
  input_audio_buffer_append: VoiceAgentClientEventInputAudioBufferAppend,
  input_audio_buffer_clear: VoiceAgentClientEventInputAudioBufferClear,
  input_audio_buffer_commit: VoiceAgentClientEventInputAudioBufferCommit,
  output_audio_buffer_clear: VoiceAgentClientEventOutputAudioBufferClear,
  response_cancel: VoiceAgentClientEventResponseCancel,
  response_create: VoiceAgentClientEventResponseCreate,
  session_update: VoiceAgentClientEventSessionUpdate,
  session_avatar_connect: VoiceAgentClientEventSessionAvatarConnect,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Server WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by the service over a voice-agent WebSocket.")
@usage(VoiceAgentServerEventUsage)
@oneOf
union VoiceAgentServerEvent {
  conversation_item_added: VoiceAgentServerEventConversationItemAdded,
  conversation_item_created: VoiceAgentServerEventConversationItemCreated,
  conversation_item_deleted: VoiceAgentServerEventConversationItemDeleted,
  conversation_item_done: VoiceAgentServerEventConversationItemDone,
  conversation_item_input_audio_transcription_completed: VoiceAgentServerEventConversationItemInputAudioTranscriptionCompleted,
  conversation_item_input_audio_transcription_delta: VoiceAgentServerEventConversationItemInputAudioTranscriptionDelta,
  conversation_item_input_audio_transcription_failed: VoiceAgentServerEventConversationItemInputAudioTranscriptionFailed,
  conversation_item_input_audio_transcription_segment: VoiceAgentServerEventConversationItemInputAudioTranscriptionSegment,
  conversation_item_retrieved: VoiceAgentServerEventConversationItemRetrieved,
  conversation_item_truncated: VoiceAgentServerEventConversationItemTruncated,
  input_audio_buffer_cleared: VoiceAgentServerEventInputAudioBufferCleared,
  input_audio_buffer_committed: VoiceAgentServerEventInputAudioBufferCommitted,
  input_audio_buffer_speech_started: VoiceAgentServerEventInputAudioBufferSpeechStarted,
  input_audio_buffer_speech_stopped: VoiceAgentServerEventInputAudioBufferSpeechStopped,
  input_audio_buffer_timeout_triggered: VoiceAgentServerEventInputAudioBufferTimeoutTriggered,
  mcp_list_tools_completed: VoiceAgentServerEventMcpListToolsCompleted,
  mcp_list_tools_failed: VoiceAgentServerEventMcpListToolsFailed,
  mcp_list_tools_in_progress: VoiceAgentServerEventMcpListToolsInProgress,
  output_audio_buffer_cleared: VoiceAgentServerEventOutputAudioBufferCleared,
  rate_limits_updated: VoiceAgentServerEventRateLimitsUpdated,
  response_output_audio_delta: VoiceAgentServerEventResponseAudioDelta,
  response_output_audio_done: VoiceAgentServerEventResponseAudioDone,
  response_output_audio_transcript_delta: VoiceAgentServerEventResponseAudioTranscriptDelta,
  response_output_audio_transcript_done: VoiceAgentServerEventResponseAudioTranscriptDone,
  response_content_part_added: OpenAI.RealtimeServerEventResponseContentPartAdded,
  response_content_part_done: VoiceAgentServerEventResponseContentPartDone,
  response_created: VoiceAgentServerEventResponseCreated,
  response_done: VoiceAgentServerEventResponseDone,
  response_function_call_arguments_delta: VoiceAgentServerEventResponseFunctionCallArgumentsDelta,
  response_function_call_arguments_done: VoiceAgentServerEventResponseFunctionCallArgumentsDone,
  response_mcp_call_arguments_delta: VoiceAgentServerEventResponseMcpCallArgumentsDelta,
  response_mcp_call_arguments_done: VoiceAgentServerEventResponseMcpCallArgumentsDone,
  response_mcp_call_completed: VoiceAgentServerEventResponseMcpCallCompleted,
  response_mcp_call_failed: VoiceAgentServerEventResponseMcpCallFailed,
  response_mcp_call_in_progress: VoiceAgentServerEventResponseMcpCallInProgress,
  response_web_search_call_in_progress: VoiceAgentServerEventWebSearchCallInProgress,
  response_web_search_call_searching: VoiceAgentServerEventWebSearchCallSearching,
  response_web_search_call_completed: VoiceAgentServerEventWebSearchCallCompleted,
  response_file_search_call_in_progress: VoiceAgentServerEventFileSearchCallInProgress,
  response_file_search_call_searching: VoiceAgentServerEventFileSearchCallSearching,
  response_file_search_call_completed: VoiceAgentServerEventFileSearchCallCompleted,
  response_output_item_added: VoiceAgentServerEventResponseOutputItemAdded,
  response_output_item_done: VoiceAgentServerEventResponseOutputItemDone,
  response_output_text_delta: VoiceAgentServerEventResponseTextDelta,
  response_output_text_done: VoiceAgentServerEventResponseTextDone,
  session_created: VoiceAgentServerEventSessionCreated,
  session_updated: VoiceAgentServerEventSessionUpdated,
  conversation_created: VoiceAgentServerEventConversationCreated,
  error: VoiceAgentServerEventError,
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

@doc("Additional server-output fields that a voice-agent session may request.")
union VoiceAgentSessionIncludeOption {
  input_audio_transcription_logprobs: "item.input_audio_transcription.logprobs",
  input_audio_transcription_phrases: "item.input_audio_transcription.phrases",
  file_search_call_results: "file_search_call.results",
}

@doc("The maximum output-token count or the literal `inf`.")
union VoiceAgentMaxOutputTokens {
  count: int32,
  unlimited: "inf",
}

@doc("An end-of-utterance detector model.")
union VoiceAgentEndOfUtteranceModel {
  semantic_detection_v1: "semantic_detection_v1",
  semantic_detection_v1_en: "semantic_detection_v1_en",
  semantic_detection_v1_multilingual: "semantic_detection_v1_multilingual",
  smart_end_of_turn_detection: "smart_end_of_turn_detection",
}

@doc("A threshold preset for end-of-utterance detection.")
union VoiceAgentEndOfUtteranceThresholdLevel {
  low: "low",
  medium: "medium",
  high: "high",
  default: "default",
}

@doc("End-of-utterance detection settings.")
model VoiceAgentEndOfUtteranceDetection {
  `model`: VoiceAgentEndOfUtteranceModel;

  @minValue(0)
  @maxValue(1)
  threshold?: float32 | null;

  threshold_level?: VoiceAgentEndOfUtteranceThresholdLevel | null;

  @minValue(0)
  timeout?: float32 | null;

  @minValue(0)
  timeout_ms?: int32 | null;
}

@doc("Server VAD turn-detection settings.")
model VoiceAgentServerVadTurnDetection {
  ...OmitProperties<
    VoiceServerVadTurnDetection,
    "type" | "threshold" | "prefix_padding_ms" | "silence_duration_ms"
  >;
  type: VoiceTurnDetectionType.server_vad;

  @minValue(0)
  @maxValue(1)
  threshold?: float32 | null;

  prefix_padding_ms?: int32 | null;
  silence_duration_ms?: int32 | null;

  @minValue(0)
  speech_duration_ms?: int32 | null;

  end_of_utterance_detection?: VoiceAgentEndOfUtteranceDetection | null;
  auto_truncate?: boolean = false;
}

@doc("OpenAI semantic VAD turn-detection settings.")
model VoiceAgentSemanticVadTurnDetection {
  ...VoiceSemanticVadTurnDetection;
  auto_truncate?: boolean = false;
}

@doc("The discriminator for an Azure semantic VAD configuration.")
union VoiceAgentAzureSemanticVadType {
  default: "azure_semantic_vad",
  english: "azure_semantic_vad_en",
}

@doc("Azure semantic VAD turn-detection settings.")
model VoiceAgentAzureSemanticVadTurnDetection {
  ...OmitProperties<
    VoiceAzureSemanticVadTurnDetection,
    | "type"
    | "threshold"
    | "prefix_padding_ms"
    | "silence_duration_ms"
    | "end_of_utterance_detection"
    | "speech_duration_ms"
    | "languages"
    | "remove_filler_words"
    | "auto_truncate"
  >;
  type: VoiceAgentAzureSemanticVadType;

  @minValue(0)
  @maxValue(1)
  threshold?: float32 | null;

  prefix_padding_ms?: int32 | null;
  silence_duration_ms?: int32 | null;
  idle_timeout_ms?: int32 | null;

  @minValue(0)
  speech_duration_ms?: int32 | null;

  end_of_utterance_detection?: VoiceAgentEndOfUtteranceDetection | null;
  remove_filler_words?: boolean = false;
  languages?: string[] | null;
  auto_truncate?: boolean = false;
}

@doc("Azure multilingual semantic VAD turn-detection settings.")
model VoiceAgentAzureMultilingualSemanticVadTurnDetection {
  ...OmitProperties<
    VoiceAzureSemanticVadMultilingualTurnDetection,
    | "type"
    | "threshold"
    | "prefix_padding_ms"
    | "silence_duration_ms"
    | "end_of_utterance_detection"
    | "speech_duration_ms"
    | "languages"
  >;
  type: VoiceTurnDetectionType.azure_semantic_vad_multilingual;

  @minValue(0)
  @maxValue(1)
  threshold?: float32 | null;

  prefix_padding_ms?: int32 | null;
  silence_duration_ms?: int32 | null;
  idle_timeout_ms?: int32 | null;

  @minValue(0)
  speech_duration_ms?: int32 | null;

  end_of_utterance_detection?: VoiceAgentEndOfUtteranceDetection | null;
  languages?: string[] | null;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Turn-detection settings are selected by their `type` property."
@doc("Turn-detection settings accepted by a stable voice-agent session.")
@oneOf
union VoiceAgentTurnDetection {
  server_vad: VoiceAgentServerVadTurnDetection,
  semantic_vad: VoiceAgentSemanticVadTurnDetection,
  azure_semantic_vad: VoiceAgentAzureSemanticVadTurnDetection,
  azure_semantic_vad_multilingual: VoiceAgentAzureMultilingualSemanticVadTurnDetection,
}

@doc("The source of reference audio used for echo cancellation.")
union VoiceAgentEchoCancellationReferenceSource {
  server: "server",
  client: "client",
}

@doc("Server-side echo cancellation settings for input audio.")
model VoiceAgentEchoCancellation {
  @doc("The echo cancellation implementation. Always `server_echo_cancellation`.")
  type: "server_echo_cancellation";

  @doc("Whether reference audio comes from server playback or a client-provided channel.")
  reference_source?: VoiceAgentEchoCancellationReferenceSource = VoiceAgentEchoCancellationReferenceSource.server;

  @doc("The number of input channels. Use two interleaved channels when `reference_source` is `client`.")
  @minValue(1)
  @maxValue(2)
  channels?: int32 = 1;
}

@doc("Input-audio settings accepted in a stable voice-agent session.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentSessionUpdateAudioInput {
  ...OmitProperties<VoiceAudioInputConfig, "format" | "turn_detection">;

  @doc("The structured input audio format.")
  format?: VoiceAudioFormat | null;

  @doc("Turn-detection settings. Set to null to disable server-side turn detection.")
  turn_detection?: VoiceAgentTurnDetection | null;

  @doc("Optional server-side echo cancellation settings.")
  echo_cancellation?: VoiceAgentEchoCancellation | null;
}

@doc("Output-audio settings accepted in a stable voice-agent session.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentSessionUpdateAudioOutput {
  ...OmitProperties<VoiceAudioOutputConfig, "speed">;

  @doc("The speaking-speed multiplier.")
  @minValue(0.25)
  @maxValue(1.5)
  speed?: float32 | null;
}

@doc("Input- and output-audio settings accepted in a `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentSessionUpdateAudio {
  @doc("The input-audio settings for the session.")
  input?: VoiceAgentSessionUpdateAudioInput | null;

  @doc("The output-audio settings for the session.")
  output?: VoiceAgentSessionUpdateAudioOutput | null;
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
  urls: string[];
  username?: string | null;
  credential?: string | null;
}

@doc("The avatar video resolution.")
model VoiceAgentAvatarVideoResolution {
  @minValue(1)
  width: int32;

  @minValue(1)
  height: int32;
}

alias VoiceAgentAvatarVideoCoordinate = [uint32, uint32];

@doc("The rectangular crop applied to avatar video.")
model VoiceAgentAvatarVideoCrop {
  bottom_right: VoiceAgentAvatarVideoCoordinate;
  top_left: VoiceAgentAvatarVideoCoordinate;
}

@doc("The avatar video background.")
model VoiceAgentAvatarVideoBackground {
  image_url?: string | null;
  color?: string | null;
}

@doc("Avatar video encoder and presentation settings.")
model VoiceAgentAvatarVideoParams {
  bitrate?: int32 = 2000000;
  codec?: "h264" = "h264";
  crop?: VoiceAgentAvatarVideoCrop | null;
  resolution?: VoiceAgentAvatarVideoResolution | null;
  background?: VoiceAgentAvatarVideoBackground | null;

  @minValue(1)
  @maxValue(2000)
  gop_size?: int32 = 10;
}

@doc("Avatar placement and motion settings.")
model VoiceAgentAvatarScene {
  @minValueExclusive(0)
  zoom?: float32 = 1;

  @minValue(-1)
  @maxValue(1)
  position_x?: float32 = 0;

  @minValue(-1)
  @maxValue(1)
  position_y?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_x?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_y?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_z?: float32 = 0;

  @minValueExclusive(0)
  @maxValue(1)
  amplitude?: float32 = 1;
}

@doc("The avatar implementation.")
union VoiceAgentAvatarType {
  video_avatar: "video_avatar",
  photo_avatar: "photo_avatar",
}

@doc("The transport used to deliver avatar media.")
union VoiceAgentAvatarOutputProtocol {
  websocket: "websocket",
  websocket_binary: "websocket-binary",
  webrtc: "webrtc",
}

@doc("Avatar settings accepted by the stable voice-agent WebSocket contract.")
model VoiceAgentSessionAvatarConfig {
  type?: VoiceAgentAvatarType = VoiceAgentAvatarType.video_avatar;
  ice_servers?: VoiceAgentAvatarIceServer[] | null;
  character: string;
  style?: string | null;
  customized?: boolean = false;
  `model`?: string | null;
  video?: VoiceAgentAvatarVideoParams | null;
  scene?: VoiceAgentAvatarScene | null;
  output_protocol?: VoiceAgentAvatarOutputProtocol = VoiceAgentAvatarOutputProtocol.webrtc;
  output_audit_audio?: boolean = false;
}

@doc("Voice-optimized instruction adaptation settings.")
model VoiceAgentVoiceAdaptation {
  @doc("The adaptation strategy. Always `auto`.")
  type: "auto";
}

@doc("A condition that may trigger an interim response.")
union VoiceAgentInterimResponseTrigger {
  latency: "latency",
  tool: "tool",
}

@doc("Fields shared by interim-response configurations.")
@discriminator("type")
model VoiceAgentInterimResponseConfig {
  @doc("The interim-response implementation.")
  type: string;

  @doc("Conditions that may trigger one interim response.")
  triggers?: VoiceAgentInterimResponseTrigger[] = #[
    VoiceAgentInterimResponseTrigger.latency
  ];

  @doc("The latency threshold in milliseconds.")
  @minValue(0)
  latency_threshold_ms?: int32 = 2000;
}

@doc("A static interim response selected from configured text.")
model VoiceAgentStaticInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "static_interim_response";

  @doc("Candidate text values for the interim response.")
  texts?: string[];
}

@doc("An interim response generated by a language model.")
model VoiceAgentLlmInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "llm_interim_response";

  @doc("The model used to generate interim responses.")
  `model`?: string = "gpt-4.1-mini";

  @doc("Optional instructions for generating interim responses.")
  instructions?: string;

  @doc("The maximum completion-token count for an interim response.")
  @minValue(1)
  max_completion_tokens?: int32 = 50;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Interim response settings are selected by their `type` property."
@doc("Interim-response settings for latency and tool execution.")
@oneOf
union VoiceAgentInterimResponse {
  static: VoiceAgentStaticInterimResponseConfig,
  llm: VoiceAgentLlmInterimResponseConfig,
}

@doc("The stable realtime session settings accepted in a `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentSessionUpdateConfig {
  @doc("The session type. Always `realtime`.")
  type: "realtime";

  @doc("Instructions applied throughout the session.")
  instructions?: string | null;

  @doc("The sampling temperature for compatible cascaded pipelines.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches the service's integer-or-inf token limit."
  @doc("The maximum output-token count for one response.")
  max_output_tokens?: VoiceAgentMaxOutputTokens | null;

  @doc("The output modalities enabled for the session.")
  output_modalities?: VoiceOutputModality[] | null;

  @doc("The input- and output-audio settings for the session.")
  audio?: VoiceAgentSessionUpdateAudio | null;

  @doc("The avatar settings for the session.")
  avatar?: VoiceAgentSessionAvatarConfig | null;

  @doc("Animation settings for the session.")
  animation?: VoiceAgentAnimationConfig | null;

  @doc("Tools available to the session.")
  tools?: VoiceAgentTool[] | null;

  @doc("Tool-selection behavior for the session.")
  tool_choice?: VoiceAgentToolChoice | null;

  @doc("Reasoning settings for compatible realtime models.")
  reasoning?: OpenAI.RealtimeReasoning | null;

  @doc("Whether the model may call multiple tools in parallel.")
  parallel_tool_calls?: boolean;

  @doc("Additional fields to include in service outputs.")
  include?: VoiceAgentSessionIncludeOption[] | null;

  @doc("Up to 16 string key-value pairs attached to the session.")
  metadata?: Record<string> | null;

  @doc("Voice-optimized instruction adaptation settings.")
  voice_adaptation?: VoiceAgentVoiceAdaptation | null;

  @doc("Interim-response settings for latency and tool execution.")
  interim_response?: VoiceAgentInterimResponse | null;

  @doc("A delimiter appended to generated responses.")
  response_delimiter?: string;

  @doc("A proactive assistant greeting started after session configuration.")
  greeting?: VoiceGreetingConfig | null;
}

@doc("Input-audio settings returned in a stable voice-agent session event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseAudioInput {
  ...VoiceAgentSessionUpdateAudioInput;
}

@doc("Output-audio settings returned in a stable voice-agent session event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseAudioOutput {
  ...VoiceAgentSessionUpdateAudioOutput;
}

@doc("Input- and output-audio settings returned in a stable voice-agent session event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseAudio {
  @doc("The effective input-audio settings.")
  input?: VoiceAgentSessionResponseAudioInput | null;

  @doc("The output-audio settings for the session.")
  output?: VoiceAgentSessionResponseAudioOutput | null;
}

@doc("The effective stable realtime session settings returned by the voice-agent service.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseConfig {
  ...OmitProperties<
    VoiceAgentSessionUpdateConfig,
    "output_modalities" | "audio" | "include" | "metadata"
  >;

  @doc("The object type. Always `realtime.session`.")
  object: "realtime.session";

  @doc("The session identifier.")
  id: string;

  @doc("The selected model.")
  `model`: string;

  @doc("The session expiration time as a Unix timestamp in seconds.")
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  expires_at?: utcDateTime | null;

  @doc("The output modalities enabled for the session.")
  output_modalities: VoiceOutputModality[];

  @doc("The effective input- and output-audio settings for the session.")
  audio?: VoiceAgentSessionResponseAudio | null;

  @doc("The idle timeout reported by the service, in milliseconds.")
  idle_timeout?: int32 | null;
}

@doc("Output-audio settings applied to one `response.create` request.")
model VoiceAgentResponseCreateAudio {
  @doc("The response-specific output-audio settings.")
  output?: VoiceAgentSessionUpdateAudioOutput | null;
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The service request item spans OpenAI's disconnected message-role and item-type roots."
@doc("A conversation item accepted as inline response input.")
union VoiceAgentRequestConversationItem {
  OpenAI.RealtimeConversationItemMessageSystem,
  OpenAI.RealtimeConversationItemMessageUser,
  OpenAI.RealtimeConversationItemMessageAssistant,
  OpenAI.RealtimeConversationItemFunctionCall,
  OpenAI.RealtimeConversationItemFunctionCallOutput,
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Conversation item creation additionally accepts an MCP approval response."
@doc("A conversation item accepted by `conversation.item.create`.")
union VoiceAgentCreateConversationItem {
  VoiceAgentRequestConversationItem,
  OpenAI.RealtimeMCPApprovalResponse,
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
  audio?: VoiceAgentResponseCreateAudio;

  @doc("A pre-generated assistant message used to begin the response.")
  pre_generated_assistant_message?:
    | OpenAI.RealtimeConversationItemMessageAssistant
    | null;

  @doc("Interim-response settings for this response.")
  interim_response?: VoiceAgentInterimResponse | null;
}

@doc("A text part in a `response.content_part.*` server event.")
model VoiceAgentResponseEventTextContentPart {
  type: "text";
  text: string;
}

@doc("An audio part in a `response.content_part.*` server event.")
model VoiceAgentResponseEventAudioContentPart {
  type: "audio";
  transcript: string | null;
  annotations?: unknown;
  audio?: string;
  format?: VoiceAudioFormat;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Response event content parts are selected by their `type` property."
@doc("A content part carried by a `response.content_part.*` server event.")
@oneOf
union VoiceAgentResponseEventContentPart {
  text: VoiceAgentResponseEventTextContentPart,
  audio: VoiceAgentResponseEventAudioContentPart,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Message items are selected by their `role` property."
@doc("A role-specific message item returned by the voice-agent runtime.")
@oneOf
union VoiceAgentResponseMessageItem {
  system: OpenAI.RealtimeConversationItemMessageSystem,
  user: OpenAI.RealtimeConversationItemMessageUser,
  assistant: OpenAI.RealtimeConversationItemMessageAssistant,
}

@doc("A web-search source URL.")
model VoiceAgentWebSearchSource {
  type: "url";
  url: url;
}

@doc("A web search action.")
model VoiceAgentWebSearchActionSearch {
  type: "search";
  query: string | null;
  sources?: VoiceAgentWebSearchSource[] | null;
}

@doc("An action that opens a web page.")
model VoiceAgentWebSearchActionOpenPage {
  type: "open_page";
  url: url;
}

@doc("An action that finds text on a web page.")
model VoiceAgentWebSearchActionFind {
  type: "find";
  pattern: string;
  url: url;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Web-search actions are selected by their `type` property."
@doc("An action performed by a web-search tool call.")
@oneOf
union VoiceAgentWebSearchAction {
  search: VoiceAgentWebSearchActionSearch,
  open_page: VoiceAgentWebSearchActionOpenPage,
  find: VoiceAgentWebSearchActionFind,
}

@doc("A web-search output item.")
model VoiceAgentWebSearchCallItem {
  id: string;
  type: "web_search_call";
  status: VoiceAgentWebSearchCallStatus;
  action?: VoiceAgentWebSearchAction | null;
}

@doc("The status of a web-search call.")
union VoiceAgentWebSearchCallStatus {
  in_progress: "in_progress",
  searching: "searching",
  completed: "completed",
  failed: "failed",
}

@doc("A scalar metadata value returned with a file-search result.")
union VoiceAgentFileSearchAttributeValue {
  string_value: string,
  number_value: float64,
  boolean_value: boolean,
}

@doc("One result returned by a file-search call.")
model VoiceAgentFileSearchResult {
  attributes?: Record<VoiceAgentFileSearchAttributeValue> | null;
  file_id?: string | null;
  filename?: string | null;
  score?: float64 | null;
  text?: string | null;
}

@doc("A file-search output item.")
model VoiceAgentFileSearchCallItem {
  id: string;
  type: "file_search_call";
  status: VoiceAgentFileSearchCallStatus;
  queries?: string[] | null;
  results?: VoiceAgentFileSearchResult[] | null;
}

@doc("The status of a file-search call.")
union VoiceAgentFileSearchCallStatus {
  in_progress: "in_progress",
  searching: "searching",
  completed: "completed",
  incomplete: "incomplete",
  failed: "failed",
}

@doc("A workflow action output item.")
model VoiceAgentWorkflowActionItem {
  id: string | null;
  object?: "realtime.item" = "realtime.item";
  type: "workflow_action";
  action_id: string;
  status: string;
  kind?: string | null;
  parent_action_id?: string | null;
  previous_action_id?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The runtime response spans the OpenAI item roots plus Foundry tool output kinds."
@doc("An item returned in a voice-agent response or item event.")
union VoiceAgentResponseItem {
  VoiceAgentResponseMessageItem,
  VoiceFunctionCallItem,
  VoiceFunctionCallOutputItem,
  VoiceMcpListToolsItem,
  VoiceMcpCallItem,
  VoiceMcpApprovalRequestItem,
  VoiceMcpApprovalResponseItem,
  VoiceAgentWorkflowActionItem,
  VoiceAgentWebSearchCallItem,
  VoiceAgentFileSearchCallItem,
}

@doc("An audio format reported on a voice-agent response resource.")
union VoiceAgentResponseAudioFormat {
  pcm16: "pcm16",
  pcm16_8000hz: "pcm16_8000hz",
  pcm16_16000hz: "pcm16_16000hz",
  pcm16_22050hz: "pcm16_22050hz",
  pcm16_24000hz: "pcm16_24000hz",
  pcm16_44100hz: "pcm16_44100hz",
  pcm16_48000hz: "pcm16_48000hz",
  g711_ulaw: "g711_ulaw",
  g711_alaw: "g711_alaw",
  mp3: "mp3",
  mp3_24khz_48kbps: "mp3_24khz_48kbps",
  mp3_24khz_96kbps: "mp3_24khz_96kbps",
  mp3_24khz_160kbps: "mp3_24khz_160kbps",
}

@doc("Completeness of a best-effort cost estimate.")
union VoiceAgentEstimatedCostStatus {
  complete: "complete",
  partial: "partial",
  unavailable: "unavailable",
}

@doc("The lifecycle status of a voice-agent response.")
union VoiceAgentResponseStatus {
  in_progress: "in_progress",
  completed: "completed",
  cancelled: "cancelled",
  incomplete: "incomplete",
  failed: "failed",
}

@doc("A best-effort public-retail cost estimate for a response.")
model VoiceAgentEstimatedCost {
  @doc("The total estimated amount, when available.")
  amount: float64 | null;

  @doc("The estimated input cost.")
  input_cost?: float64 | null;

  @doc("The estimated output cost.")
  output_cost?: float64 | null;

  @doc("The estimate currency. Always `USD`.")
  currency?: "USD" = "USD";

  @doc("The portion attributed to Voice Live processing.")
  voice_live_amount: float64;

  @doc("The portion attributed to a customer-provided model.")
  byom_model_amount?: float64 | null;

  @doc("Whether the estimate is complete, partial, or unavailable.")
  status: VoiceAgentEstimatedCostStatus;

  @doc("The Voice Live price version used for the estimate.")
  price_version: string;

  @doc("The customer-provided model price version used for the estimate.")
  byom_model_price_version?: string | null;

  @doc("Components for which no price was available.")
  unpriced_components?: string[] = #[];
}

@doc("A realtime response returned by the voice-agent service.")
model VoiceAgentRealtimeResponse {
  @doc("The object type. Always `realtime.response`.")
  object: "realtime.response";

  @doc("The response identifier.")
  id: string;

  @doc("The response lifecycle status.")
  status: VoiceAgentResponseStatus;

  @doc("Additional details for a terminal response status.")
  status_details: OpenAI.RealtimeResponseStatusDetails | null;

  @doc("The items produced by the response.")
  output: VoiceAgentResponseItem[];

  @doc("Token usage for the response.")
  usage: OpenAI.RealtimeResponseUsage | null;

  @doc("The best-effort response cost estimate. Returned only when cost output is enabled.")
  estimated_cost?: VoiceAgentEstimatedCost;

  @doc("The conversation identifier, or null for an out-of-band response.")
  conversation_id?: string | null;

  @doc("The modalities used by the response.")
  modalities?: VoiceOutputModality[] | null;

  @doc("The voice name used by the response.")
  voice?: string | null;

  @doc("The extensible provider/type of the voice used by the response.")
  voice_type?: string | null;

  @doc("The BCP-47 locale of the voice used by the response.")
  voice_locale?: string | null;

  @doc("The output-audio format used by the response.")
  output_audio_format?: VoiceAgentResponseAudioFormat | null;

  @doc("The sampling temperature used by the response.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null;

  @doc("The maximum output-token count used by the response.")
  max_output_tokens?: VoiceAgentMaxOutputTokens | null;

  @doc("String key-value metadata attached to the response.")
  metadata?: Record<string> | null;
}

@doc("A time-stamped word in an input-audio transcription.")
model VoiceAgentTranscriptionWord {
  @doc("The transcribed word text.")
  text: string;

  @doc("The word offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: int32;

  @doc("The word duration in milliseconds.")
  duration_milliseconds: int32;
}

@doc("A transcribed phrase with timing information.")
model VoiceAgentTranscriptionPhrase {
  @doc("The phrase offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: int32;

  @doc("The phrase duration in milliseconds.")
  duration_milliseconds: int32;

  @doc("The transcribed phrase text.")
  text: string;

  @doc("Word-level timing details, when available.")
  words?: VoiceAgentTranscriptionWord[] | null;

  @doc("The detected locale.")
  locale?: string | null;

  @doc("The transcription confidence score.")
  confidence?: float32 | null;
}

@doc("The `conversation.item.create` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemCreate {
  ...OmitProperties<OpenAI.RealtimeClientEventConversationItemCreate, "item">;

  @doc("The conversation item to create.")
  item: VoiceAgentCreateConversationItem;
}

@doc("The `conversation.item.delete` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemDelete {
  ...OpenAI.RealtimeClientEventConversationItemDelete;
}

@doc("The `conversation.item.retrieve` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemRetrieve {
  ...OpenAI.RealtimeClientEventConversationItemRetrieve;
}

@doc("The `conversation.item.truncate` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemTruncate {
  ...OpenAI.RealtimeClientEventConversationItemTruncate;
}

@doc("The `input_audio_buffer.append` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferAppend {
  ...OpenAI.RealtimeClientEventInputAudioBufferAppend;
}

@doc("The `input_audio_buffer.clear` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferClear {
  ...OpenAI.RealtimeClientEventInputAudioBufferClear;
}

@doc("The `input_audio_buffer.commit` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferCommit {
  ...OpenAI.RealtimeClientEventInputAudioBufferCommit;
}

@doc("The `output_audio_buffer.clear` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventOutputAudioBufferClear {
  ...OpenAI.RealtimeClientEventOutputAudioBufferClear;
}

@doc("The `response.cancel` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventResponseCancel {
  ...OpenAI.RealtimeClientEventResponseCancel;
}

@doc("The `response.create` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventResponseCreate {
  ...OmitProperties<OpenAI.RealtimeClientEventResponseCreate, "response">;

  @doc("Parameters for the new response.")
  response?: VoiceAgentResponseCreateParams;
}

@doc("The `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionUpdate {
  ...OmitProperties<OpenAI.RealtimeClientEventSessionUpdate, "session">;

  @doc("The stable realtime session fields to update.")
  session: VoiceAgentSessionUpdateConfig;
}

@doc("The `conversation.item.added` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemAdded {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemAdded, "item">;

  @doc("The item added to the conversation.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemCreated, "item">;

  @doc("The created conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.deleted` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemDeleted {
  ...OpenAI.RealtimeServerEventConversationItemDeleted;
}

@doc("The `conversation.item.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemDone {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemDone, "item">;

  @doc("The completed conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.input_audio_transcription.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionCompleted {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted;

  @doc("Phrase-level transcription timing and confidence details.")
  phrases?: VoiceAgentTranscriptionPhrase[] | null;
}

@doc("The `conversation.item.input_audio_transcription.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionDelta {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta;
}

@doc("The `conversation.item.input_audio_transcription.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionFailed {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed;
}

@doc("The `conversation.item.input_audio_transcription.segment` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionSegment {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionSegment;
}

@doc("The `conversation.item.retrieved` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemRetrieved {
  ...OmitProperties<
    OpenAI.RealtimeServerEventConversationItemRetrieved,
    "item"
  >;

  @doc("The retrieved conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.truncated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemTruncated {
  ...OpenAI.RealtimeServerEventConversationItemTruncated;

  @doc("The assistant message after truncation, when the service returns the updated item.")
  item?: OpenAI.RealtimeConversationItemMessageAssistant;
}

@doc("The `input_audio_buffer.cleared` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferCleared {
  ...OpenAI.RealtimeServerEventInputAudioBufferCleared;
}

@doc("The `input_audio_buffer.committed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferCommitted {
  ...OpenAI.RealtimeServerEventInputAudioBufferCommitted;
}

@doc("The `input_audio_buffer.speech_started` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferSpeechStarted {
  ...OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted;
}

@doc("The `input_audio_buffer.speech_stopped` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferSpeechStopped {
  ...OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped;
}

@doc("The `input_audio_buffer.timeout_triggered` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferTimeoutTriggered {
  ...OpenAI.RealtimeServerEventInputAudioBufferTimeoutTriggered;
}

@doc("The `mcp_list_tools.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsCompleted {
  ...OpenAI.RealtimeServerEventMCPListToolsCompleted;
}

@doc("The `mcp_list_tools.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsFailed {
  ...OpenAI.RealtimeServerEventMCPListToolsFailed;
}

@doc("The `mcp_list_tools.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsInProgress {
  ...OpenAI.RealtimeServerEventMCPListToolsInProgress;
}

@doc("The `output_audio_buffer.cleared` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventOutputAudioBufferCleared {
  ...OpenAI.RealtimeServerEventOutputAudioBufferCleared;
}

@doc("The `rate_limits.updated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRateLimitsUpdated {
  ...OpenAI.RealtimeServerEventRateLimitsUpdated;
}

@doc("The `response.output_audio.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioDelta {
  ...OpenAI.RealtimeServerEventResponseAudioDelta;
}

@doc("The `response.output_audio.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioDone {
  ...OpenAI.RealtimeServerEventResponseAudioDone;
}

@doc("The `response.output_audio_transcript.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTranscriptDelta {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDelta;
}

@doc("The `response.output_audio_transcript.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTranscriptDone {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDone;
}

@doc("The `response.content_part.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseContentPartDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseContentPartDone, "part">;

  @doc("The content part that finished streaming.")
  part: VoiceAgentResponseEventContentPart;
}

@doc("The `response.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseCreated, "response">;

  @doc("The created voice-agent response.")
  response: VoiceAgentRealtimeResponse;
}

@doc("The `response.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseDone, "response">;

  @doc("The completed voice-agent response.")
  response: VoiceAgentRealtimeResponse;
}

@doc("The `response.function_call_arguments.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseFunctionCallArgumentsDelta {
  ...OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta;
}

@doc("The `response.function_call_arguments.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseFunctionCallArgumentsDone {
  ...OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone;
}

@doc("The `response.mcp_call_arguments.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallArgumentsDelta {
  ...OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta;
}

@doc("The `response.mcp_call_arguments.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallArgumentsDone {
  ...OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone;
}

@doc("The `response.mcp_call.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallCompleted {
  ...OpenAI.RealtimeServerEventResponseMCPCallCompleted;
}

@doc("The `response.mcp_call.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallFailed {
  ...OpenAI.RealtimeServerEventResponseMCPCallFailed;
}

@doc("The `response.mcp_call.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallInProgress {
  ...OpenAI.RealtimeServerEventResponseMCPCallInProgress;
}

@doc("Fields shared by web-search lifecycle server events.")
model VoiceAgentWebSearchLifecycleEventProperties {
  event_id?: string;
  response_id?: string = "";
  item_id: string;
  output_index: int32;
  sequence_number: int32;
}

@doc("The `response.web_search_call.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWebSearchCallInProgress {
  type: "response.web_search_call.in_progress";
  ...VoiceAgentWebSearchLifecycleEventProperties;
}

@doc("The `response.web_search_call.searching` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWebSearchCallSearching {
  type: "response.web_search_call.searching";
  ...VoiceAgentWebSearchLifecycleEventProperties;
}

@doc("The `response.web_search_call.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWebSearchCallCompleted {
  type: "response.web_search_call.completed";
  ...VoiceAgentWebSearchLifecycleEventProperties;
}

@doc("Fields shared by file-search lifecycle server events.")
model VoiceAgentFileSearchLifecycleEventProperties {
  event_id?: string;
  response_id?: string = "";
  item_id: string;
  output_index: int32;
  sequence_number: int32;
}

@doc("The `response.file_search_call.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventFileSearchCallInProgress {
  type: "response.file_search_call.in_progress";
  ...VoiceAgentFileSearchLifecycleEventProperties;
}

@doc("The `response.file_search_call.searching` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventFileSearchCallSearching {
  type: "response.file_search_call.searching";
  ...VoiceAgentFileSearchLifecycleEventProperties;
}

@doc("The `response.file_search_call.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventFileSearchCallCompleted {
  type: "response.file_search_call.completed";
  ...VoiceAgentFileSearchLifecycleEventProperties;
}

@doc("The `response.output_item.added` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseOutputItemAdded {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseOutputItemAdded, "item">;

  @doc("The output item that was added.")
  item: VoiceAgentResponseItem;
}

@doc("The `response.output_item.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseOutputItemDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseOutputItemDone, "item">;

  @doc("The output item that finished streaming.")
  item: VoiceAgentResponseItem;
}

@doc("The `response.output_text.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseTextDelta {
  ...OpenAI.RealtimeServerEventResponseTextDelta;
}

@doc("The `response.output_text.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseTextDone {
  ...OpenAI.RealtimeServerEventResponseTextDone;
}

@doc("The `session.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventSessionCreated, "session">;

  @doc("The initial effective voice-agent session configuration.")
  session: VoiceAgentSessionResponseConfig;
}

@doc("The `session.updated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionUpdated {
  ...OmitProperties<OpenAI.RealtimeServerEventSessionUpdated, "session">;

  @doc("The effective voice-agent session configuration after the update.")
  session: VoiceAgentSessionResponseConfig;
}

@doc("The `session.avatar.connect` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionAvatarConnect {
  @doc("The event type. Always `session.avatar.connect`.")
  type: "session.avatar.connect";

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for avatar media negotiation.")
  client_sdp: string;
}

@doc("The `conversation.created` server event emitted when a voice-agent connection starts.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationCreated {
  type: "conversation.created";

  @doc("The identifier of the created conversation.")
  conversation_id: string;
}

@doc("The `error` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventError {
  @doc("The unique identifier of the event.")
  event_id: string;

  type: "error";

  @doc("Details of the error.")
  error: VoiceAgentServerEventErrorDetails;
}

@doc("Details of a voice-agent WebSocket error.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventErrorDetails {
  ...OpenAI.RealtimeServerEventErrorError;

  @doc("The configured label of a tool that could not be resolved.")
  tool_label?: string;

  @doc("The configured type of a tool that could not be resolved.")
  tool_type?: string;
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
model VoiceAgentServerEventWarning {
  type: "warning";
  event_id: string;
  warning: VoiceAgentServerEventWarningDetails;
}

@doc("The `session.avatar.connecting` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarConnecting {
  type: "session.avatar.connecting";
  event_id: string;

  @doc("The server's SDP answer for avatar media negotiation.")
  server_sdp: string;
}

@doc("The `session.avatar.switch_to_speaking` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToSpeaking {
  type: "session.avatar.switch_to_speaking";
  event_id: string;
  turn_id?: string;
}

@doc("The `session.avatar.switch_to_idle` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToIdle {
  type: "session.avatar.switch_to_idle";
  event_id: string;
  turn_id?: string;
}

@doc("The `response.audio_timestamp.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDelta {
  type: "response.audio_timestamp.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  audio_duration_ms: int32;
  text: string;
  timestamp_type: "word";
}

@doc("The `response.audio_timestamp.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDone {
  type: "response.audio_timestamp.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.animation_blendshapes.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDelta {
  type: "response.animation_blendshapes.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The service sends either JSON frame arrays or a compact encoded string."
  @doc("Animation frames as numeric blendshape weights or a compact encoded string.")
  frames: float32[][] | string;

  @doc("The index of the first frame in this delta.")
  frame_index: int32;
}

@doc("The `response.animation_blendshapes.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDone {
  type: "response.animation_blendshapes.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
}

@doc("The `response.animation_viseme.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDelta {
  type: "response.animation_viseme.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  viseme_id: int32;
}

@doc("The `response.animation_viseme.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDone {
  type: "response.animation_viseme.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.video.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseVideoDelta {
  type: "response.video.delta";
  event_id: string;
  output_index: int32;
  codec: string;

  @doc("The base64-encoded video frame data.")
  delta: string;
}

@doc("The response that switches an HTTP connection to the voice-agent WebSocket protocol.")
model VoiceAgentWebSocketUpgradeResponse {
  @statusCode
  status_code: 101;

  @doc("The negotiated WebSocket subprotocol. Present only when the client requests `realtime`.")
  @header("Sec-WebSocket-Protocol")
  subprotocol?: VoiceAgentWebSocketSubprotocol;
}
