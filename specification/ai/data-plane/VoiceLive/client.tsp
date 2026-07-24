import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Foundry pattern: fold the consumed OpenAI namespace into the VoiceLive SDK
// namespace so generated types surface under the Azure namespace instead of a
// segregated `OpenAI` namespace (mirrors AI Foundry's `@@clientNamespace(OpenAI, ...)`).
// JavaScript is a flat modular library (no namespace segregation), so no clientNamespace
// override is needed there.
@@clientNamespace(OpenAI, "Azure.AI.VoiceLive", "csharp");
@@clientNamespace(OpenAI, "azure.ai.voicelive", "python");
@@clientNamespace(OpenAI, "com.azure.ai.voicelive", "java");

@@clientName(VoiceLive.AzureRealtimeNativeVoice.type, "Kind", "csharp");
@@clientName(
  OpenAI.RealtimeSessionCreateRequestGA.parallel_tool_calls,
  "AllowParallelToolCalls",
  "csharp"
);
@@clientName(VoiceLive.ResponseSession.expires_at, "ExpiresOn", "csharp");

@@access(OpenAI.RealtimeClientEventSessionUpdate, Access.public, "python");
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferAppend,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferCommit,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferClear,
  Access.public,
  "python"
);
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.public, "python");
@@access(VoiceLive.ClientEventInputAudioClear, Access.public, "python");
@@access(
  OpenAI.RealtimeClientEventConversationItemCreate,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemRetrieve,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemTruncate,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemDelete,
  Access.public,
  "python"
);
@@access(OpenAI.RealtimeClientEventResponseCreate, Access.public, "python");
@@access(OpenAI.RealtimeClientEventResponseCancel, Access.public, "python");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.public, "python");

@@access(VoiceLive.ServerEventSessionAvatarConnecting, Access.public, "python");
@@access(OpenAI.RealtimeServerEventSessionCreated, Access.public, "python");
@@access(OpenAI.RealtimeServerEventResponseAudioDelta, Access.public, "python");
@@access(VoiceLive.ResponseItem, Access.public, "python");
@@access(VoiceLive.Response, Access.public, "python");
@@access(
  OpenAI.RealtimeServerEventConversationItemCreated,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemDeleted,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemRetrieved,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventRealtimeServerEventError,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferCleared,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  Access.public,
  "python"
);
@@access(OpenAI.RealtimeServerEventResponseAudioDone, Access.public, "python");
@@access(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseContentPartAdded,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseContentPartDone,
  Access.public,
  "python"
);
@@access(OpenAI.RealtimeServerEventResponseCreated, Access.public, "python");
@@access(OpenAI.RealtimeServerEventResponseDone, Access.public, "python");
@@access(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseOutputItemAdded,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventResponseOutputItemDone,
  Access.public,
  "python"
);
@@access(OpenAI.RealtimeServerEventResponseTextDelta, Access.public, "python");
@@access(OpenAI.RealtimeServerEventResponseTextDone, Access.public, "python");
@@access(OpenAI.RealtimeServerEventSessionUpdated, Access.public, "python");

@@access(VoiceLive.ClientEventRtcCallSdpCreate, Access.public, "python");
@@access(VoiceLive.ServerEventRtcCallSdpCreated, Access.public, "python");
@@access(VoiceLive.ServerEventRtcCallError, Access.public, "python");
@@access(VoiceLive.RtcCallErrorDetails, Access.public, "python");
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStarted,
  Access.public,
  "python"
);
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStopped,
  Access.public,
  "python"
);

@@clientName(VoiceLive.Scene, "SceneParams", "csharp");
@@access(VoiceLive.Voice, Access.public, "python");

@@clientName(VoiceLive.OAIVoice, "OpenAIVoiceName", "python");
@@clientName(VoiceLive.AvatarConfig.type, "avatar_type", "python");

