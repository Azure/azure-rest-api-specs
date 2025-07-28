/*
 * This file was automatically generated from an OpenAPI .yaml file.
 * Edits made directly to this file will be lost.
 */

import "./client.tsp";
import "./common";
import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;


// Tool customization: Adjust union to be a discriminated type base
/** A voicelive client event. */
@discriminator("type")
model VoiceLiveClientEvent {
  /** The type of event. */
  type: VoiceLiveClientEventType;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event to update the session’s default configuration.
  The client may send this event at any time to update any field,
  except for `voice`. However, note that once a session has been
  initialized with a particular `model`, it can’t be changed to
  another model using `session.update`.
  
  When the server receives a `session.update`, it will respond
  with a `session.updated` event showing the full, effective configuration.
  Only the fields that are present are updated. To clear a field like
  `instructions`, pass an empty string.
  """)
model VoiceLiveClientEventSessionUpdate extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `session.update`.
    """)
  type: VoiceLiveClientEventType.session_update;

  // Tool customization: apply enriched request-specific model
  session: VoiceLiveRequestSession;
}

@doc("""
  Sent when the client connects and provides its SDP (Session Description Protocol)
  for avatar-related media negotiation.
""")
model VoiceLiveClientEventSessionAvatarConnect extends VoiceLiveClientEvent {
  @doc("The event type, must be 'session.avatar.connect'.")
  type: VoiceLiveClientEventType.session_avatar_connect;

  @doc("The client's SDP offer.")
  client_sdp: string;
}

@doc("""
  Indicates the start of a new audio input turn.
""")
model VoiceLiveClientEventInputAudioTurnStart extends VoiceLiveClientEvent {
  @doc("The event type, must be 'input_audio.turn.start'.")
  type: VoiceLiveClientEventType.input_audio_turn_start;

  @doc("Unique identifier for the input audio turn.")
  turn_id: string;
}

@doc("""
  Appends audio data to an ongoing input turn.
""")
model VoiceLiveClientEventInputAudioTurnAppend extends VoiceLiveClientEvent {
  @doc("The event type, must be 'input_audio.turn.append'.")
  type: VoiceLiveClientEventType.input_audio_turn_append;

  @doc("The ID of the turn this audio is part of.")
  turn_id: string;

  @doc("Base64-encoded audio chunk.")
  audio: string;
}

@doc("""
  Marks the end of an audio input turn.
""")
model VoiceLiveClientEventInputAudioTurnEnd extends VoiceLiveClientEvent {
  @doc("The event type, must be 'input_audio.turn.end'.")
  type: VoiceLiveClientEventType.input_audio_turn_end;

  @doc("The ID of the audio turn being ended.")
  turn_id: string;
}

@doc("""
  Cancels an in-progress input audio turn.
""")
model VoiceLiveClientEventInputAudioTurnCancel extends VoiceLiveClientEvent {
  @doc("The event type, must be 'input_audio.turn.cancel'.")
  type: VoiceLiveClientEventType.input_audio_turn_cancel;

  @doc("The ID of the turn to cancel.")
  turn_id: string;
}

@doc("""
  Clears all input audio currently being streamed.
""")
model VoiceLiveClientEventInputAudioClear extends VoiceLiveClientEvent {
  @doc("The event type, must be 'input_audio.clear'.")
  type: VoiceLiveClientEventType.input_audio_clear;
}

// Tool customization: establish custom, enriched discriminated type hierarchy
/** The item to add to the conversation. */
model VoiceLiveConversationItemBase {
  /** Customized to enriched VoiceLiveConversation{Request,Response}Item models */
}

