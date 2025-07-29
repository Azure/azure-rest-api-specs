import "@azure-tools/typespec-client-generator-core";
import "./servers/websocket.tsp";

using Azure.ClientGenerator.Core;

@@access(VoiceLive.force_models, Access.internal, "python");
@@access(VoiceLive.force_models, Access.internal, "csharp");

@@access(VoiceLive.ServerEventSessionCreated, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioDelta, Access.public, "python");
@@access(VoiceLive.ClientEventSessionUpdate, Access.public, "python");
@@access(VoiceLive.ConversationResponseItem, Access.public, "python");
@@access(VoiceLive.Response, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemCreated, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemDeleted, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionCompleted, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionDelta, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionFailed, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemRetrieved, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemTruncated, Access.public, "python");
@@access(VoiceLive.ServerEventError, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferCleared, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferCommitted, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStarted, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStopped, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioTranscriptDelta, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioTranscriptDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseContentPartAdded, Access.public, "python");
@@access(VoiceLive.ServerEventResponseContentPartDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseCreated, Access.public, "python");
@@access(VoiceLive.ServerEventResponseDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseOutputItemAdded, Access.public, "python");
@@access(VoiceLive.ServerEventResponseOutputItemDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseTextDelta, Access.public, "python");
@@access(VoiceLive.ServerEventResponseTextDone, Access.public, "python");
@@access(VoiceLive.ServerEventSessionUpdated, Access.public, "python");

