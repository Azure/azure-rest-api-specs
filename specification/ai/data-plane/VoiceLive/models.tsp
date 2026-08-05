import "./client.tsp";
import "./custom.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace VoiceLive;

alias RequestUsage =
  | Azure.ClientGenerator.Core.Usage.input
  | Azure.ClientGenerator.Core.Usage.json;
alias ResponseUsage =
  | Azure.ClientGenerator.Core.Usage.output
  | Azure.ClientGenerator.Core.Usage.json;
alias DualUsage = RequestUsage | ResponseUsage;

/** Standard error response envelope. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@error
@usage(ResponseUsage)
model ErrorResponse {
  /** Error object returned in case of API failure (OpenAI GA Realtime error object). */
  error: OpenAI.RealtimeServerEventErrorError;
}

/** A single log probability entry for a token. */
@usage(ResponseUsage)
model LogProbProperties {
  /** The token that was used to generate the log probability. */
  token: string;

  /** The log probability of the token. */
  logprob: float32;

  /** The bytes that were used to generate the log probability. */
  bytes: int32[];
}

// Tool customization: VoiceLive client events migrate onto OpenAI GA. The base
// extends `OpenAI.RealtimeClientEvent`; simple/rich events are consumed from
// OpenAI directly (see `custom.tsp` augmentations), and Azure-only events extend
// this base (transitively OpenAI's).
// `session.update` client event is consumed from OpenAI GA
// (`RealtimeClientEventSessionUpdate`), with its `session` payload retyped to
// VoiceLive's `RequestSession` in custom.tsp.
/**

 * Sent when the client connects and provides its SDP (Session Description Protocol)

 * for avatar-related media negotiation.

 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventSessionAvatarConnect extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'session.avatar.connect'. */
  type: "session.avatar.connect";

  event_id?: string;

  /** The client's SDP offer. */
  client_sdp: string;
}

/** Indicates the start of a new audio input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnStart extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'input_audio.turn.start'. */
  type: "input_audio.turn.start";

  event_id?: string;

  /** Unique identifier for the input audio turn. */
  turn_id: string;
}

/** Appends audio data to an ongoing input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnAppend extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'input_audio.turn.append'. */
  type: "input_audio.turn.append";

  event_id?: string;

  /** The ID of the turn this audio is part of. */
  turn_id: string;

  /** Base64-encoded audio chunk. */
  audio: string;
}

/** Marks the end of an audio input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnEnd extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'input_audio.turn.end'. */
  type: "input_audio.turn.end";

  event_id?: string;

  /** The ID of the audio turn being ended. */
  turn_id: string;
}

/** Cancels an in-progress input audio turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnCancel extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'input_audio.turn.cancel'. */
  type: "input_audio.turn.cancel";

  event_id?: string;

  /** The ID of the turn to cancel. */
  turn_id: string;
}

/** Clears all input audio currently being streamed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // `event_id` matches OpenAI GA snake_case.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioClear extends OpenAI.RealtimeClientEvent {
  /** The event type, must be 'input_audio.clear'. */
  type: "input_audio.clear";

  event_id?: string;
}

/** Streams a delta of input text content into the specified item. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventInputTextDelta extends OpenAI.RealtimeClientEvent {
  /** The event type, must be `input_text.delta`. */
  type: "input_text.delta";

  event_id?: string;

  /** The ID of the item the text delta is being appended to. */
  id: string;

  /** The text delta to append. */
  delta: string;

  /** The index of the content part within the item the delta applies to. */
  content_index?: int32 = 0;
}

/** Signals that the streamed input text content for the specified item is complete. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventInputTextDone extends OpenAI.RealtimeClientEvent {
  /** The event type, must be `input_text.done`. */
  type: "input_text.done";

  event_id?: string;

  /** The ID of the item whose text content has finished streaming. */
  id: string;

  /** The index of the content part within the item. */
  content_index?: int32 = 0;
}

/** Updates authorization headers for an active bring-your-own-model connection. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventBYOMCredentialUpdate extends OpenAI.RealtimeClientEvent {
  /** The event type, must be `byom_credential.update`. */
  type: "byom_credential.update";

  event_id?: string;

  /** Authorization header names and values to apply to subsequent BYOM requests. */
  authorization_headers: Record<string>;
}

