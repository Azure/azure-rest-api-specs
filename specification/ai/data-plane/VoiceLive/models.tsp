import "./client.tsp";
import "./custom.tsp";
import "./events.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

alias RequestUsage = Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.json;
alias ResponseUsage = Azure.ClientGenerator.Core.Usage.output | Azure.ClientGenerator.Core.Usage.json;
alias DualUsage = RequestUsage | ResponseUsage;

/** Error object returned in case of API failure. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model VoiceLiveErrorDetails {
  /** Error code, or null if unspecified. */
  code?: string;

  /** Human-readable error message. */
  message: string;

  /** Parameter name related to the error, if applicable. */
  param?: string;

  /** Type or category of the error. */
  type?: string;

  /** Event id of the error. */
  event_id?: string;
}

/** Standard error response envelope. */
@error
@usage(ResponseUsage)
model ErrorResponse {
  /** Error object returned in case of API failure. */
  error: VoiceLiveErrorDetails;
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

// Tool customization: Adjust union to be a discriminated type base
/** A voicelive client event. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@discriminator("type")
@usage(RequestUsage)
model ClientEvent {
  /** The type of event. */
  type: ClientEventType;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to update the session’s default configuration.
 * The client may send this event at any time to update any field,
 * except for `voice`. However, note that once a session has been
 * initialized with a particular `model`, it can’t be changed to
 * another model using `session.update`.
 * When the server receives a `session.update`, it will respond
 * with a `session.updated` event showing the full, effective configuration.
 * Only the fields that are present are updated. To clear a field like
 * `instructions`, pass an empty string.
 */
@usage(RequestUsage)
model ClientEventSessionUpdate extends ClientEvent {
  /** The event type, must be `session.update`. */
  type: ClientEventType.session_update;

  // Tool customization: apply enriched request-specific model
  session: RequestSession;
}

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
@usage(RequestUsage)
model ClientEventInputAudioTurnStart extends ClientEvent {
  /** The event type, must be 'input_audio.turn.start'. */
  type: ClientEventType.input_audio_turn_start;

  /** Unique identifier for the input audio turn. */
  turn_id: string;
}

/** Appends audio data to an ongoing input turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
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
@usage(RequestUsage)
model ClientEventInputAudioTurnEnd extends ClientEvent {
  /** The event type, must be 'input_audio.turn.end'. */
  type: ClientEventType.input_audio_turn_end;

  /** The ID of the audio turn being ended. */
  turn_id: string;
}

/** Cancels an in-progress input audio turn. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventInputAudioTurnCancel extends ClientEvent {
  /** The event type, must be 'input_audio.turn.cancel'. */
  type: ClientEventType.input_audio_turn_cancel;

  /** The ID of the turn to cancel. */
  turn_id: string;
}

/** Clears all input audio currently being streamed. */
@usage(RequestUsage)
model ClientEventInputAudioClear extends ClientEvent {
  /** The event type, must be 'input_audio.clear'. */
  type: ClientEventType.input_audio_clear;
}

// Tool customization: establish custom, enriched discriminated type hierarchy
/** The item to add to the conversation. */
@usage(RequestUsage)
model ConversationItemBase {
  /** Customized to enriched Conversation{Request,Response}Item models */
}

