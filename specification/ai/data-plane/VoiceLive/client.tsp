import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

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
@@access(VoiceLive.ClientEventConversationItemRetrieve,
  Access.public,
  "python"
);
@@access(VoiceLive.ClientEventConversationItemTruncate,
  Access.public,
  "python"
);
@@access(VoiceLive.ClientEventConversationItemDelete, Access.public, "python");
@@access(VoiceLive.ClientEventResponseCreate, Access.public, "python");
@@access(VoiceLive.ClientEventResponseCancel, Access.public, "python");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.public, "python");

@@access(VoiceLive.ServerEventSessionAvatarConnecting, Access.public, "python");
@@access(VoiceLive.ServerEventSessionCreated, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioDelta, Access.public, "python");
@@access(VoiceLive.ResponseItem, Access.public, "python");
@@access(VoiceLive.Response, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemCreated, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemDeleted, Access.public, "python");
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionCompleted,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionDelta,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionFailed,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventConversationItemRetrieved,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventConversationItemTruncated,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventError, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferCleared, Access.public, "python");
@@access(VoiceLive.ServerEventInputAudioBufferCommitted,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStarted,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStopped,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseAudioDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseAudioTranscriptDelta,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseAudioTranscriptDone,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseContentPartAdded,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseContentPartDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseCreated, Access.public, "python");
@@access(VoiceLive.ServerEventResponseDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseFunctionCallArgumentsDelta,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseFunctionCallArgumentsDone,
  Access.public,
  "python"
);
@@access(VoiceLive.ServerEventResponseOutputItemAdded, Access.public, "python");
@@access(VoiceLive.ServerEventResponseOutputItemDone, Access.public, "python");
@@access(VoiceLive.ServerEventResponseTextDelta, Access.public, "python");
@@access(VoiceLive.ServerEventResponseTextDone, Access.public, "python");
@@access(VoiceLive.ServerEventSessionUpdated, Access.public, "python");

@@access(VoiceLive.ToolChoice, Access.public, "python");

@@clientName(VoiceLive.Scene, "SceneParams", "csharp");
@@access(VoiceLive.Voice, Access.public, "python");

@@clientName(VoiceLive.OAIVoice, "OpenAIVoiceName", "python");
@@clientName(VoiceLive.ToolChoiceObject, "ToolChoiceSelection", "python");
@@clientName(VoiceLive.ToolChoiceFunctionObject,
  "ToolChoiceFunctionSelection",
  "python"
);

@@access(VoiceLive.ServerEvent, Access.public, "csharp");
@@access(VoiceLive.ServerEventSessionCreated, Access.public, "csharp");
@@access(VoiceLive.ClientEvent, Access.internal, "csharp");
@@access(VoiceLive.ClientEventConversationItemCreate,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventConversationItemDelete,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventConversationItemRetrieve,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventConversationItemTruncate,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventInputAudioBufferAppend,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventInputAudioBufferClear, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioBufferCommit,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventInputAudioClear, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.internal, "csharp");
@@access(VoiceLive.ClientEventResponseCancel, Access.internal, "csharp");
@@access(VoiceLive.ClientEventResponseCreate, Access.internal, "csharp");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.internal, "csharp");
@@access(VoiceLive.ClientEventSessionUpdate, Access.internal, "csharp");
@@access(VoiceLive.VideoCrop.bottom_right, Access.internal, "csharp");
@@access(VoiceLive.VideoCrop.top_left, Access.internal, "csharp");
@@access(VoiceLive.Response.voice, Access.internal, "csharp");
@@access(VoiceLive.ToolChoiceFunctionObject, Access.internal, "csharp");
@@access(VoiceLive.ToolChoiceObject, Access.internal, "csharp");
@@access(VoiceLive.ServerEventMcpListToolsInProgress, Access.public, "csharp");
@@access(VoiceLive.ServerEventMcpListToolsCompleted, Access.public, "csharp");
@@access(VoiceLive.ServerEventMcpListToolsFailed, Access.public, "csharp");
@@access(VoiceLive.ServerEventResponseMcpCallArgumentsDelta,
  Access.public,
  "csharp"
);
@@access(VoiceLive.ServerEventResponseMcpCallArgumentsDone,
  Access.public,
  "csharp"
);
@@access(VoiceLive.ServerEventResponseMcpCallInProgress,
  Access.public,
  "csharp"
);
@@access(VoiceLive.ServerEventResponseMcpCallCompleted,
  Access.public,
  "csharp"
);
@@access(VoiceLive.ServerEventResponseMcpCallFailed, Access.public, "csharp");
@@access(VoiceLive.MCPApprovalResponseRequestItem, Access.internal, "csharp");