/** The response resource. */
model VoiceLiveResponse {
  /** The unique ID of the response. */
  id?: string;

  @doc("""
    The object type, must be `realtime.response`.
    """)
  object?: "realtime.response";

  @doc("""
    The final status of the response (`completed`, `cancelled`, `failed`, or
    `incomplete`).
    """)
  status?: "completed" | "cancelled" | "failed" | "incomplete" | "in_progress";

  /** Additional details about the status. */
  status_details?: {
    @doc("""
      The type of error that caused the response to fail, corresponding
      with the `status` field (`completed`, `cancelled`, `incomplete`,
      `failed`).
      """)
    type?: "completed" | "cancelled" | "failed" | "incomplete";

    @doc("""
      The reason the Response did not complete. For a `cancelled` Response,
      one of `turn_detected` (the server VAD detected a new start of speech)
      or `client_cancelled` (the client sent a cancel event). For an
      `incomplete` Response, one of `max_output_tokens` or `content_filter`
      (the server-side safety filter activated and cut off the response).
      """)
    reason?:
      | "turn_detected"
      | "client_cancelled"
      | "max_output_tokens"
      | "content_filter";

    @doc("""
      A description of the error that caused the response to fail,
      populated when the `status` is `failed`.
      """)
    error?: {
      /** The type of error. */
      type?: string;

      /** Error code, if any. */
      code?: string;
    };
  };

  // Tool customization: apply enriched response-specific type
  /** The list of output items generated by the response. */
  output?: VoiceLiveConversationResponseItem[];

  /**
   * Usage statistics for the Response, this will correspond to billing. A
   * VoiceLive API session will maintain a conversation context and append new
   * Items to the Conversation, thus output from previous turns (text and
   * audio tokens) will become the input for later turns.
   */
  usage?: {
    /**
     * The total number of tokens in the Response including input and output
     * text and audio tokens.
     */
    total_tokens?: int32;

    /**
     * The number of input tokens used in the Response, including text and
     * audio tokens.
     */
    input_tokens?: int32;

    /**
     * The number of output tokens sent in the Response, including text and
     * audio tokens.
     */
    output_tokens?: int32;

    /** Details about the input tokens used in the Response. */
    input_token_details?: {
      /** The number of cached tokens used in the Response. */
      cached_tokens?: int32;

      /** The number of text tokens used in the Response. */
      text_tokens?: int32;

      /** The number of audio tokens used in the Response. */
      audio_tokens?: int32;
    };

    /** Details about the output tokens used in the Response. */
    output_token_details?: {
      /** The number of text tokens used in the Response. */
      text_tokens?: int32;

      /** The number of audio tokens used in the Response. */
      audio_tokens?: int32;
    };
  };

  @doc("""
    Which conversation the response is added to, determined by the `conversation`
    field in the `response.create` event. If `auto`, the response will be added to
    the default conversation and the value of `conversation_id` will be an id like
    `conv_1234`. If `none`, the response will not be added to any conversation and
    the value of `conversation_id` will be `null`. If responses are being triggered
    by server VAD, the response will be added to the default conversation, thus
    the `conversation_id` will be an id like `conv_1234`.
    """)
  conversation_id?: string;

  @doc("""
    supported voice identifiers and configurations.
    """)
  voice?: Voice;

  @doc("""
    The set of modalities the model used to respond. If there are multiple modalities,
    the model will pick one, for example if `modalities` is `["text", "audio"]`, the model
    could be responding in either text or audio.
    """)
  modalities?: ("text" | "audio")[];

  @doc("""
    The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
    """)
  output_audio_format?: "pcm16" | "g711_ulaw" | "g711_alaw";

  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. */
  temperature?: float32;

  /**
   * Maximum number of output tokens for a single assistant response,
   * inclusive of tool calls, that was used in this response.
   */
  max_output_tokens?: int32 | "inf";
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
model VoiceLiveClientEventInputAudioBufferAppend extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `input_audio_buffer.append`.
    """)
  type: VoiceLiveClientEventType.input_audio_buffer_append;

  // Tool customization: use encoded type for audio data
  @doc("""
    Base64-encoded audio. This must be in the format specified by the
    `input_audio_format` field in the session configuration.
    """)
  audio: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event to commit the user input audio buffer, which will create a
  new user message item in the conversation. This event will produce an error
  if the input audio buffer is empty. When in Server VAD mode, the client does
  not need to send this event, the server will commit the audio buffer
  automatically.
  
  Committing the input audio buffer will trigger input audio transcription
  (if enabled in session configuration), but it will not create a response
  from the model. The server will respond with an `input_audio_buffer.committed`
  event.
  """)