/** The response resource. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model Response {
  /** The unique ID of the response. */
  id?: string;

  /** The object type, must be `realtime.response`. */
  object?: "realtime.response";

  /**

   * The final status of the response.

   * One of: `completed`, `cancelled`, `failed`, `incomplete`, or `in_progress`.

   */
  status?: ResponseStatus;

  /** Additional details about the status. */
  status_details?: ResponseStatusDetails;

  // Tool customization: apply enriched response-specific type
  /** The list of output items generated by the response. */
  output?: ResponseItem[];

  /**
   * Usage statistics for the Response, this will correspond to billing. A
   * VoiceLive API session will maintain a conversation context and append new
   * Items to the Conversation, thus output from previous turns (text and
   * audio tokens) will become the input for later turns.
   */
  usage?: TokenUsage;

  /**
   * Which conversation the response is added to, determined by the `conversation`
   * field in the `response.create` event. If `auto`, the response will be added to
   * the default conversation and the value of `conversation_id` will be an id like
   * `conv_1234`. If `none`, the response will not be added to any conversation and
   * the value of `conversation_id` will be `null`. If responses are being triggered
   * by server VAD, the response will be added to the default conversation, thus
   * the `conversation_id` will be an id like `conv_1234`.
   */
  conversation_id?: string;

  /** supported voice identifiers and configurations. */
  voice?: Voice;

  /**
   * The set of modalities the model used to respond. If there are multiple modalities,
   * the model will pick one, for example if `modalities` is `["text", "audio"]`, the model
   * could be responding in either text or audio.
   */
  modalities?: Modality[];

  /** The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. */
  output_audio_format?: OutputAudioFormat = OutputAudioFormat.pcm16;

  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. */
  temperature?: float32;

  /**
   * Maximum number of output tokens for a single assistant response,
   * inclusive of tool calls, that was used in this response.
   */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This is how it's represented OpenAI Style."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  max_output_tokens?: int32 | "inf";

  /**
   * Set of up to 16 key-value pairs that can be attached to an object.
   * This can be useful for storing additional information about the object in a structured format.
   * Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.
   */
  metadata?: Record<string>;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to append audio bytes to the input audio buffer. The audio
 * buffer is temporary storage you can write to and later commit. In Server VAD
 * mode, the audio buffer is used to detect speech and the server will decide
 * when to commit. When Server VAD is disabled, you must commit the audio buffer
 * manually.
 *
 * The client may choose how much audio to place in each event up to a maximum
 * of 15 MiB, for example streaming smaller chunks from the client may allow the
 * VAD to be more responsive. Unlike made other client events, the server will
 * not send a confirmation response to this event.
 */
