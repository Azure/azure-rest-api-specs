using TypeSpec.Versioning;

namespace VoiceLive;

/**
 * Azure-specific client event types. Client events that exist in OpenAI GA
 * Realtime (`session.update`, `input_audio_buffer.*`, `conversation.item.*`,
 * `response.create`/`.cancel`, `output_audio_buffer.clear`) are consumed from
 * OpenAI directly; only Azure-only client event types are listed here.
 */
union ClientEventType {
  string,

  @removed(Versions.v1)
  input_audio_turn_start: "input_audio.turn.start",

  @removed(Versions.v1)
  input_audio_turn_append: "input_audio.turn.append",

  @removed(Versions.v1)
  input_audio_turn_end: "input_audio.turn.end",

  @removed(Versions.v1)
  input_audio_turn_cancel: "input_audio.turn.cancel",

  @removed(Versions.v1)
  input_audio_clear: "input_audio.clear",

  session_avatar_connect: "session.avatar.connect",

  /** Sent by the client to initiate a WebRTC session with an SDP offer. */
  @removed(Versions.v1)
  rtc_call_sdp_create: "rtc.call.sdp.create",

  /** Streamed delta of input text content being appended to an item. */
  input_text_delta: "input_text.delta",

  /** Signals that the streamed input text content for an item is complete. */
  input_text_done: "input_text.done",

  /** Updates authorization headers for an active BYOM connection. */
  byom_credential_update: "byom_credential.update",

}

/**
 * Azure-specific server event types. Server events that exist in OpenAI GA
 * Realtime (error, `input_audio_buffer.*`, `conversation.item.created/deleted/`
 * `truncated/retrieved`, `conversation.item.input_audio_transcription.*`,
 * `session.created/updated`, `response.text.*`, `response.audio_transcript.*`,
 * `response.content_part.*`, `response.output_item.*`, `response.created/done`,
 * `response.function_call_arguments.*`, `mcp_list_tools.*`,
 * `response.mcp_call*.*`, and `output_audio_buffer.cleared`) are
 * consumed from OpenAI directly (with Azure payloads re-injected via `custom.tsp`
 * augmentations where needed). OpenAI server events not exposed by stable v1 are
 * version-fenced in `custom.tsp`; only Azure-only event types are listed here.
 */
union ServerEventType {
  string,
  warning: "warning",
  byom_credential_updated: "byom_credential.updated",
  session_avatar_connecting: "session.avatar.connecting",

  @removed(Versions.PuPr)
  response_animation_blendshapes_delta: "response.animation_blendshapes.delta",

  @removed(Versions.PuPr)
  response_animation_blendshapes_done: "response.animation_blendshapes.done",

  response_audio_timestamp_delta: "response.audio_timestamp.delta",
  response_audio_timestamp_done: "response.audio_timestamp.done",

  @removed(Versions.PuPr)
  response_animation_viseme_delta: "response.animation_viseme.delta",

  @removed(Versions.PuPr)
  response_animation_viseme_done: "response.animation_viseme.done",

  /** Avatar switches to speaking state. */
  session_avatar_switch_to_speaking: "session.avatar.switch_to_speaking",

  /** Avatar switches to idle state. */
  session_avatar_switch_to_idle: "session.avatar.switch_to_idle",

  /** Delta update for avatar video frames. */
  response_video_delta: "response.video.delta",

  /** Web search call is searching. */
  @removed(Versions.v1)
  response_web_search_call_searching: "response.web_search_call.searching",

  /** Web search call is in progress. */
  @removed(Versions.v1)
  response_web_search_call_in_progress: "response.web_search_call.in_progress",

  /** Web search call completed. */
  @removed(Versions.v1)
  response_web_search_call_completed: "response.web_search_call.completed",

  /** File search call is searching. */
  @removed(Versions.v1)
  response_file_search_call_searching: "response.file_search_call.searching",

  /** File search call is in progress. */
  @removed(Versions.v1)
  response_file_search_call_in_progress: "response.file_search_call.in_progress",

  /** File search call completed. */
  @removed(Versions.v1)
  response_file_search_call_completed: "response.file_search_call.completed",

  /** Audio transcript annotation added. */
  @removed(Versions.PuPr)
  response_audio_transcript_annotation_added: "response.audio_transcript.annotation.added",

  /** Invocation passthrough delta from hosted agent. */
  @removed(Versions.v1)
  response_invocation_delta: "response.invocation.delta",

  /** Returned when the WebRTC SDP negotiation completes successfully. */
  @removed(Versions.v1)
  rtc_call_sdp_created: "rtc.call.sdp.created",

  /** Returned when a WebRTC call operation fails. */
  @removed(Versions.v1)
  rtc_call_error: "rtc.call.error",
}