@@clientName(VoiceLive.Modality, "InteractionModality", "csharp");
@@clientName(VoiceLive.Animation, "AnimationOptions", "csharp");
@@clientName(VoiceLive.Tool, "VoiceLiveToolInvocation", "csharp");
@@clientName(VoiceLive.AzureCustomVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "csharp"
);
@@clientName(VoiceLive.IceServer.urls, "Uris", "csharp");
@@clientName(VoiceLive.VideoCrop.bottom_right, "BottomRightInternal", "csharp");
@@clientName(VoiceLive.VideoCrop.top_left, "TopLeftInternal", "csharp");
@@clientName(VoiceLive.Response, "SessionResponse", "csharp");
@@clientName(VoiceLive.AgentConfig, "RespondingAgentOptions", "csharp");
@@clientName(VoiceLive.FunctionTool, "VoiceLiveFunctionDefinition", "csharp");
@@clientName(VoiceLive.Tool, "VoiceLiveToolDefinition", "csharp");
@@clientName(VoiceLive.ContentPart, "VoiceLiveContentPart", "csharp");
@@clientName(VoiceLive.MessageRole, "ResponseMessageRole", "csharp");
@@clientName(VoiceLive.ResponseItem, "SessionResponseItem", "csharp");
@@clientName(VoiceLive.ResponseMessageItem,
  "SessionResponseMessageItem",
  "csharp"
);
@@clientName(VoiceLive.ResponseStatus, "SessionResponseStatus", "csharp");
@@clientName(VoiceLive.ResponseItemStatus,
  "SessionResponseItemStatus",
  "csharp"
);
@@clientName(VoiceLive.ServerEvent, "SessionUpdate", "csharp");
@@clientName(VoiceLive.ServerEventSessionCreated,
  "SessionUpdateSessionCreated",
  "csharp"
);
@@clientName(VoiceLive.ServerEventSessionUpdated,
  "SessionUpdateSessionUpdated",
  "csharp"
);
@@clientName(VoiceLive.ServerEventSessionAvatarConnecting,
  "SessionUpdateAvatarConnecting",
  "csharp"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStarted,
  "SessionUpdateInputAudioBufferSpeechStarted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStopped,
  "SessionUpdateInputAudioBufferSpeechStopped",
  "csharp"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferCleared,
  "SessionUpdateInputAudioBufferCleared",
  "csharp"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferCommitted,
  "SessionUpdateInputAudioBufferCommitted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseCreated,
  "SessionUpdateResponseCreated",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseDone,
  "SessionUpdateResponseDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioDelta,
  "SessionUpdateResponseAudioDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioDone,
  "SessionUpdateResponseAudioDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioTranscriptDelta,
  "SessionUpdateResponseAudioTranscriptDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioTranscriptDone,
  "SessionUpdateResponseAudioTranscriptDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDelta,
  "SessionUpdateResponseAudioTimestampDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDone,
  "SessionUpdateResponseAudioTimestampDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseTextDelta,
  "SessionUpdateResponseTextDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseTextDone,
  "SessionUpdateResponseTextDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseContentPartAdded,
  "SessionUpdateResponseContentPartAdded",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseContentPartDone,
  "SessionUpdateResponseContentPartDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseOutputItemAdded,
  "SessionUpdateResponseOutputItemAdded",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseOutputItemDone,
  "SessionUpdateResponseOutputItemDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseFunctionCallArgumentsDelta,
  "SessionUpdateResponseFunctionCallArgumentsDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseFunctionCallArgumentsDone,
  "SessionUpdateResponseFunctionCallArgumentsDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAnimationBlendshapeDelta,
  "SessionUpdateResponseAnimationBlendshapeDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAnimationBlendshapeDone,
  "SessionUpdateResponseAnimationBlendshapeDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAnimationVisemeDelta,
  "SessionUpdateResponseAnimationVisemeDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseAnimationVisemeDone,
  "SessionUpdateResponseAnimationVisemeDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemCreated,
  "SessionUpdateConversationItemCreated",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemDeleted,
  "SessionUpdateConversationItemDeleted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemRetrieved,
  "SessionUpdateConversationItemRetrieved",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemTruncated,
  "SessionUpdateConversationItemTruncated",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionCompleted,
  "SessionUpdateConversationItemInputAudioTranscriptionCompleted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionDelta,
  "SessionUpdateConversationItemInputAudioTranscriptionDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionFailed,
  "SessionUpdateConversationItemInputAudioTranscriptionFailed",
  "csharp"
);
@@clientName(VoiceLive.ServerEventError, "SessionUpdateError", "csharp");
@@clientName(VoiceLive.ServerEventErrorDetails,
  "SessionUpdateErrorDetails",
  "csharp"
);
@@clientName(VoiceLive.TokenUsage, "ResponseTokenStatistics", "csharp");
@@clientName(VoiceLive.RequestSession, "VoiceLiveSessionOptions", "csharp");
@@clientName(VoiceLive.ResponseSession, "VoiceLiveSessionResponse", "csharp");
@@clientName(VoiceLive.AvatarConfig, "AvatarConfiguration", "csharp");
@@clientName(VoiceLive.AzureSemanticDetection.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(VoiceLive.ServerVad, "ServerVadTurnDetection", "csharp");
@@clientName(VoiceLive.AzureSemanticVad,
  "AzureSemanticVadTurnDetection",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticVadEn,
  "AzureSemanticVadTurnDetectionEn",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticVadMultilingual,
  "AzureSemanticVadTurnDetectionMultilingual",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticDetection,
  "AzureSemanticEouDetection",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticDetectionEn,
  "AzureSemanticEouDetectionEn",
  "csharp"
);
@@clientName(VoiceLive.AzureSemanticDetectionMultilingual,
  "AzureSemanticEouDetectionMultilingual",
  "csharp"
);
@@clientName(VoiceLive.ServerEventMcpListToolsInProgress,
  "SessionUpdateMcpListToolsInProgress",
  "csharp"
);
@@clientName(VoiceLive.ServerEventMcpListToolsCompleted,
  "SessionUpdateMcpListToolsCompleted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventMcpListToolsFailed,
  "SessionUpdateMcpListToolsFailed",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseMcpCallArgumentsDelta,
  "SessionUpdateResponseMcpCallArgumentsDelta",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseMcpCallArgumentsDone,
  "SessionUpdateResponseMcpCallArgumentsDone",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseMcpCallInProgress,
  "SessionUpdateResponseMcpCallInProgress",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseMcpCallCompleted,
  "SessionUpdateResponseMcpCallCompleted",
  "csharp"
);
@@clientName(VoiceLive.ServerEventResponseMcpCallFailed,
  "SessionUpdateResponseMcpCallFailed",
  "csharp"
);
@@clientName(VoiceLive.ResponseMCPListToolItem,
  "SessionResponseMcpListToolItem",
  "csharp"
);
@@clientName(VoiceLive.ResponseMCPCallItem,
  "SessionResponseMcpCallItem",
  "csharp"
);
@@clientName(VoiceLive.ResponseMCPApprovalRequestItem,
  "SessionResponseMcpApprovalRequestItem",
  "csharp"
);
@@clientName(VoiceLive.ResponseMCPApprovalResponseItem,
  "SessionResponseMcpApprovalResponseItem",
  "csharp"
);
@@clientName(VoiceLive.MCPServer, "VoiceLiveMcpServerDefinition", "csharp");
@@clientName(VoiceLive.MCPTool, "VoiceLiveMcpTool", "csharp");
@@clientName(VoiceLive.Background, "VideoBackground", "csharp");
@@alternateType(VoiceLive.RequestSession.turn_detection, unknown, "csharp");

@@access(VoiceLive.ClientEventSessionUpdate, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioBufferAppend, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioBufferCommit, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioBufferClear, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioClear, Access.public, "java");
@@access(VoiceLive.ClientEventConversationItemCreate, Access.public, "java");
@@access(VoiceLive.ClientEventConversationItemRetrieve, Access.public, "java");
@@access(VoiceLive.ClientEventConversationItemTruncate, Access.public, "java");
@@access(VoiceLive.ClientEventConversationItemDelete, Access.public, "java");
@@access(VoiceLive.ClientEventResponseCreate, Access.public, "java");
@@access(VoiceLive.ClientEventResponseCancel, Access.public, "java");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.public, "java");