model VoiceLiveClientEventInputAudioBufferCommit extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `input_audio_buffer.commit`.
    """)
  type: VoiceLiveClientEventType.input_audio_buffer_commit;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event to clear the audio bytes in the buffer. The server will
  respond with an `input_audio_buffer.cleared` event.
  """)
model VoiceLiveClientEventInputAudioBufferClear extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `input_audio_buffer.clear`.
    """)
  type: VoiceLiveClientEventType.input_audio_buffer_clear;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Add a new Item to the Conversation's context, including messages, function
  calls, and function call responses. This event can be used both to populate a
  "history" of the conversation and to add new items mid-stream, but has the
  current limitation that it cannot populate assistant audio messages.
  
  If successful, the server will respond with a `conversation.item.created`
  event, otherwise an `error` event will be sent.
  """)
model VoiceLiveClientEventConversationItemCreate extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `conversation.item.create`.
    """)
  type: VoiceLiveClientEventType.conversation_item_create;

  @doc("""
    Optional client-generated ID used to identify this event.
    """)
  event_id?: string;

  @doc("""
    The ID of the preceding item after which the new item will be inserted.
    If not set, the new item will be appended to the end of the conversation.
    If set to `root`, the new item will be added to the beginning of the conversation.
    If set to an existing ID, it allows an item to be inserted mid-conversation. If the
    ID cannot be found, an error will be returned and the item will not be added.
    """)
  previous_item_id?: string;

  // Tool customization: apply enriched item definition hierarchy
  item?: VoiceLiveConversationItemWithReference;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event to truncate a previous assistant message’s audio. The server
  will produce audio faster than voicelive, so this event is useful when the user
  interrupts to truncate audio that has already been sent to the client but not
  yet played. This will synchronize the server's understanding of the audio with
  the client's playback.
  
  Truncating audio will delete the server-side text transcript to ensure there
  is not text in the context that hasn't been heard by the user.
  
  If successful, the server will respond with a `conversation.item.truncated`
  event.
  """)
model VoiceLiveClientEventConversationItemTruncate extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `conversation.item.truncate`.
    """)
  type: VoiceLiveClientEventType.conversation_item_truncate;

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
@doc("""
  Send this event when you want to remove any item from the conversation
  history. The server will respond with a `conversation.item.deleted` event,
  unless the item does not exist in the conversation history, in which case the
  server will respond with an error.
  """)
model VoiceLiveClientEventConversationItemDelete extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `conversation.item.delete`.
    """)
  type: VoiceLiveClientEventType.conversation_item_delete;

  /** The ID of the item to delete. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  This event instructs the server to create a Response, which means triggering
  model inference. When in Server VAD mode, the server will create Responses
  automatically.
  
  A Response will include at least one Item, and may have two, in which case
  the second will be a function call. These Items will be appended to the
  conversation history.
  
  The server will respond with a `response.created` event, events for Items
  and content created, and finally a `response.done` event to indicate the
  Response is complete.
  
  The `response.create` event includes inference configuration like
  `instructions`, and `temperature`. These fields will override the Session's
  configuration for this Response only.
  """)
model VoiceLiveClientEventResponseCreate extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `response.create`.
    """)
  type: VoiceLiveClientEventType.response_create;

  response?: VoiceLiveResponseCreateParams;

  @doc("""
    additional instructions (system prompt) appended to the default instructions of the session. Only affects this response only.
    """)
  additional_instructions?: string
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event to cancel an in-progress response. The server will respond
  with a `response.cancelled` event or an error if there is no response to
  cancel.
  """)
model VoiceLiveClientEventResponseCancel extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `response.cancel`.
    """)
  type: VoiceLiveClientEventType.response_cancel;

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
model VoiceLiveServerEventError extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `error`.
    """)
  type: VoiceLiveServerEventType.error;

  /** Details of the error. */
  error: {
    /** The type of error (e.g., "invalid_request_error", "server_error"). */
    type: string;

    /** Error code, if any. */
    code?: string | null;

    /** A human-readable error message. */
    message: string;

    /** Parameter related to the error, if any. */
    param?: string | null;

    /** The event_id of the client event that caused the error, if applicable. */
    event_id?: string | null;
  };
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a Session is created. Emitted automatically when a new
 * connection is established as the first server event. This event will contain
 * the default Session configuration.
 */