@@access(VoiceLive.ServerEvent, Access.public, "csharp");
@@access(OpenAI.RealtimeServerEventSessionCreated, Access.public, "csharp");
@@access(VoiceLive.ClientEvent, Access.internal, "csharp");
@@access(
  OpenAI.RealtimeClientEventConversationItemCreate,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemDelete,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemRetrieve,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemTruncate,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferAppend,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferClear,
  Access.internal,
  "csharp"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferCommit,
  Access.internal,
  "csharp"
);
@@access(VoiceLive.ClientEventInputAudioClear, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.internal, "csharp");
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.internal, "csharp");
@@access(OpenAI.RealtimeClientEventResponseCancel, Access.internal, "csharp");
@@access(OpenAI.RealtimeClientEventResponseCreate, Access.internal, "csharp");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.internal, "csharp");
@@access(OpenAI.RealtimeClientEventSessionUpdate, Access.internal, "csharp");
@@access(VoiceLive.ClientEventRtcCallSdpCreate, Access.internal, "csharp");
@@access(VoiceLive.ServerEventRtcCallSdpCreated, Access.public, "csharp");
@@access(VoiceLive.ServerEventRtcCallError, Access.public, "csharp");
@@access(VoiceLive.RtcCallErrorDetails, Access.public, "csharp");
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStarted,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStopped,
  Access.public,
  "csharp"
);
@@access(VoiceLive.VideoCrop.bottom_right, Access.internal, "csharp");
@@access(VoiceLive.VideoCrop.top_left, Access.internal, "csharp");
@@access(
  OpenAI.RealtimeServerEventMCPListToolsInProgress,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventMCPListToolsCompleted,
  Access.public,
  "csharp"
);
@@access(OpenAI.RealtimeServerEventMCPListToolsFailed, Access.public, "csharp");
@@access(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventResponseMCPCallInProgress,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventResponseMCPCallCompleted,
  Access.public,
  "csharp"
);
@@access(
  OpenAI.RealtimeServerEventResponseMCPCallFailed,
  Access.public,
  "csharp"
);