// Tool customization: establish custom, enriched discriminated type hierarchy
/** The item to add to the conversation. */
@usage(RequestUsage)
model ConversationItemBase {
  /** Customized to enriched Conversation{Request,Response}Item models */
}

/**
 * The response resource: the OpenAI GA Realtime response (`RealtimeResponse`)
 * plus Azure extensions. The inherited `output` list is retyped to VoiceLive's
 * `ResponseItem` union so standard message, function, and MCP items are preserved;
 * preview additionally includes Azure web/file-search items. VoiceLive migrates
 * from the beta response shape to GA: `modalities`/`output_audio_format`/`voice`
 * are replaced by the inherited GA `output_modalities` and nested `audio`.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentionally extending the OpenAI GA response to migrate VoiceLive from the Realtime beta shape to GA."
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@usage(ResponseUsage)
model Response extends OpenAI.RealtimeResponse {
  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. (Azure extension) */
  temperature?: float32;
}

// `input_audio_buffer.append` / `.commit` / `.clear` client events are consumed
// directly from OpenAI GA (RealtimeClientEventInputAudioBuffer*).
// `conversation.item.create` client event is consumed from OpenAI GA
// (`RealtimeClientEventConversationItemCreate`), with its `item` payload retyped
// to VoiceLive's `ConversationRequestItem` in custom.tsp.
// `conversation.item.truncate` / `.delete` client events are consumed directly
// from OpenAI GA (RealtimeClientEventConversationItemTruncate / Delete).
// `response.create` client event is consumed from OpenAI GA
// (`RealtimeClientEventResponseCreate`), with its `response` payload retyped to
// VoiceLive's `ResponseCreateParams` and the Azure `additional_instructions`
// field added, in custom.tsp. `response.cancel` is consumed directly.
// ServerEventError consumed from OpenAI GA (OpenAI.RealtimeServerEventError)

/** Details of the warning. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventWarningDetails {
  /** A human-readable warning message. */
  message: string;

  /** Warning code, if any. */
  code?: string;

  /** Parameter related to the warning, if any. */
  param?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a warning occurs that does not interrupt the conversation flow.
 * Warnings are informational and the session will continue normally.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // `event_id` matches OpenAI GA snake_case.
@usage(ResponseUsage)
model ServerEventWarning extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `warning`. */
  type: "warning";

  event_id?: string;

  /** Details of the warning. */
  warning: ServerEventWarningDetails;
}

/** Confirms that BYOM authorization headers were updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventBYOMCredentialUpdated extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `byom_credential.updated`. */
  type: "byom_credential.updated";

  event_id?: string;

  /** Updated authorization header names with their values redacted. */
  authorization_headers: Record<string>;
}

// ServerEventSessionUpdated consumed from OpenAI GA (OpenAI.RealtimeServerEventSessionUpdated; session payload retyped in custom.tsp)

/** Sent when the server is in the process of establishing an avatar media connection and provides its SDP answer. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventSessionAvatarConnecting extends OpenAI.RealtimeServerEvent {
  /** The event type, must be 'session.avatar.connecting'. */
  type: "session.avatar.connecting";

  event_id?: string;

  /** The server's SDP answer for the avatar connection. */
  server_sdp: string;
}

// Tool customization: establish base for enriched request/response split models
/** VoiceLive session object configuration. */
@usage(ResponseUsage)
model SessionBase {}

// Tool customization: VoiceLive server events migrate onto OpenAI GA. The base
// extends `OpenAI.RealtimeServerEvent`; simple/rich events are consumed from
// OpenAI directly (see `custom.tsp` augmentations), and Azure-only events extend
// this base (transitively OpenAI's).
// `input_audio_buffer.committed` / `.cleared` / `.speech_started` /
// `.speech_stopped` and `conversation.item.created` server events are consumed
// from OpenAI GA directly (`conversation.item.created`'s `item` payload is
// retyped to VoiceLive's `ResponseItem` in custom.tsp).

// ServerEventConversationItemInputAudioTranscriptionCompleted consumed from OpenAI GA (azure `phrases` re-injected in custom.tsp)

