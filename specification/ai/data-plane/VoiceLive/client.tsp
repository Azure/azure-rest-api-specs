import "@azure-tools/typespec-client-generator-core";
import "./servers/websocket.tsp";

using Azure.ClientGenerator.Core;

@@access(VoiceLive.force_models, Access.internal, "python");
@@access(VoiceLive.force_models, Access.internal, "csharp");

@@access(VoiceLive.ClientEventSessionUpdate, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioBufferAppend, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioBufferCommit, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioBufferClear, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioClear, Access.public, "python");
@@access(VoiceLive.ClientEventConversationItemCreate, Access.public, "python");
@@access(VoiceLive.ClientEventConversationItemRetrieve, Access.public, "python");
@@access(VoiceLive.ClientEventConversationItemTruncate, Access.public, "python");
@@access(VoiceLive.ClientEventConversationItemDelete, Access.public, "python");
@@access(VoiceLive.ClientEventResponseCreate, Access.public, "python");
@@access(VoiceLive.ClientEventResponseCancel, Access.public, "python");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.public, "python");


@@access(VoiceLive.ServerEventSessionAvatarConnecting, Access.public, "python");
@@access(VoiceLive.ServerEventSessionCreated, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioDelta, Access.public, "python");
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

@@access(VoiceLive.ServerEvent, Access.public, "csharp");
@@access(VoiceLive.ClientEvent, Access.public, "csharp");
@@access(VoiceLive.ClientEventSessionUpdate, Access.public, "csharp");
@@access(VoiceLive.VideoCrop.bottom_right, Access.internal, "csharp");
@@access(VoiceLive.VideoCrop.top_left, Access.internal, "csharp");

@@clientName(VoiceLive.Modality, "InputModality", "csharp");
@@clientName(VoiceLive.Animation, "AnimationOptions", "csharp");
@@clientName(VoiceLive.Tool, "ToolCall", "csharp");
@@clientName(VoiceLive.AzureCustomVoice.custom_lexicon_url, "CustomLexiconUri", "csharp");
@@clientName(VoiceLive.IceServer.urls, "Uris", "csharp");
@@clientName(VoiceLive.VideoCrop.bottom_right, "BottomRightInternal", "csharp");
@@clientName(VoiceLive.VideoCrop.top_left, "TopLeftInternal", "csharp");
@@clientName(VoiceLive.Response, "VoiceLiveResponse", "csharp");
