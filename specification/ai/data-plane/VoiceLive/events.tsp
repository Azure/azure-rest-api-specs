using TypeSpec.Versioning;

namespace VoiceLive;

/** Client event types used in VoiceLive protocol. */
union ClientEventType {
  string,
  session_update: "session.update",
  input_audio_buffer_append: "input_audio_buffer.append",
  input_audio_buffer_commit: "input_audio_buffer.commit",
  input_audio_buffer_clear: "input_audio_buffer.clear",
  input_audio_turn_start: "input_audio.turn.start",
  input_audio_turn_append: "input_audio.turn.append",
  input_audio_turn_end: "input_audio.turn.end",
  input_audio_turn_cancel: "input_audio.turn.cancel",
  input_audio_clear: "input_audio.clear",
  conversation_item_create: "conversation.item.create",
  conversation_item_retrieve: "conversation.item.retrieve",
  conversation_item_truncate: "conversation.item.truncate",
  conversation_item_delete: "conversation.item.delete",
  response_create: "response.create",
  response_cancel: "response.cancel",
  session_avatar_connect: "session.avatar.connect",

  @added(Versions.v2026_01_01_preview)
  mcp_approval_response: "mcp_approval_response",

  /** Client request to clear the avatar output buffer. */
  @added(Versions.v2026_04_10)
  output_audio_buffer_clear: "output_audio_buffer.clear",
}

/** Server event types used in VoiceLive protocol. */
union ServerEventType {
  string,
  error: "error",

  @added(Versions.v2026_01_01_preview)
  warning: "warning",

  session_avatar_connecting: "session.avatar.connecting",
  session_created: "session.created",
  session_updated: "session.updated",
  conversation_item_input_audio_transcription_completed: "conversation.item.input_audio_transcription.completed",
  conversation_item_input_audio_transcription_delta: "conversation.item.input_audio_transcription.delta",
  conversation_item_input_audio_transcription_failed: "conversation.item.input_audio_transcription.failed",
  conversation_item_created: "conversation.item.created",
  conversation_item_retrieved: "conversation.item.retrieved",
  conversation_item_truncated: "conversation.item.truncated",
  conversation_item_deleted: "conversation.item.deleted",
  input_audio_buffer_committed: "input_audio_buffer.committed",
  input_audio_buffer_cleared: "input_audio_buffer.cleared",
  input_audio_buffer_speech_started: "input_audio_buffer.speech_started",
  input_audio_buffer_speech_stopped: "input_audio_buffer.speech_stopped",
  response_created: "response.created",
  response_done: "response.done",
  response_output_item_added: "response.output_item.added",
  response_output_item_done: "response.output_item.done",
  response_content_part_added: "response.content_part.added",
  response_content_part_done: "response.content_part.done",
  response_text_delta: "response.text.delta",
  response_text_done: "response.text.done",
  response_audio_transcript_delta: "response.audio_transcript.delta",
  response_audio_transcript_done: "response.audio_transcript.done",
  response_audio_delta: "response.audio.delta",
  response_audio_done: "response.audio.done",
  response_animation_blendshapes_delta: "response.animation_blendshapes.delta",
  response_animation_blendshapes_done: "response.animation_blendshapes.done",
  response_audio_timestamp_delta: "response.audio_timestamp.delta",
  response_audio_timestamp_done: "response.audio_timestamp.done",
  response_animation_viseme_delta: "response.animation_viseme.delta",
  response_animation_viseme_done: "response.animation_viseme.done",
  response_function_call_arguments_delta: "response.function_call_arguments.delta",
  response_function_call_arguments_done: "response.function_call_arguments.done",

  @added(Versions.v2026_01_01_preview)
  mcp_list_tools_in_progress: "mcp_list_tools.in_progress",

  @added(Versions.v2026_01_01_preview)
  mcp_list_tools_completed: "mcp_list_tools.completed",

  @added(Versions.v2026_01_01_preview)
  mcp_list_tools_failed: "mcp_list_tools.failed",

  @added(Versions.v2026_01_01_preview)
  response_mcp_call_arguments_delta: "response.mcp_call_arguments.delta",

  @added(Versions.v2026_01_01_preview)
  response_mcp_call_arguments_done: "response.mcp_call_arguments.done",

  @added(Versions.v2026_01_01_preview)
  response_mcp_call_in_progress: "response.mcp_call.in_progress",

  @added(Versions.v2026_01_01_preview)
  response_mcp_call_completed: "response.mcp_call.completed",

  @added(Versions.v2026_01_01_preview)
  response_mcp_call_failed: "response.mcp_call.failed",

  /** Avatar switches to speaking state. */
  @added(Versions.v2026_04_10)
  session_avatar_switch_to_speaking: "session.avatar.switch_to_speaking",

  /** Avatar switches to idle state. */
  @added(Versions.v2026_04_10)
  session_avatar_switch_to_idle: "session.avatar.switch_to_idle",

  /** Delta update for avatar video frames. */
  @added(Versions.v2026_04_10)
  response_video_delta: "response.video.delta",

  /** Web search call is searching. */
  @added(Versions.v2026_04_10)
  response_web_search_call_searching: "response.web_search_call.searching",

  /** Web search call is in progress. */
  @added(Versions.v2026_04_10)
  response_web_search_call_in_progress: "response.web_search_call.in_progress",

  /** Web search call completed. */
  @added(Versions.v2026_04_10)
  response_web_search_call_completed: "response.web_search_call.completed",

  /** File search call is searching. */
  @added(Versions.v2026_04_10)
  response_file_search_call_searching: "response.file_search_call.searching",

  /** File search call is in progress. */
  @added(Versions.v2026_04_10)
  response_file_search_call_in_progress: "response.file_search_call.in_progress",

  /** File search call completed. */
  @added(Versions.v2026_04_10)
  response_file_search_call_completed: "response.file_search_call.completed",

  /** Output audio buffer has been cleared. */
  @added(Versions.v2026_04_10)
  output_audio_buffer_cleared: "output_audio_buffer.cleared",

  /** Audio transcript annotation added. */
  @added(Versions.v2026_04_10)
  response_audio_transcript_annotation_added: "response.audio_transcript.annotation.added",
}