@@access(VoiceLive.ServerEventSessionAvatarConnecting, Access.public, "java");
@@access(VoiceLive.ServerEventSessionCreated, Access.public, "java");
@@access(VoiceLive.ServerEventResponseAudioDelta, Access.public, "java");
@@access(VoiceLive.ResponseItem, Access.public, "java");
@@access(VoiceLive.Response, Access.public, "java");
@@access(VoiceLive.ServerEventConversationItemCreated, Access.public, "java");
@@access(VoiceLive.ServerEventConversationItemDeleted, Access.public, "java");
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionCompleted,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionDelta,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventConversationItemInputAudioTranscriptionFailed,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventConversationItemRetrieved, Access.public, "java");
@@access(VoiceLive.ServerEventConversationItemTruncated, Access.public, "java");
@@access(VoiceLive.ServerEventError, Access.public, "java");
@@access(VoiceLive.ServerEventInputAudioBufferCleared, Access.public, "java");
@@access(VoiceLive.ServerEventInputAudioBufferCommitted, Access.public, "java");
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStarted,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventInputAudioBufferSpeechStopped,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventResponseAudioDone, Access.public, "java");
@@access(VoiceLive.ServerEventResponseAudioTranscriptDelta,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventResponseAudioTranscriptDone,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventResponseContentPartAdded, Access.public, "java");
@@access(VoiceLive.ServerEventResponseContentPartDone, Access.public, "java");
@@access(VoiceLive.ServerEventResponseCreated, Access.public, "java");
@@access(VoiceLive.ServerEventResponseDone, Access.public, "java");
@@access(VoiceLive.ServerEventResponseFunctionCallArgumentsDelta,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventResponseFunctionCallArgumentsDone,
  Access.public,
  "java"
);
@@access(VoiceLive.ServerEventResponseOutputItemAdded, Access.public, "java");
@@access(VoiceLive.ServerEventResponseOutputItemDone, Access.public, "java");
@@access(VoiceLive.ServerEventResponseTextDelta, Access.public, "java");
@@access(VoiceLive.ServerEventResponseTextDone, Access.public, "java");
@@access(VoiceLive.ServerEventSessionUpdated, Access.public, "java");