@@clientName(VoiceLive.Animation, "AnimationOptions", "csharp");
@@clientName(
  VoiceLive.AzureCustomVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "csharp"
);
@@clientName(VoiceLive.IceServer.urls, "Uris", "csharp");
@@clientName(VoiceLive.VideoCrop.bottom_right, "BottomRightInternal", "csharp");
@@clientName(VoiceLive.VideoCrop.top_left, "TopLeftInternal", "csharp");
@@clientName(VoiceLive.Response, "SessionResponse", "csharp");
@@clientName(VoiceLive.AgentConfig, "RespondingAgentOptions", "csharp");
@@clientName(VoiceLive.ResponseItem, "SessionResponseItem", "csharp");
@@clientName(VoiceLive.ServerEvent, "SessionUpdate", "csharp");
@@clientName(
  OpenAI.RealtimeServerEventSessionCreated,
  "SessionUpdateSessionCreated",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventSessionUpdated,
  "SessionUpdateSessionUpdated",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventSessionAvatarConnecting,
  "SessionUpdateAvatarConnecting",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  "SessionUpdateInputAudioBufferSpeechStarted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  "SessionUpdateInputAudioBufferSpeechStopped",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferCleared,
  "SessionUpdateInputAudioBufferCleared",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  "SessionUpdateInputAudioBufferCommitted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseCreated,
  "SessionUpdateResponseCreated",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseDone,
  "SessionUpdateResponseDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioDelta,
  "SessionUpdateResponseAudioDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioDone,
  "SessionUpdateResponseAudioDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  "SessionUpdateResponseAudioTranscriptDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  "SessionUpdateResponseAudioTranscriptDone",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDelta,
  "SessionUpdateResponseAudioTimestampDelta",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDone,
  "SessionUpdateResponseAudioTimestampDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseTextDelta,
  "SessionUpdateResponseTextDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseTextDone,
  "SessionUpdateResponseTextDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseContentPartAdded,
  "SessionUpdateResponseContentPartAdded",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseContentPartDone,
  "SessionUpdateResponseContentPartDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseOutputItemAdded,
  "SessionUpdateResponseOutputItemAdded",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseOutputItemDone,
  "SessionUpdateResponseOutputItemDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  "SessionUpdateResponseFunctionCallArgumentsDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  "SessionUpdateResponseFunctionCallArgumentsDone",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationBlendshapeDelta,
  "SessionUpdateResponseAnimationBlendshapeDelta",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationBlendshapeDone,
  "SessionUpdateResponseAnimationBlendshapeDone",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationVisemeDelta,
  "SessionUpdateResponseAnimationVisemeDelta",
  "csharp"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationVisemeDone,
  "SessionUpdateResponseAnimationVisemeDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemCreated,
  "SessionUpdateConversationItemCreated",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemDeleted,
  "SessionUpdateConversationItemDeleted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemRetrieved,
  "SessionUpdateConversationItemRetrieved",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  "SessionUpdateConversationItemTruncated",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  "SessionUpdateConversationItemInputAudioTranscriptionCompleted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  "SessionUpdateConversationItemInputAudioTranscriptionDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  "SessionUpdateConversationItemInputAudioTranscriptionFailed",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventRealtimeServerEventError,
  "SessionUpdateError",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventErrorError,
  "SessionUpdateErrorDetails",
  "csharp"
);
@@clientName(OpenAI.RealtimeResponseUsage, "ResponseTokenStatistics", "csharp");
@@clientName(VoiceLive.RequestSession, "VoiceLiveSessionOptions", "csharp");
@@clientName(VoiceLive.ResponseSession, "VoiceLiveSessionResponse", "csharp");
@@clientName(VoiceLive.AvatarConfig, "AvatarConfiguration", "csharp");
@@clientName(VoiceLive.AvatarConfig.type, "AvatarKind", "csharp");
@@clientName(VoiceLive.AvatarConfig.`model`, "BaseMode", "csharp");
@@clientName(
  VoiceLive.AvatarConfig.output_audit_audio,
  "AuditOutputAudio",
  "csharp"
);
@@clientName(VoiceLive.PhotoAvatarBaseModes, "PhotoAvatarBaseMode", "csharp");
@@clientName(
  VoiceLive.AzureAvatarVoiceSyncVoice,
  "AzureAvatarSyncVoice",
  "csharp"
);
@@clientName(
  VoiceLive.AzureAvatarVoiceSyncVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "csharp"
);
@@clientName(
  VoiceLive.AzureAvatarVoiceSyncVoice.custom_text_normalization_url,
  "CustomTextNormalizationUri",
  "csharp"
);
@@clientName(
  VoiceLive.AzureCustomVoice.custom_text_normalization_url,
  "CustomTextNormalizationUri",
  "csharp"
);
@@clientName(
  VoiceLive.AzurePersonalVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "csharp"
);
@@clientName(
  VoiceLive.AzurePersonalVoice.custom_text_normalization_url,
  "CustomTextNormalizationUri",
  "csharp"
);
@@clientName(
  VoiceLive.AzureStandardVoice.custom_text_normalization_url,
  "CustomTextNormalizationUri",
  "csharp"
);
@@clientName(VoiceLive.AvatarConfigTypes, "AvatarConfigKind", "csharp");
@@clientName(
  VoiceLive.PersonalVoiceModels.`MAI-Voice-1`,
  "MaiVoice1",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted.logprobs,
  "LogProbs",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetection.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "TimeoutMs",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeTurnDetectionServerVad,
  "ServerVadTurnDetection",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticVad,
  "AzureSemanticVadTurnDetection",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticVadEn,
  "AzureSemanticVadTurnDetectionEn",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticVadMultilingual,
  "AzureSemanticVadTurnDetectionMultilingual",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetection,
  "AzureSemanticEouDetection",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionEn,
  "AzureSemanticEouDetectionEn",
  "csharp"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionMultilingual,
  "AzureSemanticEouDetectionMultilingual",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventMCPListToolsInProgress,
  "SessionUpdateMcpListToolsInProgress",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventMCPListToolsCompleted,
  "SessionUpdateMcpListToolsCompleted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventMCPListToolsFailed,
  "SessionUpdateMcpListToolsFailed",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta,
  "SessionUpdateResponseMcpCallArgumentsDelta",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone,
  "SessionUpdateResponseMcpCallArgumentsDone",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseMCPCallInProgress,
  "SessionUpdateResponseMcpCallInProgress",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseMCPCallCompleted,
  "SessionUpdateResponseMcpCallCompleted",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseMCPCallFailed,
  "SessionUpdateResponseMcpCallFailed",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeMCPListTools,
  "SessionResponseMcpListToolItem",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeMCPToolCall,
  "SessionResponseMcpCallItem",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeMCPApprovalRequest,
  "SessionResponseMcpApprovalRequestItem",
  "csharp"
);
@@clientName(
  OpenAI.RealtimeMCPApprovalResponse,
  "SessionResponseMcpApprovalResponseItem",
  "csharp"
);
@@clientName(OpenAI.MCPListToolsTool, "VoiceLiveMcpTool", "csharp");
@@clientName(VoiceLive.Background, "VideoBackground", "csharp");
@@alternateType(
  VoiceLive.AzureAvatarVoiceSyncVoice.custom_lexicon_url,
  url,
  "csharp"
);
@@alternateType(
  VoiceLive.AzureAvatarVoiceSyncVoice.custom_text_normalization_url,
  url,
  "csharp"
);
@@alternateType(VoiceLive.AzureCustomVoice.custom_lexicon_url, url, "csharp");
@@alternateType(
  VoiceLive.AzureCustomVoice.custom_text_normalization_url,
  url,
  "csharp"
);
@@alternateType(VoiceLive.AzurePersonalVoice.custom_lexicon_url, url, "csharp");
@@alternateType(
  VoiceLive.AzurePersonalVoice.custom_text_normalization_url,
  url,
  "csharp"
);
@@alternateType(
  VoiceLive.AzureStandardVoice.custom_text_normalization_url,
  url,
  "csharp"
);
@@alternateType(VoiceLive.AudioInputConfig.turn_detection, unknown, "csharp");