/** A time-stamped word in the transcription. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model TranscriptionWord {
  /** The transcribed word text. */
  text: string;

  /** Offset from the start of the audio in milliseconds. */
  offset_milliseconds: int32;

  /** Duration of the word in milliseconds. */
  duration_milliseconds: int32;
}

/** A transcribed phrase with timing information. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model TranscriptionPhrase {
  /** Offset from the start of the audio in milliseconds. */
  offset_milliseconds: int32;

  /** Duration of the phrase in milliseconds. */
  duration_milliseconds: int32;

  /** The transcribed text of the phrase. */
  text: string;

  /** The individual words in the phrase with timing information. */
  words?: TranscriptionWord[];

  /** The locale of the transcription (e.g., 'en-US'). */
  locale?: string;

  /** The confidence score of the transcription. */
  confidence?: float32;
}

// ServerEventConversationItemInputAudioTranscriptionFailed consumed from OpenAI GA (OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed)

// ServerEventConversationItemTruncated consumed from OpenAI GA (OpenAI.RealtimeServerEventConversationItemTruncated)

// ServerEventConversationItemDeleted consumed from OpenAI GA (OpenAI.RealtimeServerEventConversationItemDeleted)

// ServerEventResponseCreated consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseCreated)

// ServerEventResponseDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseDone)

// ServerEventResponseOutputItemAdded consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseOutputItemAdded)

// ServerEventResponseOutputItemDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseOutputItemDone)

// ServerEventResponseContentPartAdded consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseContentPartAdded; part payload retyped in custom.tsp)

// ServerEventResponseContentPartDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseContentPartDone; part payload retyped in custom.tsp)

// ServerEventResponseTextDelta consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseTextDelta)

// ServerEventResponseTextDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseTextDone)

// ServerEventResponseAudioTranscriptDelta consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseAudioTranscriptDelta)

// ServerEventResponseAudioTranscriptDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseAudioTranscriptDone)

// ServerEventResponseAudioDelta / ServerEventResponseAudioDone consumed from
// OpenAI GA (OpenAI.RealtimeServerEventResponseAudioDelta / ...AudioDone). As
// part of the beta->GA migration the event `type` changes from
// `response.audio.delta`/`.done` to `response.output_audio.delta`/`.done`.

/** Represents a delta update of blendshape animation frames for a specific output of a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAnimationBlendshapeDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_blendshapes.delta";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This is how it's represented OpenAI Style."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  frames: float32[][] | string;
  frame_index: int32;
}

/** Indicates the completion of blendshape animation processing for a specific output of a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAnimationBlendshapeDone
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_blendshapes.done";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
}

/** Represents a word-level audio timestamp delta for a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioTimestampDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.audio_timestamp.delta";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  audio_duration_ms: int32;
  text: string;
  timestamp_type: "word";
}

/** Indicates completion of audio timestamp delivery for a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioTimestampDone extends OpenAI.RealtimeServerEvent {
  type: "response.audio_timestamp.done";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/** Represents a viseme ID delta update for animation based on audio. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAnimationVisemeDelta
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_viseme.delta";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  viseme_id: int32;
}

/** Indicates completion of viseme animation delivery for a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAnimationVisemeDone
  extends OpenAI.RealtimeServerEvent {
  type: "response.animation_viseme.done";
  event_id?: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/** Response-level audio configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ResponseCreateAudio {
  /** Output audio configuration for this response. */
  output?: AudioOutputConfig;
}

/** Conversation association for a generated response. */
union ResponseConversation {
  auto: "auto",
  none: "none",
}