@@access(VoiceLive.ToolChoice, Access.public, "java");
@@access(VoiceLive.Voice, Access.public, "java");

@@clientName(VoiceLive.OAIVoice, "OpenAIVoiceName", "java");
@@clientName(VoiceLive.ToolChoiceObject, "ToolChoiceSelection", "java");
@@clientName(VoiceLive.ToolChoiceFunctionObject,
  "ToolChoiceFunctionSelection",
  "java"
);

@@clientName(VoiceLive.Modality, "InteractionModality", "java");
@@clientName(VoiceLive.Animation, "AnimationOptions", "java");
@@clientName(VoiceLive.Tool, "VoiceLiveToolInvocation", "java");
@@clientName(VoiceLive.AzureCustomVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "java"
);
@@clientName(VoiceLive.IceServer.urls, "Uris", "java");
@@clientName(VoiceLive.VideoCrop.bottom_right, "BottomRightInternal", "java");
@@clientName(VoiceLive.VideoCrop.top_left, "TopLeftInternal", "java");
@@clientName(VoiceLive.Response, "SessionResponse", "java");
@@clientName(VoiceLive.AgentConfig, "RespondingAgentOptions", "java");
@@clientName(VoiceLive.FunctionTool, "VoiceLiveFunctionDefinition", "java");
@@clientName(VoiceLive.Tool, "VoiceLiveToolDefinition", "java");
@@clientName(VoiceLive.ContentPart, "VoiceLiveContentPart", "java");
@@clientName(VoiceLive.MessageRole, "ResponseMessageRole", "java");
@@clientName(VoiceLive.ResponseItem, "SessionResponseItem", "java");
@@clientName(VoiceLive.ResponseMessageItem,
  "SessionResponseMessageItem",
  "java"
);
@@clientName(VoiceLive.ResponseStatus, "SessionResponseStatus", "java");
@@clientName(VoiceLive.ResponseItemStatus, "SessionResponseItemStatus", "java");
@@clientName(VoiceLive.ServerEvent, "SessionUpdate", "java");
@@clientName(VoiceLive.ServerEventSessionCreated,
  "SessionUpdateSessionCreated",
  "java"
);
@@clientName(VoiceLive.ServerEventSessionUpdated,
  "SessionUpdateSessionUpdated",
  "java"
);
@@clientName(VoiceLive.ServerEventSessionAvatarConnecting,
  "SessionUpdateAvatarConnecting",
  "java"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStarted,
  "SessionUpdateInputAudioBufferSpeechStarted",
  "java"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStopped,
  "SessionUpdateInputAudioBufferSpeechStopped",
  "java"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferCleared,
  "SessionUpdateInputAudioBufferCleared",
  "java"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferCommitted,
  "SessionUpdateInputAudioBufferCommitted",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseCreated,
  "SessionUpdateResponseCreated",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseDone,
  "SessionUpdateResponseDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioDelta,
  "SessionUpdateResponseAudioDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioDone,
  "SessionUpdateResponseAudioDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioTranscriptDelta,
  "SessionUpdateResponseAudioTranscriptDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioTranscriptDone,
  "SessionUpdateResponseAudioTranscriptDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDelta,
  "SessionUpdateResponseAudioTimestampDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDone,
  "SessionUpdateResponseAudioTimestampDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseTextDelta,
  "SessionUpdateResponseTextDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseTextDone,
  "SessionUpdateResponseTextDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseContentPartAdded,
  "SessionUpdateResponseContentPartAdded",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseContentPartDone,
  "SessionUpdateResponseContentPartDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseOutputItemAdded,
  "SessionUpdateResponseOutputItemAdded",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseOutputItemDone,
  "SessionUpdateResponseOutputItemDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseFunctionCallArgumentsDelta,
  "SessionUpdateResponseFunctionCallArgumentsDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseFunctionCallArgumentsDone,
  "SessionUpdateResponseFunctionCallArgumentsDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAnimationBlendshapeDelta,
  "SessionUpdateResponseAnimationBlendshapeDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAnimationBlendshapeDone,
  "SessionUpdateResponseAnimationBlendshapeDone",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAnimationVisemeDelta,
  "SessionUpdateResponseAnimationVisemeDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventResponseAnimationVisemeDone,
  "SessionUpdateResponseAnimationVisemeDone",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemCreated,
  "SessionUpdateConversationItemCreated",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemDeleted,
  "SessionUpdateConversationItemDeleted",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemRetrieved,
  "SessionUpdateConversationItemRetrieved",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemTruncated,
  "SessionUpdateConversationItemTruncated",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionCompleted,
  "SessionUpdateConversationItemInputAudioTranscriptionCompleted",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionDelta,
  "SessionUpdateConversationItemInputAudioTranscriptionDelta",
  "java"
);
@@clientName(VoiceLive.ServerEventConversationItemInputAudioTranscriptionFailed,
  "SessionUpdateConversationItemInputAudioTranscriptionFailed",
  "java"
);
@@clientName(VoiceLive.ServerEventError, "SessionUpdateError", "java");
@@clientName(VoiceLive.ServerEventErrorDetails,
  "SessionUpdateErrorDetails",
  "java"
);
@@clientName(VoiceLive.TokenUsage, "ResponseTokenStatistics", "java");
@@clientName(VoiceLive.RequestSession, "VoiceLiveSessionOptions", "java");
@@clientName(VoiceLive.ResponseSession, "VoiceLiveSessionResponse", "java");
@@clientName(VoiceLive.AvatarConfig, "AvatarConfiguration", "java");
@@clientName(VoiceLive.AzureSemanticDetection.timeout_ms, "TimeoutMs", "java");
@@clientName(VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "TimeoutMs",
  "java"
);
@@clientName(VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "TimeoutMs",
  "java"
);
@@clientName(VoiceLive.ServerVad, "ServerVadTurnDetection", "java");
@@clientName(VoiceLive.AzureSemanticVad,
  "AzureSemanticVadTurnDetection",
  "java"
);
@@clientName(VoiceLive.AzureSemanticVadEn,
  "AzureSemanticVadTurnDetectionEn",
  "java"
);
@@clientName(VoiceLive.AzureSemanticVadMultilingual,
  "AzureSemanticVadTurnDetectionMultilingual",
  "java"
);
@@clientName(VoiceLive.AzureSemanticDetection,
  "AzureSemanticEouDetection",
  "java"
);
@@clientName(VoiceLive.AzureSemanticDetectionEn,
  "AzureSemanticEouDetectionEn",
  "java"
);
@@clientName(VoiceLive.AzureSemanticDetectionMultilingual,
  "AzureSemanticEouDetectionMultilingual",
  "java"
);
@@clientName(VoiceLive.Background, "VideoBackground", "java");