@@access(OpenAI.RealtimeClientEventSessionUpdate, Access.public, "java");
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferAppend,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferCommit,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeClientEventInputAudioBufferClear,
  Access.public,
  "java"
);
@@access(VoiceLive.ClientEventInputAudioTurnStart, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnAppend, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnEnd, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioTurnCancel, Access.public, "java");
@@access(VoiceLive.ClientEventInputAudioClear, Access.public, "java");
@@access(
  OpenAI.RealtimeClientEventConversationItemCreate,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemRetrieve,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemTruncate,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeClientEventConversationItemDelete,
  Access.public,
  "java"
);
@@access(OpenAI.RealtimeClientEventResponseCreate, Access.public, "java");
@@access(OpenAI.RealtimeClientEventResponseCancel, Access.public, "java");
@@access(VoiceLive.ClientEventSessionAvatarConnect, Access.public, "java");

@@access(VoiceLive.ServerEventSessionAvatarConnecting, Access.public, "java");
@@access(OpenAI.RealtimeServerEventSessionCreated, Access.public, "java");
@@access(OpenAI.RealtimeServerEventResponseAudioDelta, Access.public, "java");
@@access(VoiceLive.ResponseItem, Access.public, "java");
@@access(VoiceLive.Response, Access.public, "java");
@@access(
  OpenAI.RealtimeServerEventConversationItemCreated,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemDeleted,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemRetrieved,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventRealtimeServerEventError,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferCleared,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  Access.public,
  "java"
);
@@access(OpenAI.RealtimeServerEventResponseAudioDone, Access.public, "java");
@@access(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseContentPartAdded,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseContentPartDone,
  Access.public,
  "java"
);
@@access(OpenAI.RealtimeServerEventResponseCreated, Access.public, "java");
@@access(OpenAI.RealtimeServerEventResponseDone, Access.public, "java");
@@access(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseOutputItemAdded,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventResponseOutputItemDone,
  Access.public,
  "java"
);
@@access(OpenAI.RealtimeServerEventResponseTextDelta, Access.public, "java");
@@access(OpenAI.RealtimeServerEventResponseTextDone, Access.public, "java");
@@access(OpenAI.RealtimeServerEventSessionUpdated, Access.public, "java");

