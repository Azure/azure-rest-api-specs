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

// Union of all client events that can be passed into `force_models`
alias ForceModelClientEvent =
  ClientEventSessionUpdate |
  ClientEventInputAudioBufferAppend |
  ClientEventInputAudioBufferCommit |
  ClientEventInputAudioBufferClear |
  ClientEventInputAudioTurnStart |
  ClientEventInputAudioTurnAppend |
  ClientEventInputAudioTurnEnd |
  ClientEventInputAudioTurnCancel |
  ClientEventInputAudioClear |
  ClientEventConversationItemCreate |
  ClientEventConversationItemRetrieve |
  ClientEventConversationItemTruncate |
  ClientEventConversationItemDelete |
  ClientEventResponseCreate |
  ClientEventResponseCancel |
  ClientEventSessionAvatarConnect;

// Union of all server events that can be returned from `force_models`
alias ForceModelServerEvent =
  ServerEventSessionAvatarConnecting |
  ServerEventSessionCreated |
  ServerEventSessionUpdated |
  ServerEventError |
  ServerEventResponseTextDelta |
  ServerEventResponseAudioDelta |
  ServerEventConversationItemCreated |
  ServerEventConversationItemDeleted |
  ServerEventConversationItemRetrieved |
  ServerEventConversationItemTruncated |
  ServerEventConversationItemInputAudioTranscriptionCompleted |
  ServerEventConversationItemInputAudioTranscriptionDelta |
  ServerEventConversationItemInputAudioTranscriptionFailed |
  ServerEventInputAudioBufferCommitted |
  ServerEventInputAudioBufferCleared |
  ServerEventInputAudioBufferSpeechStarted |
  ServerEventInputAudioBufferSpeechStopped |
  ServerEventResponseCreated |
  ServerEventResponseDone |
  ServerEventResponseOutputItemAdded |
  ServerEventResponseOutputItemDone |
  ServerEventResponseContentPartAdded |
  ServerEventResponseContentPartDone |
  ServerEventResponseTextDone |
  ServerEventResponseAudioTranscriptDelta |
  ServerEventResponseAudioTranscriptDone |
  ServerEventResponseAudioDone |
  ServerEventResponseFunctionCallArgumentsDelta |
  ServerEventResponseFunctionCallArgumentsDone |
  ServerEventResponseAnimationBlendshapeDelta |
  ServerEventResponseAnimationBlendshapeDone |
  ServerEventResponseAudioTimestampDelta |
  ServerEventResponseAudioTimestampDone |
  ServerEventResponseAnimationVisemeDelta |
  ServerEventResponseAnimationVisemeDone;


// Operation definition
//op force_models(event: ForceModelClientEvent): ForceModelServerEvent;