@@clientName(VoiceLive.AzureSemanticDetection.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(VoiceLive.ClientEventConversationItemTruncate.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventConversationItemTruncated.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStopped.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventInputAudioBufferSpeechStarted.audio_start_ms,
  "audioStartInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventResponseAnimationVisemeDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerEventResponseAudioTimestampDelta.audio_duration_ms,
  "audioDurationInMs",
  "javascript"
);

@@clientName(VoiceLive.AzureSemanticDetection.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "timeoutInMs",
  "javascript"
);

@@clientName(VoiceLive.ServerVad.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(VoiceLive.ServerVad.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);

@@clientName(VoiceLive.AzureSemanticVad.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVad.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVad.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(VoiceLive.AzureSemanticVadEn.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVadEn.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVadEn.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(VoiceLive.AzureSemanticVadMultilingual.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVadMultilingual.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(VoiceLive.AzureSemanticVadMultilingual.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(VoiceLive.ToolChoiceObject, "ToolChoiceSelection", "javascript");
@@clientName(VoiceLive.ToolChoiceFunctionObject,
  "ToolChoiceFunctionSelection",
  "javascript"
);

@@clientName(VoiceLive.FillerResponseConfigBase.latency_threshold_ms,
  "latencyThresholdInMs",
  "javascript"
);