model VoiceLiveServerEventSessionCreated extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `session.created`.
    """)
  type: VoiceLiveServerEventType.session_created;

  // Tool customization: apply enriched response-specific model
  session: VoiceLiveResponseSession;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when a session is updated with a `session.update` event, unless
  there is an error.
  """)
model VoiceLiveServerEventSessionUpdated extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `session.updated`.
    """)
  type: VoiceLiveServerEventType.session_updated;

  // Tool customization: apply enriched response-specific model
  session: VoiceLiveResponseSession;
}

@doc("Sent when the server is in the process of establishing an avatar media connection and provides its SDP answer.")
model VoiceLiveServerEventSessionAvatarConnecting extends VoiceLiveServerEvent {
  @doc("The event type, must be 'session.avatar.connecting'.")
  type: VoiceLiveServerEventType.session_avatar_connecting;

  @doc("The server's SDP answer for the avatar connection.")
  server_sdp: string;
}

// Tool customization: establish base for enriched request/response split models
/** VoiceLive session object configuration. */
model VoiceLiveSessionBase {}

// Tool customization: Adjust union to be a discriminated type base
/** A voicelive server event. */
@discriminator("type")
model VoiceLiveServerEvent {
  /** The type of event. */
  type: VoiceLiveServerEventType;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when an input audio buffer is committed, either by the client or
  automatically in server VAD mode. The `item_id` property is the ID of the user
  message item that will be created, thus a `conversation.item.created` event
  will also be sent to the client.
  """)
model VoiceLiveServerEventInputAudioBufferCommitted extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `input_audio_buffer.committed`.
    """)
  type: VoiceLiveServerEventType.input_audio_buffer_committed;

  /** The ID of the preceding item after which the new item will be inserted. */
  previous_item_id?: string;

  /** The ID of the user message item that will be created. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when the input audio buffer is cleared by the client with a
  `input_audio_buffer.clear` event.
  """)
model VoiceLiveServerEventInputAudioBufferCleared extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `input_audio_buffer.cleared`.
    """)
  type: VoiceLiveServerEventType.input_audio_buffer_cleared;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Sent by the server when in `server_vad` mode to indicate that speech has been
  detected in the audio buffer. This can happen any time audio is added to the
  buffer (unless speech is already detected). The client may want to use this
  event to interrupt audio playback or provide visual feedback to the user.
  
  The client should expect to receive a `input_audio_buffer.speech_stopped` event
  when speech stops. The `item_id` property is the ID of the user message item
  that will be created when speech stops and will also be included in the
  `input_audio_buffer.speech_stopped` event (unless the client manually commits
  the audio buffer during VAD activation).
  """)
model VoiceLiveServerEventInputAudioBufferSpeechStarted
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `input_audio_buffer.speech_started`.
    """)
  type: VoiceLiveServerEventType.input_audio_buffer_speech_started;

  @doc("""
    Milliseconds from the start of all audio written to the buffer during the
    session when speech was first detected. This will correspond to the
    beginning of audio sent to the model, and thus includes the
    `prefix_padding_ms` configured in the Session.
    """)
  audio_start_ms: int32;

  /** The ID of the user message item that will be created when speech stops. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned in `server_vad` mode when the server detects the end of speech in
  the audio buffer. The server will also send an `conversation.item.created`
  event with the user message item that is created from the audio buffer.
  """)