/** Create a new VoiceLive response using the OpenAI Realtime GA wire shape. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ResponseCreateParams {
  /** Whether this response is added to the default conversation. */
  conversation?: ResponseConversation = ResponseConversation.auto;

  /** Inline GA conversation context for this response. */
  input?: ConversationRequestItem[];

  /** Instructions applied only to this response. */
  instructions?: string;

  /** Maximum output tokens for this response. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches the OpenAI Realtime max-token wire shape."
  max_output_tokens?: integer | "inf";

  /** Up to 16 string key-value metadata pairs. */
  metadata?: Record<string>;

  /** Modalities the response may return. */
  output_modalities?: SessionModality[];

  /** Response-level audio output configuration. */
  audio?: ResponseCreateAudio;

  /** Function tools available for this response. */
  tools?: OpenAI.RealtimeFunctionTool[];

  /** Tool selection behavior for this response. */
  tool_choice?: VoiceLiveToolChoice;

  /** Create the response with a pre-generated assistant message. */
  pre_generated_assistant_message?: OpenAI.RealtimeConversationItemMessageAssistant;

  /** Configuration for interim response generation during latency or tool calls. */
  interim_response?: InterimResponseConfig;

  /** Whether compatible realtime models may call tools in parallel. */
  parallel_tool_calls?: boolean;

  /** Reasoning configuration for compatible realtime models. */
  reasoning?: OpenAI.RealtimeReasoning;

  /** Preview response-commit behavior. Use `conversation` in v1. */
  @removed(Versions.v1)
  commit?: boolean = true;

  /** Preview cancellation behavior. Send `response.cancel` explicitly in v1. */
  @removed(Versions.v1)
  cancel_previous?: boolean = true;

  /** Preview input append behavior. Build the v1 `input` list explicitly. */
  @removed(Versions.v1)
  append_input_items?: ConversationRequestItem[];

  /** Preview response input field. An empty array clears context; use `input` in v1. */
  @removed(Versions.v1)
  input_items?: ConversationRequestItem[];

  /** Preview response-level temperature. Configure compatible cascaded v1 sessions instead. */
  @removed(Versions.v1)
  temperature?: float32;

  /** Preview hosted-agent invocation input. Hosted agents are excluded from v1. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Opaque passthrough: values are user-provided input forwarded to the hosted agent, whose schema is not defined by this API."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Opaque passthrough JSON from hosted agent; values are not limited to strings."
  @removed(Versions.v1)
  invoke_input?: Record<unknown>;
}

// `conversation.item.retrieve` client event is consumed directly from OpenAI GA
// (`RealtimeClientEventConversationItemRetrieve`).

// ServerEventConversationItemInputAudioTranscriptionDelta consumed from OpenAI GA (OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta)

// ServerEventConversationItemRetrieved consumed from OpenAI GA (OpenAI.RealtimeServerEventConversationItemRetrieved)

// ServerEventResponseFunctionCallArgumentsDelta consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta)

// ServerEventResponseFunctionCallArgumentsDone consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone)

// ServerEventMcpListToolsInProgress / Completed / Failed consumed from OpenAI GA
// (OpenAI.RealtimeServerEventMCPListToolsInProgress / Completed / Failed)

// ServerEventResponseMcpCallArgumentsDelta / Done and ServerEventResponseMcpCallInProgress /
// Completed / Failed consumed from OpenAI GA (OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta /
// Done, OpenAI.RealtimeServerEventResponseMCPCallInProgress / Completed / Failed)

// -----------------------------------------------------------------------
// Avatar, web/file search, and audio-transcript annotation events
// -----------------------------------------------------------------------

/** Returned when the avatar switches to speaking state. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventSessionAvatarSwitchToSpeaking
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `session.avatar.switch_to_speaking`. */
  type: "session.avatar.switch_to_speaking";

  event_id?: string;

  /** The ID of the turn associated with the avatar state change. */
  turn_id?: string;
}

/** Returned when the avatar switches to idle state. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventSessionAvatarSwitchToIdle extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `session.avatar.switch_to_idle`. */
  type: "session.avatar.switch_to_idle";

  event_id?: string;

  /** The ID of the turn associated with the avatar state change. */
  turn_id?: string;
}

/** Returned when avatar video frame data is streamed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseVideoDelta extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.video.delta`. */
  type: "response.video.delta";

  event_id?: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The codec used for the video data. */
  codec: string;

  /** The base64-encoded video frame data. */
  delta: string;
}

/** Returned when a web search call is searching. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallSearching
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.web_search_call.searching`. */
  type: "response.web_search_call.searching";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the web search call. */
  sequence_number: int32;
}

/** Returned when a web search call is in progress. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallInProgress
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.web_search_call.in_progress`. */
  type: "response.web_search_call.in_progress";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the web search call. */
  sequence_number: int32;
}

/** Returned when a web search call has completed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallCompleted
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.web_search_call.completed`. */
  type: "response.web_search_call.completed";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the web search call. */
  sequence_number: int32;
}

