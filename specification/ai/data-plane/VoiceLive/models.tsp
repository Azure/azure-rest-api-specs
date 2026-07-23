import "./client.tsp";
import "./custom.tsp";
import "./events.tsp";
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
/** A voicelive client event. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the OpenAI GA client-event base so Azure-only client events ride on GA."
@discriminator("type")
@usage(RequestUsage)
model ClientEvent extends OpenAI.RealtimeClientEvent {
  /** The type of event. */
  type: ClientEventType;

  event_id?: string;
}

// `session.update` client event is consumed from OpenAI GA
// (`RealtimeClientEventSessionUpdate`), with its `session` payload retyped to
// VoiceLive's `RequestSession` in custom.tsp.
/**

 * Sent when the client connects and provides its SDP (Session Description Protocol)

 * for avatar-related media negotiation.

 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventSessionAvatarConnect extends ClientEvent {
  /** The event type, must be 'session.avatar.connect'. */
  type: ClientEventType.session_avatar_connect;

  /** The client's SDP offer. */
  client_sdp: string;
}

/** Indicates the start of a new audio input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnStart extends ClientEvent {
  /** The event type, must be 'input_audio.turn.start'. */
  type: ClientEventType.input_audio_turn_start;

  /** Unique identifier for the input audio turn. */
  turn_id: string;
}

/** Appends audio data to an ongoing input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnAppend extends ClientEvent {
  /** The event type, must be 'input_audio.turn.append'. */
  type: ClientEventType.input_audio_turn_append;

  /** The ID of the turn this audio is part of. */
  turn_id: string;

  /** Base64-encoded audio chunk. */
  audio: string;
}

/** Marks the end of an audio input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnEnd extends ClientEvent {
  /** The event type, must be 'input_audio.turn.end'. */
  type: ClientEventType.input_audio_turn_end;

  /** The ID of the audio turn being ended. */
  turn_id: string;
}

/** Cancels an in-progress input audio turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioTurnCancel extends ClientEvent {
  /** The event type, must be 'input_audio.turn.cancel'. */
  type: ClientEventType.input_audio_turn_cancel;

  /** The ID of the turn to cancel. */
  turn_id: string;
}

/** Clears all input audio currently being streamed. */
@removed(Versions.v1)
@usage(RequestUsage)
model ClientEventInputAudioClear extends ClientEvent {
  /** The event type, must be 'input_audio.clear'. */
  type: ClientEventType.input_audio_clear;
}

/** Streams a delta of input text content into the specified item. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventInputTextDelta extends ClientEvent {
  /** The event type, must be `input_text.delta`. */
  type: ClientEventType.input_text_delta;

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
model ClientEventInputTextDone extends ClientEvent {
  /** The event type, must be `input_text.done`. */
  type: ClientEventType.input_text_done;

  /** The ID of the item whose text content has finished streaming. */
  id: string;

  /** The index of the content part within the item. */
  content_index?: int32 = 0;
}

/** Updates authorization headers for an active bring-your-own-model connection. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventBYOMCredentialUpdate extends ClientEvent {
  /** The event type, must be `byom_credential.update`. */
  type: ClientEventType.byom_credential_update;

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
 * `ResponseItem` union so Azure-specific response items (message, MCP, web/file
 * search) are preserved alongside OpenAI's function-call items. VoiceLive migrates
 * from the beta response shape to GA: `modalities`/`output_audio_format`/`voice`
 * are replaced by the inherited GA `output_modalities` and nested `audio`.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentionally extending the OpenAI GA response to migrate VoiceLive from the Realtime beta shape to GA."
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
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
@usage(ResponseUsage)
model ServerEventWarning extends ServerEvent {
  /** The event type, must be `warning`. */
  type: ServerEventType.warning;

  /** Details of the warning. */
  warning: ServerEventWarningDetails;
}

/** Confirms that BYOM authorization headers were updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventBYOMCredentialUpdated extends ServerEvent {
  /** The event type, must be `byom_credential.updated`. */
  type: ServerEventType.byom_credential_updated;

  /** Updated authorization header names with their values redacted. */
  authorization_headers: Record<string>;
}

// ServerEventSessionCreated consumed from OpenAI GA (OpenAI.RealtimeServerEventSessionCreated; session payload retyped in custom.tsp)

// ServerEventSessionUpdated consumed from OpenAI GA (OpenAI.RealtimeServerEventSessionUpdated; session payload retyped in custom.tsp)