model VoiceLiveServerEventInputAudioBufferSpeechStopped
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `input_audio_buffer.speech_stopped`.
    """)
  type: VoiceLiveServerEventType.input_audio_buffer_speech_stopped;

  @doc("""
    Milliseconds since the session started when speech stopped. This will
    correspond to the end of audio sent to the model, and thus includes the
    `min_silence_duration_ms` configured in the Session.
    """)
  audio_end_ms: int32;

  /** The ID of the user message item that will be created. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when a conversation item is created. There are several scenarios that produce this event:
    - The server is generating a Response, which if successful will produce
      either one or two Items, which will be of type `message`
      (role `assistant`) or type `function_call`.
    - The input audio buffer has been committed, either by the client or the
      server (in `server_vad` mode). The server will take the content of the
      input audio buffer and add it to a new user message Item.
    - The client has sent a `conversation.item.create` event to add a new Item
      to the Conversation.
  """)
model VoiceLiveServerEventConversationItemCreated extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `conversation.item.created`.
    """)
  type: VoiceLiveServerEventType.conversation_item_created;

  /**
   * The ID of the preceding item in the Conversation context, allows the
   * client to understand the order of the conversation.
   */
  previous_item_id: string;

  // Tool customization: apply enriched item definition hierarchy
  item?: VoiceLiveConversationItemWithReference;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  This event is the output of audio transcription for user audio written to the
  user audio buffer. Transcription begins when the input audio buffer is
  committed by the client or server (in `server_vad` mode). Transcription runs
  asynchronously with Response creation, so this event may come before or after
  the Response events.
  
  VoiceLive API models accept audio natively, and thus input transcription is a
  separate process run on a separate ASR (Automatic Speech Recognition) model.
  The transcript may diverge somewhat from the model's interpretation, and
  should be treated as a rough guide.
  """)
model VoiceLiveServerEventConversationItemInputAudioTranscriptionCompleted
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be
    `conversation.item.input_audio_transcription.completed`.
    """)
  type: VoiceLiveServerEventType.conversation_item_input_audio_transcription_completed;

  /** The ID of the user message item containing the audio. */
  item_id: string;

  /** The index of the content part containing the audio. */
  content_index: int32;

  /** The transcribed text. */
  transcript: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when input audio transcription is configured, and a transcription
  request for a user message failed. These events are separate from other
  `error` events so that the client can identify the related Item.
  """)
model VoiceLiveServerEventConversationItemInputAudioTranscriptionFailed
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be
    `conversation.item.input_audio_transcription.failed`.
    """)
  type: VoiceLiveServerEventType.conversation_item_input_audio_transcription_failed;

  /** The ID of the user message item. */
  item_id: string;

  /** The index of the content part containing the audio. */
  content_index: int32;

  /** Details of the transcription error. */
  error: ErrorDetails;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when an earlier assistant audio message item is truncated by the
  client with a `conversation.item.truncate` event. This event is used to
  synchronize the server's understanding of the audio with the client's playback.
  
  This action will truncate the audio and remove the server-side text transcript
  to ensure there is no text in the context that hasn't been heard by the user.
  """)
model VoiceLiveServerEventConversationItemTruncated extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `conversation.item.truncated`.
    """)
  type: VoiceLiveServerEventType.conversation_item_truncated;

  /** The ID of the assistant message item that was truncated. */
  item_id: string;

  /** The index of the content part that was truncated. */
  content_index: int32;

  /** The duration up to which the audio was truncated, in milliseconds. */
  audio_end_ms: int32;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when an item in the conversation is deleted by the client with a
  `conversation.item.delete` event. This event is used to synchronize the
  server's understanding of the conversation history with the client's view.
  """)