@@access(VoiceLive.ClientEventRtcCallSdpCreate, Access.public, "java");
@@access(VoiceLive.ServerEventRtcCallSdpCreated, Access.public, "java");
@@access(VoiceLive.ServerEventRtcCallError, Access.public, "java");
@@access(VoiceLive.RtcCallErrorDetails, Access.public, "java");
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStarted,
  Access.public,
  "java"
);
@@access(
  OpenAI.RealtimeServerEventOutputAudioBufferStopped,
  Access.public,
  "java"
);

@@access(VoiceLive.Voice, Access.public, "java");

@@clientName(VoiceLive.OAIVoice, "OpenAIVoiceName", "java");

@@clientName(VoiceLive.ClientEvent, "SessionClientEvent", "java");
@@clientName(VoiceLive.Animation, "AnimationOptions", "java");
@@clientName(VoiceLive.Animation.outputs, "outputTypes", "java");
@@clientName(VoiceLive.LogProbProperties.logprob, "logProb", "java");
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted.logprobs,
  "logProbs",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta.logprobs,
  "logProbs",
  "java"
);
@@clientName(VoiceLive.RequestSession.animation, "animationOptions", "java");
@@clientName(VoiceLive.ResponseSession.animation, "animationOptions", "java");
@@clientName(
  VoiceLive.AzureCustomVoice.custom_lexicon_url,
  "CustomLexiconUri",
  "java"
);
@@clientName(VoiceLive.VideoCrop.bottom_right, "BottomRightInternal", "java");
@@clientName(VoiceLive.VideoCrop.top_left, "TopLeftInternal", "java");
@@clientName(VoiceLive.Response, "SessionResponse", "java");
@@clientName(VoiceLive.AgentConfig, "RespondingAgentOptions", "java");
@@clientName(VoiceLive.ResponseItem, "SessionResponseItem", "java");
@@clientName(VoiceLive.ServerEvent, "SessionServerEvent", "java");
@@clientName(
  OpenAI.RealtimeServerEventSessionCreated,
  "SessionUpdateSessionCreated",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventSessionUpdated,
  "SessionUpdateSessionUpdated",
  "java"
);
@@clientName(
  VoiceLive.ServerEventSessionAvatarConnecting,
  "SessionUpdateAvatarConnecting",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  "SessionUpdateInputAudioBufferSpeechStarted",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  "SessionUpdateInputAudioBufferSpeechStopped",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferCleared,
  "SessionUpdateInputAudioBufferCleared",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  "SessionUpdateInputAudioBufferCommitted",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseCreated,
  "SessionUpdateResponseCreated",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseDone,
  "SessionUpdateResponseDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioDelta,
  "SessionUpdateResponseAudioDelta",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioDone,
  "SessionUpdateResponseAudioDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  "SessionUpdateResponseAudioTranscriptDelta",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  "SessionUpdateResponseAudioTranscriptDone",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDelta,
  "SessionUpdateResponseAudioTimestampDelta",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDone,
  "SessionUpdateResponseAudioTimestampDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseTextDelta,
  "SessionUpdateResponseTextDelta",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseTextDone,
  "SessionUpdateResponseTextDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseContentPartAdded,
  "SessionUpdateResponseContentPartAdded",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseContentPartDone,
  "SessionUpdateResponseContentPartDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseOutputItemAdded,
  "SessionUpdateResponseOutputItemAdded",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseOutputItemDone,
  "SessionUpdateResponseOutputItemDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  "SessionUpdateResponseFunctionCallArgumentsDelta",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  "SessionUpdateResponseFunctionCallArgumentsDone",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationBlendshapeDelta,
  "SessionUpdateResponseAnimationBlendshapeDelta",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationBlendshapeDone,
  "SessionUpdateResponseAnimationBlendshapeDone",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationVisemeDelta,
  "SessionUpdateResponseAnimationVisemeDelta",
  "java"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationVisemeDone,
  "SessionUpdateResponseAnimationVisemeDone",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemCreated,
  "SessionUpdateConversationItemCreated",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemDeleted,
  "SessionUpdateConversationItemDeleted",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemRetrieved,
  "SessionUpdateConversationItemRetrieved",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  "SessionUpdateConversationItemTruncated",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  "SessionUpdateConversationItemInputAudioTranscriptionCompleted",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  "SessionUpdateConversationItemInputAudioTranscriptionDelta",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  "SessionUpdateConversationItemInputAudioTranscriptionFailed",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventRealtimeServerEventError,
  "SessionUpdateError",
  "java"
);
@@clientName(
  OpenAI.RealtimeServerEventErrorError,
  "SessionUpdateErrorDetails",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetailsCachedTokensDetails.text_tokens,
  "textTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetailsCachedTokensDetails.audio_tokens,
  "audioTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetailsCachedTokensDetails.image_tokens,
  "imageTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetails.cached_tokens,
  "cachedTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetails.text_tokens,
  "textTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetails.audio_tokens,
  "audioTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageInputTokenDetails.image_tokens,
  "imageTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageOutputTokenDetails.text_tokens,
  "textTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsageOutputTokenDetails.audio_tokens,
  "audioTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsage.total_tokens,
  "totalTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsage.input_tokens,
  "inputTokenCount",
  "java"
);
@@clientName(
  OpenAI.RealtimeResponseUsage.output_tokens,
  "outputTokenCount",
  "java"
);
@@clientName(OpenAI.RealtimeResponseUsage, "ResponseTokenStatistics", "java");
@@clientName(VoiceLive.RequestSession, "VoiceLiveSessionOptions", "java");
@@clientName(VoiceLive.ResponseSession, "VoiceLiveSessionResponse", "java");
@@clientName(VoiceLive.AvatarConfig, "AvatarOptions", "java");
@@clientName(VoiceLive.RequestSession.avatar, "avatarOptions", "java");
@@clientName(VoiceLive.ResponseSession.avatar, "avatarOptions", "java");
@@clientName(VoiceLive.AzureSemanticDetection.timeout_ms, "TimeoutMs", "java");
@@clientName(
  VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "TimeoutMs",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "TimeoutMs",
  "java"
);
@@clientName(
  OpenAI.RealtimeTurnDetectionServerVad,
  "ServerVadTurnDetection",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticVad,
  "AzureSemanticVadTurnDetection",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticVadEn,
  "AzureSemanticVadTurnDetectionEn",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticVadMultilingual,
  "AzureSemanticVadTurnDetectionMultilingual",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticDetection,
  "AzureSemanticEouDetection",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionEn,
  "AzureSemanticEouDetectionEn",
  "java"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionMultilingual,
  "AzureSemanticEouDetectionMultilingual",
  "java"
);
@@clientName(VoiceLive.Background, "VideoBackground", "java");
@@clientName(OpenAI.MCPListToolsTool, "McpTool", "java");
@@clientName(OpenAI.RealtimeMCPListTools, "ResponseMcpListToolItem", "java");
@@clientName(OpenAI.RealtimeMCPToolCall, "ResponseMcpCallItem", "java");
@@clientName(
  OpenAI.RealtimeMCPApprovalRequest,
  "ResponseMcpApprovalRequestItem",
  "java"
);
@@clientName(
  OpenAI.RealtimeMCPApprovalResponse,
  "ResponseMcpApprovalResponseItem",
  "java"
);

