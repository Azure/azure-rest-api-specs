import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/openai-typespec/models/realtime";

using Azure.ClientGenerator.Core;

namespace VoiceLive.V1;

/** Updates the Voice Live v1 realtime session. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage)
model ClientEventSessionUpdate {
  /** The optional client-generated event identifier. */
  event_id?: string;

  /** The event type. */
  type: "session.update";

  /** The updated Voice Live session configuration. */
  session: Session;
}

/** Requests generation of a Voice Live v1 response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage)
model ClientEventResponseCreate {
  /** The optional client-generated event identifier. */
  event_id?: string;

  /** The event type. */
  type: "response.create";

  /** Optional per-response settings. */
  response?: ResponseCreateParams;
}

/** Reports the effective Voice Live v1 session after connection. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(ResponseUsage)
model ServerEventSessionCreated {
  /** The server-generated event identifier. */
  event_id: string;

  /** The event type. */
  type: "session.created";

  /** The effective Voice Live session. */
  session: Session;
}

/** Reports the effective Voice Live v1 session after an update. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(ResponseUsage)
model ServerEventSessionUpdated {
  /** The server-generated event identifier. */
  event_id: string;

  /** The event type. */
  type: "session.updated";

  /** The effective Voice Live session. */
  session: Session;
}

/** Creates a conversation item using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventConversationItemCreate {
  ...OpenAI.RealtimeClientEventConversationItemCreate;
}

/** Deletes a conversation item using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventConversationItemDelete {
  ...OpenAI.RealtimeClientEventConversationItemDelete;
}

/** Retrieves a conversation item using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventConversationItemRetrieve {
  ...OpenAI.RealtimeClientEventConversationItemRetrieve;
}

/** Truncates a conversation item using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventConversationItemTruncate {
  ...OpenAI.RealtimeClientEventConversationItemTruncate;
}

/** Appends audio to the input buffer using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventInputAudioBufferAppend {
  ...OpenAI.RealtimeClientEventInputAudioBufferAppend;
}

/** Clears the input audio buffer using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventInputAudioBufferClear {
  ...OpenAI.RealtimeClientEventInputAudioBufferClear;
}

/** Commits the input audio buffer using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventInputAudioBufferCommit {
  ...OpenAI.RealtimeClientEventInputAudioBufferCommit;
}

/** Cancels response generation using the OpenAI GA shape. */
@usage(RequestUsage)
model ClientEventResponseCancel {
  ...OpenAI.RealtimeClientEventResponseCancel;
}

/** Reports that a conversation item was added. */
@usage(ResponseUsage)
model ServerEventConversationItemAdded {
  ...OpenAI.RealtimeServerEventConversationItemAdded;
}

/** Reports that a conversation item is complete. */
@usage(ResponseUsage)
model ServerEventConversationItemDone {
  ...OpenAI.RealtimeServerEventConversationItemDone;
}

/** Streams generated text using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseTextDelta {
  ...OpenAI.RealtimeServerEventResponseTextDelta;
}

/** Reports completed generated text using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseTextDone {
  ...OpenAI.RealtimeServerEventResponseTextDone;
}

/** Streams generated audio using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseAudioDelta {
  ...OpenAI.RealtimeServerEventResponseAudioDelta;
}

/** Reports completed generated audio using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseAudioDone {
  ...OpenAI.RealtimeServerEventResponseAudioDone;
}

/** Streams the generated audio transcript using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseAudioTranscriptDelta {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDelta;
}

/** Reports the completed generated audio transcript using the OpenAI GA shape. */
@usage(ResponseUsage)
model ServerEventResponseAudioTranscriptDone {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDone;
}

/** Client-to-service WebSocket messages supported by Voice Live v1. */
union ClientEvent {
  ClientEventSessionUpdate,
  ClientEventResponseCreate,
  ClientEventConversationItemCreate,
  ClientEventConversationItemDelete,
  ClientEventConversationItemRetrieve,
  ClientEventConversationItemTruncate,
  ClientEventInputAudioBufferAppend,
  ClientEventInputAudioBufferClear,
  ClientEventInputAudioBufferCommit,
  ClientEventResponseCancel,
}

/** Service-to-client WebSocket messages supported by Voice Live v1. */
union ServerEvent {
  ServerEventSessionCreated,
  ServerEventSessionUpdated,
  ServerEventConversationItemAdded,
  ServerEventConversationItemDone,
  ServerEventResponseTextDelta,
  ServerEventResponseTextDone,
  ServerEventResponseAudioDelta,
  ServerEventResponseAudioDone,
  ServerEventResponseAudioTranscriptDelta,
  ServerEventResponseAudioTranscriptDone,
}

/** Schema roots for the messages exchanged after the WebSocket upgrade. */
model RealtimeProtocolSchemas {
  /** Client-to-service WebSocket message schemas. */
  clientEvent: ClientEvent;

  /** Service-to-client WebSocket message schemas. */
  serverEvent: ServerEvent;
}
