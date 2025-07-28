import "@azure-tools/typespec-client-generator-core";
import "./servers/websocket.tsp";

using Azure.ClientGenerator.Core;

@@access(VoiceLive.force_models, Access.internal, "python");
@@access(VoiceLive.force_models, Access.internal, "csharp");

@@access(VoiceLive.VoiceLiveServerEventSessionCreated, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseAudioDelta, Access.public, "python");
@@access(VoiceLive.VoiceLiveClientEventSessionUpdate, Access.public, "python");
@@access(VoiceLive.VoiceLiveConversationResponseItem, Access.public, "python");
@@access(VoiceLive.VoiceLiveResponse, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemCreated, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemDeleted, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemInputAudioTranscriptionCompleted, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemInputAudioTranscriptionDelta, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemInputAudioTranscriptionFailed, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemRetrieved, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventConversationItemTruncated, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventError, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventInputAudioBufferCleared, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventInputAudioBufferCommitted, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventInputAudioBufferSpeechStarted, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventInputAudioBufferSpeechStopped, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseAudioDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseAudioTranscriptDelta, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseAudioTranscriptDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseContentPartAdded, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseContentPartDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseCreated, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseOutputItemAdded, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseOutputItemDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseTextDelta, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventResponseTextDone, Access.public, "python");
@@access(VoiceLive.VoiceLiveServerEventSessionUpdated, Access.public, "python");