/** Returned when a file search call is searching. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallSearching
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.file_search_call.searching`. */
  type: "response.file_search_call.searching";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the file search call. */
  sequence_number: int32;
}

/** Returned when a file search call is in progress. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallInProgress
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.file_search_call.in_progress`. */
  type: "response.file_search_call.in_progress";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the file search call. */
  sequence_number: int32;
}

/** Returned when a file search call has completed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallCompleted
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.file_search_call.completed`. */
  type: "response.file_search_call.completed";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The sequence number of the file search call. */
  sequence_number: int32;
}

// ServerEventOutputAudioBufferCleared consumed from OpenAI GA (OpenAI.RealtimeServerEventOutputAudioBufferCleared)

/** Returned when an audio transcript annotation is added to a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/no-unknown" // The annotation can be of any type.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAudioTranscriptAnnotationAdded
  extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.audio_transcript.annotation.added`. */
  type: "response.audio_transcript.annotation.added";

  event_id?: string;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  /** The index of the annotation. */
  annotation_index: int32;

  /** The annotation object. */
  annotation: unknown;
}

/** Returned when a hosted agent invocation produces a non-speech SSE event, passed through as-is. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Opaque passthrough: delta contains raw SSE event JSON from the hosted agent, whose schema is not defined by this API."
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Opaque passthrough JSON from hosted agent SSE event; values are not limited to strings."
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventResponseInvocationDelta extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `response.invocation.delta`. */
  type: "response.invocation.delta";

  event_id?: string;

  /** The raw event data from the hosted agent invocation. */
  delta: Record<unknown>;
}

// -----------------------------------------------------------------------
// Output audio buffer client event
// -----------------------------------------------------------------------

// `output_audio_buffer.clear` client event is consumed directly from OpenAI GA
// (`RealtimeClientEventOutputAudioBufferClear`).

// -----------------------------------------------------------------------
// WebRTC events (preview-only; fenced out of GA with @removed(Versions.v1))
//
// Session flow:
//   1. Client sends rtc.call.sdp.create (with SDP offer + optional session config)
//   2. Server responds with rtc.call.sdp.created (SDP answer + call ID)
//      — or rtc.call.error if something goes wrong
//   3. Audio flows → output_audio_buffer.started / .stopped track playback state
// -----------------------------------------------------------------------

// --- 1. Session creation ---

/** Sent by the client to initiate a WebRTC session with an SDP offer. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventRtcCallSdpCreate extends OpenAI.RealtimeClientEvent {
  /** The event type, must be `rtc.call.sdp.create`. */
  type: "rtc.call.sdp.create";

  event_id?: string;

  /** The SDP offer from the client for WebRTC negotiation. */
  sdp_offer: string;

  /** Optional initial session configuration. If provided, applied before the session is established. */
  session?: RequestSession;
}

/** Returned when the WebRTC SDP negotiation completes successfully. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventRtcCallSdpCreated extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `rtc.call.sdp.created`. */
  type: "rtc.call.sdp.created";

  event_id?: string;

  /** The unique identifier for this RTC call session. */
  rtc_call_id: string;

  /** The SDP answer from the server for WebRTC negotiation. */
  sdp_answer: string;
}

// --- 2. Errors ---

/** Error details for RTC call errors. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model RtcCallErrorDetails {
  /** The error category: `invalid_request_error` or `server_error`. */
  type: string;

  /** A machine-readable error code. */
  code?: string;

  /** A human-readable error description. */
  message: string;
}

/** Returned when a WebRTC call operation fails. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventRtcCallError extends OpenAI.RealtimeServerEvent {
  /** The event type, must be `rtc.call.error`. */
  type: "rtc.call.error";

  event_id?: string;

  /** The operation that caused the error (e.g., `rtc.call.sdp.create`). */
  operation?: string;

  /** The RTC call identifier, if available. */
  rtc_call_id?: string;

  /** The error details. */
  error: RtcCallErrorDetails;
}

// --- 3. Audio playback state ---

// ServerEventOutputAudioBufferStarted / Stopped consumed from OpenAI GA
// (OpenAI.RealtimeServerEventOutputAudioBufferStarted / Stopped)
