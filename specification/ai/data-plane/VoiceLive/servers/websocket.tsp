import "@typespec/http";
import "../models.tsp";
using TypeSpec.Http;

@service(#{
  title: "VoiceLive API"

})
@server("wss://api.voicelive.com/v1", "VoiceLive Endpoint")


@useAuth(BearerAuth)
namespace VoiceLive;
op force_models(session: VoiceLiveClientEventSessionUpdate ): 
  VoiceLiveServerEventSessionUpdated | 
  VoiceLiveServerEventSessionCreated | 
  VoiceLiveServerEventError | 
  VoiceLiveServerEventResponseTextDelta | 
  VoiceLiveServerEventResponseAudioDelta |
  VoiceLiveServerEventConversationItemCreated|
  VoiceLiveServerEventConversationItemDeleted|
  VoiceLiveServerEventConversationItemRetrieved|
  VoiceLiveServerEventConversationItemTruncated|
  VoiceLiveServerEventConversationItemInputAudioTranscriptionCompleted|
  VoiceLiveServerEventConversationItemInputAudioTranscriptionDelta|
  VoiceLiveServerEventConversationItemInputAudioTranscriptionFailed|
  VoiceLiveServerEventInputAudioBufferCommitted|
  VoiceLiveServerEventInputAudioBufferCleared|
  VoiceLiveServerEventInputAudioBufferSpeechStarted|
  VoiceLiveServerEventInputAudioBufferSpeechStopped|
  VoiceLiveServerEventResponseCreated|
  VoiceLiveServerEventResponseDone|
  VoiceLiveServerEventResponseOutputItemAdded|
  VoiceLiveServerEventResponseOutputItemDone|
  VoiceLiveServerEventResponseContentPartAdded|
  VoiceLiveServerEventResponseContentPartDone|
  VoiceLiveServerEventResponseTextDone|
  VoiceLiveServerEventResponseAudioTranscriptDelta|
  VoiceLiveServerEventResponseAudioTranscriptDone|
  VoiceLiveServerEventResponseAudioDone;