model VoiceLiveServerEventConversationItemDeleted extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `conversation.item.deleted`.
    """)
  type: VoiceLiveServerEventType.conversation_item_deleted;

  /** The ID of the item that was deleted. */
  item_id: string;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when a new Response is created. The first event of response creation,
  where the response is in an initial state of `in_progress`.
  """)
model VoiceLiveServerEventResponseCreated extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.created`.
    """)
  type: VoiceLiveServerEventType.response_created;

  response: VoiceLiveResponse;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when a Response is done streaming. Always emitted, no matter the
  final state. The Response object included in the `response.done` event will
  include all output Items in the Response but will omit the raw audio data.
  """)
model VoiceLiveServerEventResponseDone extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.done`.
    """)
  type: VoiceLiveServerEventType.response_done;

  response: VoiceLiveResponse;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when a new Item is created during Response generation. */
model VoiceLiveServerEventResponseOutputItemAdded extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.output_item.added`.
    """)
  type: VoiceLiveServerEventType.response_output_item_added;

  /** The ID of the Response to which the item belongs. */
  response_id: string;

  /** The index of the output item in the Response. */
  output_index: int32;

  // Tool customization: apply enriched item definition hierarchy
  item?: VoiceLiveConversationItemWithReference;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when an Item is done streaming. Also emitted when a Response is
 * interrupted, incomplete, or cancelled.
 */
model VoiceLiveServerEventResponseOutputItemDone extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.output_item.done`.
    """)
  type: VoiceLiveServerEventType.response_output_item_done;

  /** The ID of the Response to which the item belongs. */
  response_id: string;

  /** The index of the output item in the Response. */
  output_index: int32;

  // Tool customization: apply enriched item definition hierarchy
  item?: VoiceLiveConversationResponseItem;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a new content part is added to an assistant message item during
 * response generation.
 */
model VoiceLiveServerEventResponseContentPartAdded extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.content_part.added`.
    """)
  type: VoiceLiveServerEventType.response_content_part_added;

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
  part: VoiceLiveContentPart;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when a content part is done streaming in an assistant message item.
 * Also emitted when a Response is interrupted, incomplete, or cancelled.
 */
model VoiceLiveServerEventResponseContentPartDone extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.content_part.done`.
    """)
  type: VoiceLiveServerEventType.response_content_part_done;

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
  part: VoiceLiveContentPart;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the text value of a "text" content part is updated. */
model VoiceLiveServerEventResponseTextDelta extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.text.delta`.
    """)
  type: VoiceLiveServerEventType.response_text_delta;

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
model VoiceLiveServerEventResponseTextDone extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.text.done`.
    """)
  type: VoiceLiveServerEventType.response_text_done;

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
model VoiceLiveServerEventResponseAudioTranscriptDelta
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.audio_transcript.delta`.
    """)
  type: VoiceLiveServerEventType.response_audio_transcript_delta;

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
model VoiceLiveServerEventResponseAudioTranscriptDone
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.audio_transcript.done`.
    """)
  type: VoiceLiveServerEventType.response_audio_transcript_done;

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
model VoiceLiveServerEventResponseAudioDelta extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.audio.delta`.
    """)
  type: VoiceLiveServerEventType.response_audio_delta;

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
  @encode("base64")
  delta: bytes;

  event_id?: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/**
 * Returned when the model-generated audio is done. Also emitted when a Response
 * is interrupted, incomplete, or cancelled.
 */
model VoiceLiveServerEventResponseAudioDone extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `response.audio.done`.
    """)
  type: VoiceLiveServerEventType.response_audio_done;

  /** The ID of the response. */
  response_id: string;

  /** The ID of the item. */
  item_id: string;

  /** The index of the output item in the response. */
  output_index: int32;

  /** The index of the content part in the item's content array. */
  content_index: int32;
}