/** Sent when the server is in the process of establishing an avatar media connection and provides its SDP answer. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventSessionAvatarConnecting extends ServerEvent {
  /** The event type, must be 'session.avatar.connecting'. */
  type: ServerEventType.session_avatar_connecting;

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
/** A voicelive server event. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the OpenAI GA server-event base so Azure-only server events ride on GA."
@discriminator("type")
@usage(ResponseUsage)
model ServerEvent extends OpenAI.RealtimeServerEvent {
  /** The type of event. */
  type: ServerEventType;

  event_id?: string;
}

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
model ServerEventResponseAnimationBlendshapeDelta extends ServerEvent {
  type: ServerEventType.response_animation_blendshapes_delta;
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
model ServerEventResponseAnimationBlendshapeDone extends ServerEvent {
  type: ServerEventType.response_animation_blendshapes_done;
  response_id: string;
  item_id: string;
  output_index: int32;
}

/** Represents a word-level audio timestamp delta for a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioTimestampDelta extends ServerEvent {
  type: ServerEventType.response_audio_timestamp_delta;
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
model ServerEventResponseAudioTimestampDone extends ServerEvent {
  type: ServerEventType.response_audio_timestamp_done;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/** Represents a viseme ID delta update for animation based on audio. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.PuPr)
@usage(ResponseUsage)
model ServerEventResponseAnimationVisemeDelta extends ServerEvent {
  type: ServerEventType.response_animation_viseme_delta;
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
model ServerEventResponseAnimationVisemeDone extends ServerEvent {
  type: ServerEventType.response_animation_viseme_done;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/**
 * Create a new VoiceLive response with these parameters: the OpenAI GA Realtime
 * `RealtimeResponseCreateParams` plus Azure extensions. VoiceLive migrates from
 * the beta shape to GA — `modalities`/`voice`/`output_audio_format` are replaced
 * by the inherited GA `output_modalities` and nested `audio`, and `reasoning_effort`
 * by the inherited GA `reasoning`.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Intentionally extending the OpenAI GA response-create params to migrate VoiceLive from the Realtime beta shape to GA."
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ResponseCreateParams extends OpenAI.RealtimeResponseCreateParams {
  /** Whether to commit the response to the conversation. Defaults to true. (Azure extension) */
  commit?: boolean = true;

  /** Whether to cancel any ongoing generation before starting this one. Defaults to true. (Azure extension) */
  cancel_previous?: boolean = true;

  /** Input items to append to the conversation context before generating a response. (Azure extension) */
  append_input_items?: ConversationRequestItem[];

  /**
   * Input items to be used as the context for this response.
   * An empty array clears previous context. (Azure extension)
   */
  input_items?: ConversationRequestItem[];

  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. (Azure extension) */
  temperature?: float32;

  /**
   * Create the response with pre-generated assistant message. The message item would be
   * added into the conversation history and returned with synthesized audio output in the created response. (Azure extension)
   */
  pre_generated_assistant_message?: OpenAI.RealtimeConversationItemMessageAssistant;

  /** Configuration for interim response generation during latency or tool calls. (Azure extension) */
  interim_response?: InterimResponseConfig;

  /** Input data to invoke the hosted agent. (Azure extension) */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Opaque passthrough: values are user-provided input forwarded to the hosted agent, whose schema is not defined by this API."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Opaque passthrough JSON from hosted agent; values are not limited to strings."
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
model ServerEventSessionAvatarSwitchToSpeaking extends ServerEvent {
  /** The event type, must be `session.avatar.switch_to_speaking`. */
  type: ServerEventType.session_avatar_switch_to_speaking;

  /** The ID of the turn associated with the avatar state change. */
  turn_id?: string;
}

/** Returned when the avatar switches to idle state. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventSessionAvatarSwitchToIdle extends ServerEvent {
  /** The event type, must be `session.avatar.switch_to_idle`. */
  type: ServerEventType.session_avatar_switch_to_idle;

  /** The ID of the turn associated with the avatar state change. */
  turn_id?: string;
}

/** Returned when avatar video frame data is streamed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseVideoDelta extends ServerEvent {
  /** The event type, must be `response.video.delta`. */
  type: ServerEventType.response_video_delta;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The codec used for the video data. */
  codec: string;

  /** The base64-encoded video frame data. */
  delta: string;
}

/** Returned when a web search call is searching. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallSearching extends ServerEvent {
  /** The event type, must be `response.web_search_call.searching`. */
  type: ServerEventType.response_web_search_call_searching;

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
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallInProgress extends ServerEvent {
  /** The event type, must be `response.web_search_call.in_progress`. */
  type: ServerEventType.response_web_search_call_in_progress;

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
@usage(ResponseUsage)
model ServerEventResponseWebSearchCallCompleted extends ServerEvent {
  /** The event type, must be `response.web_search_call.completed`. */
  type: ServerEventType.response_web_search_call_completed;

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
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallSearching extends ServerEvent {
  /** The event type, must be `response.file_search_call.searching`. */
  type: ServerEventType.response_file_search_call_searching;

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
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallInProgress extends ServerEvent {
  /** The event type, must be `response.file_search_call.in_progress`. */
  type: ServerEventType.response_file_search_call_in_progress;

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
@usage(ResponseUsage)
model ServerEventResponseFileSearchCallCompleted extends ServerEvent {
  /** The event type, must be `response.file_search_call.completed`. */
  type: ServerEventType.response_file_search_call_completed;

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
model ServerEventResponseAudioTranscriptAnnotationAdded extends ServerEvent {
  /** The event type, must be `response.audio_transcript.annotation.added`. */
  type: ServerEventType.response_audio_transcript_annotation_added;

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
@usage(ResponseUsage)
model ServerEventResponseInvocationDelta extends ServerEvent {
  /** The event type, must be `response.invocation.delta`. */
  type: ServerEventType.response_invocation_delta;

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
model ClientEventRtcCallSdpCreate extends ClientEvent {
  /** The event type, must be `rtc.call.sdp.create`. */
  type: ClientEventType.rtc_call_sdp_create;

  /** The SDP offer from the client for WebRTC negotiation. */
  sdp_offer: string;

  /** Optional initial session configuration. If provided, applied before the session is established. */
  session?: RequestSession;
}

/** Returned when the WebRTC SDP negotiation completes successfully. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(ResponseUsage)
model ServerEventRtcCallSdpCreated extends ServerEvent {
  /** The event type, must be `rtc.call.sdp.created`. */
  type: ServerEventType.rtc_call_sdp_created;

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
model ServerEventRtcCallError extends ServerEvent {
  /** The event type, must be `rtc.call.error`. */
  type: ServerEventType.rtc_call_error;

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
