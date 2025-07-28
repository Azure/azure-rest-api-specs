import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "../models.tsp";
import "../operations.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "VoiceLive"})
@versioned(VoiceLive.Versions)
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | AadOauth2Auth<[
    "https://cognitiveservices.azure.com/.default"
  ]>
)
@server(
  "{endpoint}/voice-agent/realtime",
  "VoiceLive Endpoint",
  {
    @doc("""
      Azure AI VoiceLive endpoint.
      """)
    endpoint: url,
  }
)


namespace VoiceLive;
op force_models(session: VoiceLiveClientEventSessionUpdate):
  VoiceLiveServerEventSessionUpdated
  | VoiceLiveServerEventSessionCreated
  | VoiceLiveServerEventError
  | VoiceLiveServerEventResponseTextDelta
  | VoiceLiveServerEventResponseAudioDelta
  | VoiceLiveServerEventConversationItemCreated
  | VoiceLiveServerEventConversationItemDeleted
  | VoiceLiveServerEventConversationItemRetrieved
  | VoiceLiveServerEventConversationItemTruncated
  | VoiceLiveServerEventConversationItemInputAudioTranscriptionCompleted
  | VoiceLiveServerEventConversationItemInputAudioTranscriptionDelta
  | VoiceLiveServerEventConversationItemInputAudioTranscriptionFailed
  | VoiceLiveServerEventInputAudioBufferCommitted
  | VoiceLiveServerEventInputAudioBufferCleared
  | VoiceLiveServerEventInputAudioBufferSpeechStarted
  | VoiceLiveServerEventInputAudioBufferSpeechStopped
  | VoiceLiveServerEventResponseCreated
  | VoiceLiveServerEventResponseDone
  | VoiceLiveServerEventResponseOutputItemAdded
  | VoiceLiveServerEventResponseOutputItemDone
  | VoiceLiveServerEventResponseContentPartAdded
  | VoiceLiveServerEventResponseContentPartDone
  | VoiceLiveServerEventResponseTextDone
  | VoiceLiveServerEventResponseAudioTranscriptDelta
  | VoiceLiveServerEventResponseAudioTranscriptDone
  | VoiceLiveServerEventResponseAudioDone;