@doc("""
Represents a delta update of blendshape animation frames for a specific output of a response.
""")
model ResponseAnimationBlendshapeDeltaEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_animation_blendshapes_delta;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  frames: float32[][] | string;
  frame_index: int32;
}

@doc("""
Indicates the completion of blendshape animation processing for a specific output of a response.
""")
model ResponseAnimationBlendshapeDoneEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_animation_blendshapes_done;
  response_id: string;
  item_id: string;
  output_index: int32;
}

@doc("""
Represents an emotion hypothesis detected from response audio with multiple candidates.
""")
model ResponseEmotionHypothesis extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_emotion_hypothesis;
  emotion: string;
  candidates: EmotionCandidate[],
  audio_offset_ms: int32;
  audio_duration_ms: int32;
  response_id?: string;
  item_id: string;
}

@doc("""
Represents a word-level audio timestamp delta for a response.
""")
model ResponseAudioTimestampDeltaEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_audio_timestamp_delta;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  audio_duration_ms: int32;
  text: string;
  timestamp_type: "word";
}

@doc("""
Indicates completion of audio timestamp delivery for a response.
""")
model ResponseAudioTimestampDoneEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_audio_timestamp_done;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("""
Represents a viseme ID delta update for animation based on audio.
""")
model ResponseAnimationVisemeDeltaEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_animation_viseme_delta;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  viseme_id: int32;
}