@@clientName(
  VoiceLive.AzureSemanticDetection.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(
  OpenAI.RealtimeClientEventConversationItemTruncate.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(
  OpenAI.RealtimeServerEventConversationItemTruncated.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped.audio_end_ms,
  "audioEndInMs",
  "javascript"
);
@@clientName(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted.audio_start_ms,
  "audioStartInMs",
  "javascript"
);
@@clientName(
  VoiceLive.ServerEventResponseAnimationVisemeDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
@@clientName(
  VoiceLive.ServerEventResponseAudioTimestampDelta.audio_duration_ms,
  "audioDurationInMs",
  "javascript"
);

@@clientName(
  VoiceLive.AzureSemanticDetection.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionEn.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticDetectionMultilingual.timeout_ms,
  "timeoutInMs",
  "javascript"
);

@@clientName(
  OpenAI.RealtimeTurnDetectionServerVad.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  OpenAI.RealtimeTurnDetectionServerVad.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);

@@clientName(
  VoiceLive.AzureSemanticVad.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVad.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVad.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(
  VoiceLive.AzureSemanticVadEn.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVadEn.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVadEn.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(
  VoiceLive.AzureSemanticVadMultilingual.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVadMultilingual.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceLive.AzureSemanticVadMultilingual.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);

@@clientName(
  VoiceLive.InterimResponseConfigBase.latency_threshold_ms,
  "latencyThresholdInMs",
  "javascript"
);

@@clientName(
  VoiceLive.TranscriptionWord.offset_milliseconds,
  "offsetInMs",
  "javascript"
);
@@clientName(
  VoiceLive.TranscriptionWord.duration_milliseconds,
  "durationInMs",
  "javascript"
);
@@clientName(
  VoiceLive.TranscriptionPhrase.offset_milliseconds,
  "offsetInMs",
  "javascript"
);
@@clientName(
  VoiceLive.TranscriptionPhrase.duration_milliseconds,
  "durationInMs",
  "javascript"
);
@@clientName(VoiceLive.Response, "VoiceLiveResponse", "javascript");

// Explicit client declaration for emitters that require at least one client (e.g. Python).
// This service is WebSocket-only and has no HTTP operations, so a client must be declared explicitly.
// Marked internal so it is not part of the public Python API surface; a hand-written client wraps it.
@access(Access.internal, "python")
@client(
  {
    name: "VoiceLiveClient",
    service: VoiceLive,
  },
  "python"
)
namespace VoiceLiveClient {

}

// -----------------------------------------------------------------------
// Foundry pattern: hide OpenAI Responses-API tool models that are pulled in
// transitively via `OpenAI.MCPTool extends OpenAI.Tool` but are NOT supported
// by the Realtime/VoiceLive surface (computer / web-search / file-search /
// image-gen / code-interpreter / shell / skill / container tools + their
// params & filters). Marked internal so they don't appear in generated SDKs.
// (VoiceLive only supports `function` and `mcp` tools.)
// -----------------------------------------------------------------------
@@access(OpenAI.ApplyPatchToolParam, Access.internal);
@@access(OpenAI.ApproximateLocation, Access.internal);
@@access(OpenAI.AutoCodeInterpreterToolParam, Access.internal);
@@access(OpenAI.CodeInterpreterTool, Access.internal);
@@access(OpenAI.ComparisonFilter, Access.internal);
@@access(OpenAI.CompoundFilter, Access.internal);
@@access(OpenAI.ComputerEnvironment, Access.internal);
@@access(OpenAI.ComputerTool, Access.internal);
@@access(OpenAI.ComputerUsePreviewTool, Access.internal);
@@access(OpenAI.ContainerAutoParam, Access.internal);
@@access(OpenAI.ContainerMemoryLimit, Access.internal);
@@access(OpenAI.ContainerNetworkPolicyAllowlistParam, Access.internal);
@@access(OpenAI.ContainerNetworkPolicyDisabledParam, Access.internal);
@@access(OpenAI.ContainerNetworkPolicyParam, Access.internal);
@@access(OpenAI.ContainerSkill, Access.internal);
@@access(OpenAI.CustomGrammarFormatParam, Access.internal);
@@access(OpenAI.CustomTextFormatParam, Access.internal);
@@access(OpenAI.CustomToolParam, Access.internal);
@@access(OpenAI.CustomToolParamFormat, Access.internal);
@@access(OpenAI.EmptyModelParam, Access.internal);
@@access(OpenAI.FileInputDetail, Access.internal);
@@access(OpenAI.FileSearchTool, Access.internal);
@@access(OpenAI.Filters, Access.internal);
@@access(OpenAI.FunctionShellToolParam, Access.internal);
@@access(OpenAI.FunctionShellToolParamEnvironment, Access.internal);
@@access(
  OpenAI.FunctionShellToolParamEnvironmentContainerReferenceParam,
  Access.internal
);
@@access(
  OpenAI.FunctionShellToolParamEnvironmentLocalEnvironmentParam,
  Access.internal
);
@@access(OpenAI.FunctionTool, Access.internal);
@@access(OpenAI.FunctionToolParam, Access.internal);
@@access(OpenAI.HybridSearchOptions, Access.internal);
@@access(OpenAI.ImageDetail, Access.internal);
@@access(OpenAI.ImageGenTool, Access.internal);
@@access(OpenAI.ImageGenToolInputImageMask, Access.internal);
@@access(OpenAI.InlineSkillParam, Access.internal);
@@access(OpenAI.InlineSkillSourceParam, Access.internal);
@@access(OpenAI.InputFidelity, Access.internal);
@@access(OpenAI.InputFileContent, Access.internal);
@@access(OpenAI.InputImageContent, Access.internal);
@@access(OpenAI.InputTextContent, Access.internal);
@@access(OpenAI.LocalShellToolParam, Access.internal);
@@access(OpenAI.LocalSkillParam, Access.internal);
@@access(OpenAI.Metadata, Access.internal);
@@access(OpenAI.NamespaceToolParam, Access.internal);
@@access(OpenAI.Prompt, Access.internal);
@@access(OpenAI.RankingOptions, Access.internal);
@@access(OpenAI.ResponsePromptVariables, Access.internal);
@@access(OpenAI.SkillReferenceParam, Access.internal);
@@access(OpenAI.SpecificApplyPatchParam, Access.internal);
@@access(OpenAI.SpecificFunctionShellParam, Access.internal);
@@access(OpenAI.ToolChoiceAllowed, Access.internal);
@@access(OpenAI.ToolChoiceCodeInterpreter, Access.internal);
@@access(OpenAI.ToolChoiceComputer, Access.internal);
@@access(OpenAI.ToolChoiceComputerUse, Access.internal);
@@access(OpenAI.ToolChoiceComputerUsePreview, Access.internal);
@@access(OpenAI.ToolChoiceCustom, Access.internal);
@@access(OpenAI.ToolChoiceFileSearch, Access.internal);
@@access(OpenAI.ToolChoiceImageGeneration, Access.internal);
@@access(OpenAI.ToolChoiceWebSearchPreview, Access.internal);
@@access(OpenAI.ToolChoiceWebSearchPreview20250311, Access.internal);
@@access(OpenAI.ToolSearchToolParam, Access.internal);
@@access(OpenAI.WebSearchApproximateLocation, Access.internal);
@@access(OpenAI.WebSearchPreviewTool, Access.internal);
@@access(OpenAI.WebSearchTool, Access.internal);
@@access(OpenAI.WebSearchToolFilters, Access.internal);