@usage(RequestUsage)
model ClientEventInputAudioBufferAppend extends ClientEvent {
  /** The event type, must be `input_audio_buffer.append`. */
  type: ClientEventType.input_audio_buffer_append;

  // Tool customization: use encoded type for audio data
  /**
   * Base64-encoded audio. This must be in the format specified by the
   * `input_audio_format` field in the session configuration.
   */
  audio: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to commit the user input audio buffer, which will create a
 * new user message item in the conversation. This event will produce an error
 * if the input audio buffer is empty. When in Server VAD mode, the client does
 * not need to send this event, the server will commit the audio buffer
 * automatically.
 * Committing the input audio buffer will trigger input audio transcription
 * (if enabled in session configuration), but it will not create a response
 * from the model. The server will respond with an `input_audio_buffer.committed`
 * event.
 */
model ClientEventInputAudioBufferCommit extends ClientEvent {
  /** The event type, must be `input_audio_buffer.commit`. */
  type: ClientEventType.input_audio_buffer_commit;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to clear the audio bytes in the buffer. The server will
 * respond with an `input_audio_buffer.cleared` event.
 */
model ClientEventInputAudioBufferClear extends ClientEvent {
  /** The event type, must be `input_audio_buffer.clear`. */
  type: ClientEventType.input_audio_buffer_clear;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Add a new Item to the Conversation's context, including messages, function
 * calls, and function call responses. This event can be used both to populate a
 * "history" of the conversation and to add new items mid-stream, but has the
 * current limitation that it cannot populate assistant audio messages.
 * If successful, the server will respond with a `conversation.item.created`
 * event, otherwise an `error` event will be sent.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
model ClientEventConversationItemCreate extends ClientEvent {
  /** The event type, must be `conversation.item.create`. */
  type: ClientEventType.conversation_item_create;

  /** Optional client-generated ID used to identify this event. */
  event_id?: string;

  /**
   * The ID of the preceding item after which the new item will be inserted.
   * If not set, the new item will be appended to the end of the conversation.
   * If set to `root`, the new item will be added to the beginning of the conversation.
   * If set to an existing ID, it allows an item to be inserted mid-conversation. If the
   * ID cannot be found, an error will be returned and the item will not be added.
   */
  previous_item_id?: string;

  // Tool customization: apply enriched item definition hierarchy
  item?: ConversationRequestItem;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to truncate a previous assistant message’s audio. The server
 * will produce audio faster than voicelive, so this event is useful when the user
 * interrupts to truncate audio that has already been sent to the client but not
 * yet played. This will synchronize the server's understanding of the audio with
 * the client's playback.
 * Truncating audio will delete the server-side text transcript to ensure there
 * is not text in the context that hasn't been heard by the user.
 * If successful, the server will respond with a `conversation.item.truncated`
 * event.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventConversationItemTruncate extends ClientEvent {
  /** The event type, must be `conversation.item.truncate`. */
  type: ClientEventType.conversation_item_truncate;

  /**
   * The ID of the assistant message item to truncate. Only assistant message
   * items can be truncated.
   */
  item_id: string;

  /** The index of the content part to truncate. Set this to 0. */
  content_index: int32;

  /**
   * Inclusive duration up to which audio is truncated, in milliseconds. If
   * the audio_end_ms is greater than the actual audio duration, the server
   * will respond with an error.
   */
  audio_end_ms: int32;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event when you want to remove any item from the conversation
 * history. The server will respond with a `conversation.item.deleted` event,
 * unless the item does not exist in the conversation history, in which case the
 * server will respond with an error.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventConversationItemDelete extends ClientEvent {
  /** The event type, must be `conversation.item.delete`. */
  type: ClientEventType.conversation_item_delete;

  /** The ID of the item to delete. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * This event instructs the server to create a Response, which means triggering
 * model inference. When in Server VAD mode, the server will create Responses
 * automatically.
 * A Response will include at least one Item, and may have two, in which case
 * the second will be a function call. These Items will be appended to the
 * conversation history.
 * The server will respond with a `response.created` event, events for Items
 * and content created, and finally a `response.done` event to indicate the
 * Response is complete.
 * The `response.create` event includes inference configuration like
 * `instructions`, and `temperature`. These fields will override the Session's
 * configuration for this Response only.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventResponseCreate extends ClientEvent {
  /** The event type, must be `response.create`. */
  type: ClientEventType.response_create;

  response?: ResponseCreateParams;

  /** additional instructions (system prompt) appended to the default instructions of the session. Only affects this response only. */
  additional_instructions?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event to cancel an in-progress response. The server will respond
 * with a `response.cancelled` event or an error if there is no response to
 * cancel.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventResponseCancel extends ClientEvent {
  /** The event type, must be `response.cancel`. */
  type: ClientEventType.response_cancel;

  /**
   * A specific response ID to cancel - if not provided, will cancel an
   * in-progress response in the default conversation.
   */
  response_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an error occurs, which could be a client problem or a server
 * problem. Most errors are recoverable and the session will stay open, we
 * recommend to implementors to monitor and log error messages by default.
 */
@usage(ResponseUsage)
model ServerEventError extends ServerEvent {
  /** The event type, must be `error`. */
  type: ServerEventType.error;

  /** Details of the error. */
  error: ServerEventErrorDetails;
}

/** Details of the error. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventErrorDetails {
  /** The type of error (e.g., "invalid_request_error", "server_error"). */
  type: string;

  /** Error code, if any. */
  code?: string;

  /** A human-readable error message. */
  message: string;

  /** Parameter related to the error, if any. */
  param?: string;

  /** The event_id of the client event that caused the error, if applicable. */
  event_id?: string;
}

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

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a Session is created. Emitted automatically when a new
 * connection is established as the first server event. This event will contain
 * the default Session configuration.
 */
@usage(ResponseUsage)
model ServerEventSessionCreated extends ServerEvent {
  /** The event type, must be `session.created`. */
  type: ServerEventType.session_created;

  // Tool customization: apply enriched response-specific model
  session: ResponseSession;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a session is updated with a `session.update` event, unless
 * there is an error.
 */
@usage(ResponseUsage)
model ServerEventSessionUpdated extends ServerEvent {
  /** The event type, must be `session.updated`. */
  type: ServerEventType.session_updated;

  // Tool customization: apply enriched response-specific model
  session: ResponseSession;
}

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

// Tool customization: Adjust union to be a discriminated type base
/** A voicelive server event. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@discriminator("type")
@usage(ResponseUsage)
model ServerEvent {
  /** The type of event. */
  type: ServerEventType;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an input audio buffer is committed, either by the client or
 * automatically in server VAD mode. The `item_id` property is the ID of the user
 * message item that will be created, thus a `conversation.item.created` event
 * will also be sent to the client.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventInputAudioBufferCommitted extends ServerEvent {
  /** The event type, must be `input_audio_buffer.committed`. */
  type: ServerEventType.input_audio_buffer_committed;

  /** The ID of the preceding item after which the new item will be inserted. */
  previous_item_id?: string;

  /** The ID of the user message item that will be created. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the input audio buffer is cleared by the client with a
 * `input_audio_buffer.clear` event.
 */
@usage(ResponseUsage)
model ServerEventInputAudioBufferCleared extends ServerEvent {
  /** The event type, must be `input_audio_buffer.cleared`. */
  type: ServerEventType.input_audio_buffer_cleared;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Sent by the server when in `server_vad` mode to indicate that speech has been
 * detected in the audio buffer. This can happen any time audio is added to the
 * buffer (unless speech is already detected). The client may want to use this
 * event to interrupt audio playback or provide visual feedback to the user.
 * The client should expect to receive a `input_audio_buffer.speech_stopped` event
 * when speech stops. The `item_id` property is the ID of the user message item
 * that will be created when speech stops and will also be included in the
 * `input_audio_buffer.speech_stopped` event (unless the client manually commits
 * the audio buffer during VAD activation).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventInputAudioBufferSpeechStarted extends ServerEvent {
  /** The event type, must be `input_audio_buffer.speech_started`. */
  type: ServerEventType.input_audio_buffer_speech_started;

  /**
   * Milliseconds from the start of all audio written to the buffer during the
   * session when speech was first detected. This will correspond to the
   * beginning of audio sent to the model, and thus includes the
   * `prefix_padding_ms` configured in the Session.
   */
  audio_start_ms: int32;

  /** The ID of the user message item that will be created when speech stops. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned in `server_vad` mode when the server detects the end of speech in
 * the audio buffer. The server will also send an `conversation.item.created`
 * event with the user message item that is created from the audio buffer.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventInputAudioBufferSpeechStopped extends ServerEvent {
  /** The event type, must be `input_audio_buffer.speech_stopped`. */
  type: ServerEventType.input_audio_buffer_speech_stopped;

  /**
   * Milliseconds since the session started when speech stopped. This will
   * correspond to the end of audio sent to the model, and thus includes the
   * `min_silence_duration_ms` configured in the Session.
   */
  audio_end_ms: int32;

  /** The ID of the user message item that will be created. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a conversation item is created. There are several scenarios that produce this event:
 * - The server is generating a Response, which if successful will produce
 * either one or two Items, which will be of type `message`
 * (role `assistant`) or type `function_call`.
 * - The input audio buffer has been committed, either by the client or the
 * server (in `server_vad` mode). The server will take the content of the
 * input audio buffer and add it to a new user message Item.
 * - The client has sent a `conversation.item.create` event to add a new Item
 * to the Conversation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemCreated extends ServerEvent {
  /** The event type, must be `conversation.item.created`. */
  type: ServerEventType.conversation_item_created;

  /**
   * The ID of the preceding item in the Conversation context, allows the
   * client to understand the order of the conversation.
   */
  previous_item_id?: string;

  // Tool customization: apply enriched item definition hierarchy
  item?: ResponseItem;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * This event is the output of audio transcription for user audio written to the
 * user audio buffer. Transcription begins when the input audio buffer is
 * committed by the client or server (in `server_vad` mode). Transcription runs
 * asynchronously with Response creation, so this event may come before or after
 * the Response events.
 * VoiceLive API models accept audio natively, and thus input transcription is a
 * separate process run on a separate ASR (Automatic Speech Recognition) model.
 * The transcript may diverge somewhat from the model's interpretation, and
 * should be treated as a rough guide.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemInputAudioTranscriptionCompleted
  extends ServerEvent {
  /**
   * The event type, must be
   * `conversation.item.input_audio_transcription.completed`.
   */
  type: ServerEventType.conversation_item_input_audio_transcription_completed;

  /** The ID of the user message item containing the audio. */
  item_id: string;

  /** The index of the content part containing the audio. */
  content_index: int32;

  /** The transcribed text. */
  transcript: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when input audio transcription is configured, and a transcription
 * request for a user message failed. These events are separate from other
 * `error` events so that the client can identify the related Item.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemInputAudioTranscriptionFailed
  extends ServerEvent {
  /**
   * The event type, must be
   * `conversation.item.input_audio_transcription.failed`.
   */
  type: ServerEventType.conversation_item_input_audio_transcription_failed;

  /** The ID of the user message item. */
  item_id: string;

  /** The index of the content part containing the audio. */
  content_index: int32;

  /** Details of the transcription error. */
  error: VoiceLiveErrorDetails;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an earlier assistant audio message item is truncated by the
 * client with a `conversation.item.truncate` event. This event is used to
 * synchronize the server's understanding of the audio with the client's playback.
 * This action will truncate the audio and remove the server-side text transcript
 * to ensure there is no text in the context that hasn't been heard by the user.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemTruncated extends ServerEvent {
  /** The event type, must be `conversation.item.truncated`. */
  type: ServerEventType.conversation_item_truncated;

  /** The ID of the assistant message item that was truncated. */
  item_id: string;

  /** The index of the content part that was truncated. */
  content_index: int32;

  /** The duration up to which the audio was truncated, in milliseconds. */
  audio_end_ms: int32;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an item in the conversation is deleted by the client with a
 * `conversation.item.delete` event. This event is used to synchronize the
 * server's understanding of the conversation history with the client's view.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemDeleted extends ServerEvent {
  /** The event type, must be `conversation.item.deleted`. */
  type: ServerEventType.conversation_item_deleted;

  /** The ID of the item that was deleted. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a new Response is created. The first event of response creation,
 * where the response is in an initial state of `in_progress`.
 */
@usage(ResponseUsage)
model ServerEventResponseCreated extends ServerEvent {
  /** The event type, must be `response.created`. */
  type: ServerEventType.response_created;

  response: Response;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a Response is done streaming. Always emitted, no matter the
 * final state. The Response object included in the `response.done` event will
 * include all output Items in the Response but will omit the raw audio data.
 */
@usage(ResponseUsage)
model ServerEventResponseDone extends ServerEvent {
  /** The event type, must be `response.done`. */
  type: ServerEventType.response_done;

  response: Response;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when a new Item is created during Response generation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseOutputItemAdded extends ServerEvent {
  /** The event type, must be `response.output_item.added`. */
  type: ServerEventType.response_output_item_added;

  /** The ID of the Response to which the item belongs. */
  response_id: string;

  /** The index of the output item in the Response. */
  output_index: int32;

  // Tool customization: apply enriched item definition hierarchy
  item?: ResponseItem;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an Item is done streaming. Also emitted when a Response is
 * interrupted, incomplete, or cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseOutputItemDone extends ServerEvent {
  /** The event type, must be `response.output_item.done`. */
  type: ServerEventType.response_output_item_done;

  /** The ID of the Response to which the item belongs. */
  response_id: string;

  /** The index of the output item in the Response. */
  output_index: int32;

  // Tool customization: apply enriched item definition hierarchy
  item?: ResponseItem;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a new content part is added to an assistant message item during
 * response generation.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseContentPartAdded extends ServerEvent {
  /** The event type, must be `response.content_part.added`. */
  type: ServerEventType.response_content_part_added;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item to which the content part was added. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  // Tool customization: apply detailed content part type
  /** The content part that was added. */
  part: ContentPart;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a content part is done streaming in an assistant message item.
 * Also emitted when a Response is interrupted, incomplete, or cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseContentPartDone extends ServerEvent {
  /** The event type, must be `response.content_part.done`. */
  type: ServerEventType.response_content_part_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  // Tool customization: apply detailed content part type
  /** The content part that is done. */
  part: ContentPart;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the text value of a "text" content part is updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseTextDelta extends ServerEvent {
  /** The event type, must be `response.text.delta`. */
  type: ServerEventType.response_text_delta;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  /** The text delta. */
  delta: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the text value of a "text" content part is done streaming. Also
 * emitted when a Response is interrupted, incomplete, or cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseTextDone extends ServerEvent {
  /** The event type, must be `response.text.done`. */
  type: ServerEventType.response_text_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  /** The final text content. */
  text: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the model-generated transcription of audio output is updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioTranscriptDelta extends ServerEvent {
  /** The event type, must be `response.audio_transcript.delta`. */
  type: ServerEventType.response_audio_transcript_delta;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  /** The transcript delta. */
  delta: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the model-generated transcription of audio output is done
 * streaming. Also emitted when a Response is interrupted, incomplete, or
 * cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioTranscriptDone extends ServerEvent {
  /** The event type, must be `response.audio_transcript.done`. */
  type: ServerEventType.response_audio_transcript_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  /** The final transcript of the audio. */
  transcript: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the model-generated audio is updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioDelta extends ServerEvent {
  /** The event type, must be `response.audio.delta`. */
  type: ServerEventType.response_audio_delta;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;

  // Tool customization: use encoded type for audio data
  /** Base64-encoded audio data delta. */
  // @encode(BytesKnownEncoding.base64)
  delta: bytes;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the model-generated audio is done. Also emitted when a Response
 * is interrupted, incomplete, or cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseAudioDone extends ServerEvent {
  /** The event type, must be `response.audio.done`. */
  type: ServerEventType.response_audio_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;
}

/** Represents a delta update of blendshape animation frames for a specific output of a response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
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
@usage(ResponseUsage)
model ServerEventResponseAnimationVisemeDone extends ServerEvent {
  type: ServerEventType.response_animation_viseme_done;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/** Create a new VoiceLive response with these parameters */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ResponseCreateParams {
  /** Whether to commit the response to the conversation. Defaults to true. */
  commit?: boolean = true;

  /** Whether to cancel any ongoing generation before starting this one. Defaults to true. */
  cancel_previous?: boolean = true;

  /** Input items to append to the conversation context before generating a response. */
  append_input_items?: ConversationRequestItem[];

  /**
   * Input items to be used as the context for this response.
   * An empty array clears previous context.
   */
  input_items?: ConversationRequestItem[];

  // Tool customization: Apply reusable modality representation
  /**
   * The set of modalities the model can respond with. To disable audio,
   * set this to ["text"].
   */
  modalities?: Modality[];

  /**
   * The default system instructions (i.e. system message) prepended to model
   * calls. This field allows the client to guide the model on desired
   * responses. The model can be instructed on response content and format,
   * (e.g. "be extremely succinct", "act friendly", "here are examples of good
   * responses") and on audio behavior (e.g. "talk quickly", "inject emotion
   * into your voice", "laugh frequently"). The instructions are not guaranteed
   * to be followed by the model, but they provide guidance to the model on the
   * desired behavior.
   *
   * Note that the server sets default instructions which will be used if this
   * field is not set and are visible in the `session.created` event at the
   * start of the session.
   */
  instructions?: string;

  /** supported voice identifiers and configurations. */
  voice?: Voice;

  // Tool customization: use extracted and reusable audio format definition
  /** The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`. */
  output_audio_format?: OutputAudioFormat = OutputAudioFormat.pcm16;

  // Tool customization: use enriched tool definition
  /** Tools (functions) available to the model. */
  tools?: Tool[];

  /**
   * How the model chooses tools. Options are `auto`, `none`, `required`, or
   * specify a function, like `{"type": "function", "function": {"name": "my_function"}}`.
   */
  tool_choice?: string;

  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. */
  temperature?: float32;

  // Tool customization: Address (observed as of 2025-01-31) spec issue with 'max_response_output_tokens'
  /**
   * Maximum number of output tokens for a single assistant response,
   * inclusive of tool calls. Provide an integer between 1 and 4096 to
   * limit output tokens, or `inf` for the maximum available tokens for a
   * given model. Defaults to `inf`.
   */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "This is how it's represented OpenAI Style."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  max_output_tokens?: int32 | "inf";

  /** Create the response with pre-generated assistant message. The message item would be
   * added into the conversation history and returned with synthesized audio output in the created response.
   */
  pre_generated_assistant_message?: AssistantMessageItem;

  /**
   * Constrains effort on reasoning for reasoning models. Check model documentation for supported values for each model.
   * Reducing reasoning effort can result in faster responses and fewer tokens used on reasoning in a response.
   */
  reasoning_effort?: ReasoningEffort;

  /**
   * Set of up to 16 key-value pairs that can be attached to an object.
   * This can be useful for storing additional information about the object in a structured format.
   * Keys can be a maximum of 64 characters long and values can be a maximum of 512 characters long.
   */
  metadata?: Record<string>;
}

// Tool customization (apply_discriminator): apply discriminated type base
/**
 * Send this event when you want to retrieve the server's representation of a specific item in the conversation history. This is useful, for example, to inspect user audio after noise cancellation and VAD.
 * The server will respond with a `conversation.item.retrieved` event,
 * unless the item does not exist in the conversation history, in which case the
 * server will respond with an error.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model ClientEventConversationItemRetrieve extends ClientEvent {
  /** The event type, must be `conversation.item.retrieve`. */
  type: ClientEventType.conversation_item_retrieve;

  /** The ID of the item to retrieve. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the text value of an input audio transcription content part is updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemInputAudioTranscriptionDelta
  extends ServerEvent {
  /** The event type, must be `conversation.item.input_audio_transcription.delta`. */
  type: ServerEventType.conversation_item_input_audio_transcription_delta;

  /** The ID of the item. */
  item_id: string;

  /** The index of the content part in the item's content array. */
  content_index?: int32;

  /** The text delta. */
  delta?: string;

  /** The log probabilities of the transcription. */
  logprobs?: LogProbProperties[];
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when a conversation item is retrieved with `conversation.item.retrieve`. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventConversationItemRetrieved extends ServerEvent {
  /** The event type, must be `conversation.item.retrieved`. */
  type: ServerEventType.conversation_item_retrieved;

  // Tool customization: apply enriched item definition hierarchy
  item?: ResponseItem;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the model-generated function call arguments are updated. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFunctionCallArgumentsDelta extends ServerEvent {
  /** The event type, must be `response.function_call_arguments.delta`. */
  type: ServerEventType.response_function_call_arguments_delta;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the function call item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The ID of the function call. */
  call_id: string;

  /** The arguments delta as a JSON string. */
  delta: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the model-generated function call arguments are done streaming.
 * Also emitted when a Response is interrupted, incomplete, or cancelled.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFunctionCallArgumentsDone extends ServerEvent {
  /** The event type, must be `response.function_call_arguments.done`. */
  type: ServerEventType.response_function_call_arguments_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the function call item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The ID of the function call. */
  call_id: string;

  /** The final arguments as a JSON string. */
  arguments: string;

  /** The name of the function call. */
  name: string;
}

/** MCP list tools in progress message. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@usage(ResponseUsage)
model ServerEventMcpListToolsInProgress extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.mcp_list_tools_in_progress;

  /** The item ID. */
  item_id: string;
}

/** MCP list tools completed message. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@usage(ResponseUsage)
model ServerEventMcpListToolsCompleted extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.mcp_list_tools_completed;

  /** The item ID. */
  item_id: string;
}

/** MCP list tools failed message. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@usage(ResponseUsage)
model ServerEventMcpListToolsFailed extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.mcp_list_tools_failed;

  /** The item ID. */
  item_id: string;
}

/** Represents a delta update of the arguments for an MCP tool call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseMcpCallArgumentsDelta extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_mcp_call_arguments_delta;

  /** The delta of the arguments. */
  delta: string;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The ID of the response associated with the event. */
  response_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;

  /** The obfuscation of the arguments. */
  obfuscation?: string;
}

/** Indicates the completion of the arguments for an MCP tool call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseMcpCallArgumentsDone extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_mcp_call_arguments_done;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The ID of the response associated with the event. */
  response_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;

  /** The full arguments for the tool call. */
  arguments?: string;
}

/** Indicates the MCP call running. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseMcpCallInProgress extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_mcp_call_in_progress;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}

/** Indicates the MCP call has completed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseMcpCallCompleted extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_mcp_call_completed;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}

/** Indicates the MCP call has failed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseMcpCallFailed extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_mcp_call_failed;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}

/** Represents a delta update of the arguments for a Foundry agent call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFoundryAgentCallArgumentsDelta extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_foundry_agent_call_arguments_delta;

  /** The delta of the arguments. */
  delta: string;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The ID of the response associated with the event. */
  response_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}

/** Indicates the completion of the arguments for a Foundry agent call. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFoundryAgentCallArgumentsDone extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_foundry_agent_call_arguments_done;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The ID of the response associated with the event. */
  response_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;

  /** The full arguments for the agent call. */
  arguments?: string;
}

/** Indicates the Foundry agent call is in progress. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFoundryAgentCallInProgress extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_foundry_agent_call_in_progress;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;

  /** The ID of the agent response, if any. */
  agent_response_id?: string;
}

/** Indicates the Foundry agent call has completed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFoundryAgentCallCompleted extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_foundry_agent_call_completed;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}

/** Indicates the Foundry agent call has failed. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ServerEventResponseFoundryAgentCallFailed extends ServerEvent {
  /** @inheritdoc */
  type: ServerEventType.response_foundry_agent_call_failed;

  /** The ID of the item associated with the event. */
  item_id: string;

  /** The index of the output associated with the event. */
  output_index: int32;
}