@doc("""
Indicates completion of viseme animation delivery for a response.
""")
model ResponseAnimationVisemeDoneEvent extends VoiceLiveServerEvent {
  type: VoiceLiveServerEventType.response_animation_viseme_done;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

/** Create a new VoiceLive response with these parameters */
model VoiceLiveResponseCreateParams {
  @doc("""
  Whether to commit the response to the conversation. Defaults to true.
  """)
  commit?: boolean = true;

  @doc("""
  Whether to cancel any ongoing generation before starting this one. Defaults to true.
  """)
  cancel_previous?: boolean = true;

  @doc("""
  Input items to append to the conversation context before generating a response.
  """)
  append_input_items?: VoiceLiveConversationRequestItem[];

  @doc("""
  Input items to be used as the context for this response.
  An empty array clears previous context.
  """)
  input_items?: VoiceLiveConversationRequestItem[];

  // Tool customization: Apply reusable modality representation
  /**
   * The set of modalities the model can respond with. To disable audio,
   * set this to ["text"].
   */
  modalities?: VoiceLiveModality[];

  @doc("""
    The default system instructions (i.e. system message) prepended to model
    calls. This field allows the client to guide the model on desired
    responses. The model can be instructed on response content and format,
    (e.g. "be extremely succinct", "act friendly", "here are examples of good
    responses") and on audio behavior (e.g. "talk quickly", "inject emotion
    into your voice", "laugh frequently"). The instructions are not guaranteed
    to be followed by the model, but they provide guidance to the model on the
    desired behavior.
    
    Note that the server sets default instructions which will be used if this
    field is not set and are visible in the `session.created` event at the
    start of the session.
    """)
  instructions?: string;

  @doc("""
    supported voice identifiers and configurations.
    """)
  voice?: Voice;

  // Tool customization: use extracted and reusable audio format definition
  @doc("""
    The format of output audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
    """)
  output_audio_format?: VoiceLiveAudioFormat = VoiceLiveAudioFormat.pcm16;

  // Tool customization: use enriched tool definition
  /** Tools (functions) available to the model. */
  tools?: VoiceLiveTool[];

  @doc("""
    How the model chooses tools. Options are `auto`, `none`, `required`, or
    specify a function, like `{"type": "function", "function": {"name": "my_function"}}`.
    """)
  tool_choice?: string;

  /** Sampling temperature for the model, limited to [0.6, 1.2]. Defaults to 0.8. */
  temperature?: float32;

  // Tool customization: Address (observed as of 2025-01-31) spec issue with 'max_response_output_tokens'
  @doc("""
    Maximum number of output tokens for a single assistant response,
    inclusive of tool calls. Provide an integer between 1 and 4096 to
    limit output tokens, or `inf` for the maximum available tokens for a
    given model. Defaults to `inf`.
    """)
  max_output_tokens?: int32 | "inf";
}

/** The item to add to the conversation. */
model VoiceLiveConversationItemWithReference {
  @doc("""
    For an item of type (`message` | `function_call` | `function_call_output`)
    this field allows the client to assign the unique ID of the item. It is
    not required because the server will generate one if not provided.
    
    For an item of type `item_reference`, this field is required and is a
    reference to any item that has previously existed in the conversation.
    """)
  id?: string;

  @doc("""
    The type of the item (`message`, `function_call`, `function_call_output`, `item_reference`).
    """)
  type?: "message" | "function_call" | "function_call_output";

  @doc("""
    Identifier for the API object being returned - always `realtime.item`.
    """)
  object?: "realtime.item";

  @doc("""
    The status of the item (`completed`, `incomplete`). These have no effect
    on the conversation, but are accepted for consistency with the
    `conversation.item.created` event.
    """)
  status?: "completed" | "incomplete";

  @doc("""
    The role of the message sender (`user`, `assistant`, `system`), only
    applicable for `message` items.
    """)
  role?: "user" | "assistant" | "system";

  @doc("""
    The content of the message, applicable for `message` items.
    - Message items of role `system` support only `input_text` content
    - Message items of role `user` support `input_text` and `input_audio`
      content
    - Message items of role `assistant` support `text` content.
    """)
  content?: VoiceLiveConversationItemWithReferenceContent[];

  @doc("""
    The ID of the function call (for `function_call` and
    `function_call_output` items). If passed on a `function_call_output`
    item, the server will check that a `function_call` item with the same
    ID exists in the conversation history.
    """)
  call_id?: string;

  @doc("""
    The name of the function being called (for `function_call` items).
    """)
  name?: string;

  @doc("""
    The arguments of the function call (for `function_call` items).
    """)
  arguments?: string;

  @doc("""
    The output of the function call (for `function_call_output` items).
    """)
  output?: string;
}

// Tool customization (apply_discriminator): apply discriminated type base
@doc("""
  Send this event when you want to retrieve the server's representation of a specific item in the conversation history. This is useful, for example, to inspect user audio after noise cancellation and VAD.
  The server will respond with a `conversation.item.retrieved` event,
  unless the item does not exist in the conversation history, in which case the
  server will respond with an error.
  """)
model VoiceLiveClientEventConversationItemRetrieve extends VoiceLiveClientEvent {
  @doc("""
    The event type, must be `conversation.item.retrieve`.
    """)
  type: VoiceLiveClientEventType.conversation_item_retrieve;

  /** The ID of the item to retrieve. */
  item_id: string;
}

// Tool customization (apply_discriminator): apply discriminated type
/** Returned when the text value of an input audio transcription content part is updated. */
model VoiceLiveServerEventConversationItemInputAudioTranscriptionDelta
  extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `conversation.item.input_audio_transcription.delta`.
    """)
  type: VoiceLiveServerEventType.conversation_item_input_audio_transcription_delta;

  /** The ID of the item. */
  item_id: string;

  /** The index of the content part in the item's content array. */
  content_index?: int32;

  /** The text delta. */
  delta?: string;

  /** The log probabilities of the transcription. */
  logprobs?: LogProbProperties[] | null;
}

// Tool customization (apply_discriminator): apply discriminated type
@doc("""
  Returned when a conversation item is retrieved with `conversation.item.retrieve`.
  """)
model VoiceLiveServerEventConversationItemRetrieved extends VoiceLiveServerEvent {
  @doc("""
    The event type, must be `conversation.item.retrieved`.
    """)
  type: VoiceLiveServerEventType.conversation_item_retrieved;
  item_id?: string;
  event_id?: string;
}

model EmotionCandidate {
  emotion: string;
  confidence: float32;
}
