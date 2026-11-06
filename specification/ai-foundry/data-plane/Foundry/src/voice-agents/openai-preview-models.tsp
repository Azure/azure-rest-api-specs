import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/live";
import "@azure-tools/openai-typespec/models/realtime";
import "./agents.tsp";

using TypeSpec.OpenAPI;
using Azure.AI.Projects;

// The OpenAI models below are exposed by the preview voice-agent surface, but
// their upstream definitions cannot carry Foundry-specific preview metadata.

// Audio transcription models used by realtime events.
@@extension(
  OpenAI.AudioTranscription,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.CreateTranscriptionResponseJsonUsage,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.CreateTranscriptionResponseJsonUsageType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.TranscriptTextUsageDuration,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.TranscriptTextUsageTokens,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.TranscriptTextUsageTokensInputTokenDetails,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.TranscriptionLanguage,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// MCP tool descriptions exposed by realtime MCP events.
@@extension(
  OpenAI.MCPListToolsTool,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.MCPListToolsToolAnnotations,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.MCPListToolsToolInputSchema,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime audio formats.
@@extension(
  OpenAI.RealtimeAudioFormats,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeAudioFormatsAudioPcm,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeAudioFormatsAudioPcma,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeAudioFormatsAudioPcmu,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeAudioFormatsType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime client events.
@@extension(
  OpenAI.RealtimeClientEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventConversationItemCreate,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventConversationItemDelete,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventConversationItemRetrieve,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventConversationItemTruncate,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventInputAudioBufferAppend,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventInputAudioBufferClear,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventInputAudioBufferCommit,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventOutputAudioBufferClear,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventResponseCancel,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventResponseCreate,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventSessionUpdate,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeClientEventType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime conversation-item supporting types.
@@extension(
  OpenAI.RealtimeConversationItemMessageType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeConversationItemType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime MCP errors.
@@extension(
  OpenAI.RealtimeMCPError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeMcpErrorType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeMCPHTTPError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeMCPProtocolError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeMCPToolExecutionError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime server events.
@@extension(
  OpenAI.RealtimeServerEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemAdded,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemDeleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionSegment,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemRetrieved,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventConversationItemTruncated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventRealtimeServerEventError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferCleared,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferCommitted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferDtmfEventReceived,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventInputAudioBufferTimeoutTriggered,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventMCPListToolsCompleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventMCPListToolsFailed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventMCPListToolsInProgress,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventOutputAudioBufferCleared,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventOutputAudioBufferStarted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventOutputAudioBufferStopped,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventRateLimitsUpdated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseAudioDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseAudioDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseAudioTranscriptDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseContentPartAdded,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseContentPartDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseContentPartDonePart,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseMCPCallCompleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseMCPCallFailed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseMCPCallInProgress,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseOutputItemAdded,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseOutputItemDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseTextDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventResponseTextDone,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventSessionCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventSessionUpdated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeServerEventType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Realtime session and turn-detection models.
@@extension(
  OpenAI.RealtimeSessionCreateRequestGA,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestGAAudio,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestGAAudioInput,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestGAAudioOutput,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestGATracing,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestUnion,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeSessionCreateRequestUnionType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTranscriptionSessionCreateRequestGA,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTranscriptionSessionCreateRequestGAAudio,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTranscriptionSessionCreateRequestGAAudioInput,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTurnDetection,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTurnDetectionSemanticVad,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTurnDetectionServerVad,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.RealtimeTurnDetectionType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Shared voice identifier used by realtime audio output.
@@extension(
  OpenAI.VoiceIdsShared,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Native Live types used by the preview voice-agent surface.
@@extension(
  OpenAI.DelegationType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveAllowedServerEventParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveAudioFormat,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveAudioFormatType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientConfigParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientDelegationParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveCommentaryAppendParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveInputAudioAppendEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveInputAudioMuteParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveInputAudioUnmuteParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveInstructionsAppendParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveResponseCreateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveResponseItemCreateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveSessionCloseParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveSessionUpdateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveThinkingAppendParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveContextWindowUsage,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveCustomVoiceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDataChannelConfigParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDelegationReasoningInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDelegationTextInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveFunctionToolChoiceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveFunctionToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialAssistantMessageItemParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialDeveloperMessageItemParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialInputTextContentPartParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialItem,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialItemType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialMessageStatus,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialOutputTextContentPartParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialSessionAudioOutputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialSessionAudioParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialTextContentPartParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInitialUserMessageItemParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInputAudioAppend,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveLiveError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveMCPToolChoiceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveOutputAudioDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveReasoningEffort,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveReasoningSummary,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveResponsesDelegationParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveResponsesDelegationSettingsInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveResponsesDelegationUpdateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveResponsesServiceTier,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveCommentaryAppended,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveDelegationCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveErrorEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveInfoEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveInputAudioMuted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveInputAudioUnmuted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveInputTranscriptDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveInstructionsAppended,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveOutputTranscriptDelta,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveResponseEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveSessionClosed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveSessionStarted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveSessionUpdated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveSessionUsageUpdated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveThinkingAppended,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionAudioFormatPCMAParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionAudioFormatPCMParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionAudioFormatPCMUParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionCreateParams,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionStartEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionUpdateParams,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSessionUsage,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveTextVerbosity,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveToolChoiceEnum,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveTransportCallError,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveTransportDTMFReceived,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveTransportDTMFSendParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveWebSearchToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.ModelIdsLive,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(OpenAI.Delegation, "x-ms-foundry-meta", VoiceAgentRequiredPreview);
@@extension(
  OpenAI.LiveDecisionQuestionsInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionTriggerInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionsDelegationParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionsSettingsInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveAllowedToolsChoiceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveApplyPatchToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveDecisionCreateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveDecisionItemCreateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveDecisionItemDeleteParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveClientEventLiveOutputAudioFixturePlayParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveCodeInterpreterToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveComputerToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveContainerMemoryLimit,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveContainerNetworkPolicyDisabledParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveContainerReferenceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveCustomToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionCompleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionInputImageParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionInputItemParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionInputTextParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionStoredInputItemParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionsDelegationUpdateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDecisionsSettingsUpdateParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveDetailEnum,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveFileSearchToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveHostedShellContainerAutoParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveHostedShellNetworkPolicyAllowlistParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveHostedShellToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveImageGenerationToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInlineSkillParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveInlineSkillSourceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveLocalEnvironmentParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveLocalSkillParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveMCPToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveNamespaceToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveProgrammaticToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveDecisionEvent,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveDecisionItemCreated,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveDecisionItemDeleted,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveOutputAudioFixturePlayed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveOutputAudioFixturePlaying,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveTransportAnswered,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveTransportFailed,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveServerEventLiveTransportRinging,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSkillReferenceParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificApplyPatchParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificCodeInterpreterParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificComputerParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificCustomToolParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificFileSearchParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificFunctionShellParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificImageGenParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificProgrammaticToolCallingParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificWebSearchParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveSpecificWebSearchPreviewParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveToolChoiceValueEnum,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.LiveToolSearchToolInputParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Decisions question models reached through LiveDecisionQuestionsInputParam-2.
@@extension(
  OpenAI.ChoiceOptionParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.ChoiceValueParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.QuestionParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.QuestionParamChoice,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.QuestionParamPredicate,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.QuestionParamScore,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.QuestionParamType,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);
@@extension(
  OpenAI.ScoreLevelParam,
  "x-ms-foundry-meta",
  VoiceAgentRequiredPreview
);

// Describe imported Live, Decisions, and Realtime fields exposed by Foundry.
@@doc(
  OpenAI.AnswerResource.type,
  "The kind of answer returned for a Decision question."
);
@@doc(OpenAI.AnswerResourceChoice.choice, "The selected choice value.");
@@doc(
  OpenAI.AnswerResourceChoice.confidence,
  "The confidence in the selected choice."
);
@@doc(
  OpenAI.AnswerResourceChoice.name,
  "The name of the corresponding question, or null when the question has no name."
);
@@doc(
  OpenAI.AnswerResourceChoice.probabilities,
  "The predicted probability for each available choice."
);
@@doc(
  OpenAI.AnswerResourcePredicate.name,
  "The name of the corresponding question, or null when the question has no name."
);
@@doc(
  OpenAI.AnswerResourcePredicate.probability,
  "The predicted probability that the predicate is true."
);
@@doc(
  OpenAI.AnswerResourceRefusal.name,
  "The name of the corresponding question, or null when the question has no name."
);
@@doc(
  OpenAI.AnswerResourceScore.confidence,
  "The confidence in the assigned score."
);
@@doc(
  OpenAI.AnswerResourceScore.name,
  "The name of the corresponding question, or null when the question has no name."
);
@@doc(
  OpenAI.AnswerResourceScore.probabilities,
  "The predicted probability for each scoring level."
);
@@doc(
  OpenAI.AnswerResourceScore.score,
  "The numeric score assigned to the answer."
);
@@doc(
  OpenAI.ChoiceProbabilityResource.probability,
  "The predicted probability of this choice."
);
@@doc(
  OpenAI.ChoiceProbabilityResource.value,
  "The choice value associated with this probability."
);
@@doc(
  OpenAI.InputTokensDetailsResource.cache_write_tokens,
  "The number of input tokens written to the prompt cache."
);
@@doc(
  OpenAI.InputTokensDetailsResource.cached_tokens,
  "The number of input tokens read from the prompt cache."
);
@@doc(
  OpenAI.LiveAllowedToolsChoiceParam.mode,
  "Whether the model may choose a tool automatically, must call a tool, or must not call a tool from the allowed set."
);
@@doc(
  OpenAI.LiveApplyPatchToolInputParam.type,
  "The tool type. Always `apply_patch`."
);
@@doc(OpenAI.LiveAudioFormat.type, "The encoding used for Live session audio.");
@@doc(
  OpenAI.LiveClientEvent.type,
  "The kind of Live event sent by the client."
);
@@doc(
  OpenAI.LiveClientEventLiveCommentaryAppendParam.delegation_id,
  "The ID of the delegation associated with this content, or null when the content is not associated with a delegation."
);
@@doc(
  OpenAI.LiveClientEventLiveCommentaryAppendParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionCreateParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionCreateParam.type,
  "The event type. Always `decision.create`."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemCreateParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemCreateParam.item,
  "The input item to append to the session's shared Decision context."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemCreateParam.type,
  "The event type. Always `decision.item.create`."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemDeleteParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemDeleteParam.item_id,
  "The ID of the item to remove from the session's shared Decision context."
);
@@doc(
  OpenAI.LiveClientEventLiveDecisionItemDeleteParam.type,
  "The event type. Always `decision.item.delete`."
);
@@doc(
  OpenAI.LiveClientEventLiveInputAudioAppendEvent.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveInputAudioMuteParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveInputAudioUnmuteParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveInstructionsAppendParam.delegation_id,
  "The ID of the delegation associated with this content, or null when the content is not associated with a delegation."
);
@@doc(
  OpenAI.LiveClientEventLiveInstructionsAppendParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveOutputAudioFixturePlayParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveOutputAudioFixturePlayParam.type,
  "The event type. Always `session.output_audio.fixture.play`."
);
@@doc(
  OpenAI.LiveClientEventLiveResponseCreateParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveResponseItemCreateParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveSessionCloseParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveSessionUpdateParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveClientEventLiveThinkingAppendParam.delegation_id,
  "The ID of the delegation associated with this content, or null when the content is not associated with a delegation."
);
@@doc(
  OpenAI.LiveClientEventLiveThinkingAppendParam.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveCodeInterpreterToolInputParam.type,
  "The tool type. Always `code_interpreter`."
);
@@doc(
  OpenAI.LiveComputerToolInputParam.type,
  "The tool type. Always `computer`."
);
@@doc(OpenAI.LiveCustomToolInputParam.type, "The tool type. Always `custom`.");
@@doc(
  OpenAI.LiveCustomVoiceParam.id,
  "The identifier of the custom voice to use for generated audio."
);
@@doc(
  OpenAI.LiveDecisionChoiceParam.description,
  "A description that helps the model distinguish this choice from the other choices."
);
@@doc(
  OpenAI.LiveDecisionChoiceParam.value,
  "The string or boolean value returned when this choice is selected."
);
@@doc(
  OpenAI.LiveDecisionChoiceQuestionParam.choices,
  "The possible answers from which the model selects a choice."
);
@@doc(
  OpenAI.LiveDecisionChoiceQuestionParam.instructions,
  "Instructions for evaluating the question, supplied as text or as text, image, and JSON content parts."
);
@@doc(
  OpenAI.LiveDecisionChoiceQuestionParam.name,
  "An optional question name used to identify its answer in the Decision response."
);
@@doc(
  OpenAI.LiveDecisionChoiceQuestionParam.type,
  "The question type. Always `choice`."
);
@@doc(
  OpenAI.LiveDecisionCompleted.type,
  "The event type. Always `decision.completed`."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallOutputParam.id,
  "An optional identifier for this custom-tool output item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallOutputParam.output,
  "The tool result, supplied as a string or as text and image content parts."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallOutputParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallOutputParam.type,
  "The item type. Always `custom_tool_call_output`."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallParam.id,
  "An optional identifier for this custom-tool item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallParam.`namespace`,
  "The namespace that contains the called tool, when applicable."
);
@@doc(
  OpenAI.LiveDecisionCustomToolCallParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallOutputParam.id,
  "An optional identifier for this function-call output item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallOutputParam.output,
  "The tool result, supplied as a string or as text and image content parts."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallOutputParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallParam.id,
  "An optional identifier for this function-call item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallParam.name,
  "The name of the function being called."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallParam.`namespace`,
  "The namespace that contains the called tool, when applicable."
);
@@doc(
  OpenAI.LiveDecisionFunctionCallParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionInputImageParam.detail,
  "The level of image detail used when processing the image."
);
@@doc(
  OpenAI.LiveDecisionInputImageParam.type,
  "The item type. Always `input_image`."
);
@@doc(
  OpenAI.LiveDecisionInputItemParam.type,
  "The kind of input item supplied to the Decision context."
);
@@doc(
  OpenAI.LiveDecisionInputItemParamMessage.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.LiveDecisionInputJsonParam.data,
  "The JSON object or array of JSON objects supplied as Decision input."
);
@@doc(
  OpenAI.LiveDecisionInputJsonParam.type,
  "The item type. Always `input_json`."
);
@@doc(
  OpenAI.LiveDecisionInputTextParam.type,
  "The item type. Always `input_text`."
);
@@doc(
  OpenAI.LiveDecisionPredicateQuestionParam.instructions,
  "Instructions for evaluating the question, supplied as text or as text, image, and JSON content parts."
);
@@doc(
  OpenAI.LiveDecisionPredicateQuestionParam.name,
  "An optional question name used to identify its answer in the Decision response."
);
@@doc(
  OpenAI.LiveDecisionPredicateQuestionParam.type,
  "The question type. Always `predicate`."
);
@@doc(
  OpenAI.LiveDecisionQuestion.type,
  "The kind of question evaluated by the Decision model."
);
@@doc(
  OpenAI.LiveDecisionScoreLevelParam.description,
  "A description of the criteria for assigning this scoring level."
);
@@doc(
  OpenAI.LiveDecisionScoreLevelParam.label,
  "The label identifying this scoring level."
);
@@doc(
  OpenAI.LiveDecisionScoreQuestionParam.instructions,
  "Instructions for evaluating the question, supplied as text or as text, image, and JSON content parts."
);
@@doc(
  OpenAI.LiveDecisionScoreQuestionParam.levels,
  "The scoring levels against which the model evaluates the question."
);
@@doc(
  OpenAI.LiveDecisionScoreQuestionParam.name,
  "An optional question name used to identify its answer in the Decision response."
);
@@doc(
  OpenAI.LiveDecisionScoreQuestionParam.type,
  "The question type. Always `score`."
);
@@doc(
  OpenAI.LiveDecisionsDelegationUpdateParam.decisions,
  "Updates to the Decision model and questions used for subsequent delegations. Omit to keep the current settings."
);
@@doc(
  OpenAI.LiveDecisionsDelegationUpdateParam.type,
  "The delegation type. Always `decisions`."
);
@@doc(
  OpenAI.LiveDecisionsSettingsInputParam.`model`,
  "The model used to evaluate the Decision questions."
);
@@doc(
  OpenAI.LiveDecisionsSettingsUpdateParam.`model`,
  "The model to use for subsequent Decision evaluations. Omit to keep the current model."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallOutputParam.id,
  "The identifier for this custom-tool output item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallOutputParam.output,
  "The tool result, supplied as a string or as text and image content parts."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallOutputParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallOutputParam.type,
  "The item type. Always `custom_tool_call_output`."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallParam.id,
  "The identifier for this custom-tool item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallParam.`namespace`,
  "The namespace that contains the called tool, when applicable."
);
@@doc(
  OpenAI.LiveDecisionStoredCustomToolCallParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallOutputParam.id,
  "The identifier for this function-call output item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallOutputParam.output,
  "The tool result, supplied as a string or as text and image content parts."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallOutputParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallParam.id,
  "The identifier for this function-call item in the Decision context."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallParam.name,
  "The name of the function being called."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallParam.`namespace`,
  "The namespace that contains the called tool, when applicable."
);
@@doc(
  OpenAI.LiveDecisionStoredFunctionCallParam.status,
  "The completion status of this tool-call item."
);
@@doc(
  OpenAI.LiveDecisionStoredInputItemParam.type,
  "The kind of item stored in the session's shared Decision context."
);
@@doc(
  OpenAI.LiveDecisionStoredInputItemParamMessage.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.LiveDecisionTriggerInputParam.event_type,
  "The transcript event type that initiates a Decision evaluation."
);
@@doc(
  OpenAI.LiveDecisionTriggerInputParam.type,
  "The item type. Always `decisions`."
);
@@doc(
  OpenAI.LiveDelegationReasoningInputParam.effort,
  "The reasoning effort used by the delegated Responses model."
);
@@doc(
  OpenAI.LiveDelegationReasoningInputParam.summary,
  "The level of reasoning summary returned by the delegated Responses model."
);
@@doc(
  OpenAI.LiveDelegationTextInputParam.verbosity,
  "The verbosity of text generated by the delegated Responses model."
);
@@doc(
  OpenAI.LiveFileSearchToolInputParam.type,
  "The tool type. Always `file_search`."
);
@@doc(
  OpenAI.LiveFunctionToolInputParam.description,
  "A description of the function that helps the model decide when to call it."
);
@@doc(
  OpenAI.LiveFunctionToolInputParam.parameters,
  "A JSON Schema object describing the parameters accepted by the function."
);
@@doc(
  OpenAI.LiveFunctionToolInputParam.strict,
  "Whether to require function arguments to conform strictly to the parameter schema."
);
@@doc(
  OpenAI.LiveHostedShellContainerAutoParam.file_ids,
  "The identifiers of files to make available in the automatically created shell container."
);
@@doc(
  OpenAI.LiveHostedShellContainerAutoParam.memory_limit,
  "The memory limit for the automatically created shell container."
);
@@doc(
  OpenAI.LiveHostedShellContainerAutoParam.network_policy,
  "The network access policy for the automatically created shell container."
);
@@doc(
  OpenAI.LiveHostedShellContainerAutoParam.skills,
  "The skills to make available in the automatically created shell container."
);
@@doc(
  OpenAI.LiveHostedShellToolInputParam.environment,
  "The automatically created container, existing container, or local environment in which shell commands run."
);
@@doc(
  OpenAI.LiveHostedShellToolInputParam.type,
  "The tool type. Always `shell`."
);
@@doc(
  OpenAI.LiveImageGenerationToolInputParam.type,
  "The tool type. Always `image_generation`."
);
@@doc(
  OpenAI.LiveInitialAssistantMessageItemParam.id,
  "An optional identifier for this message in the initial conversation history."
);
@@doc(
  OpenAI.LiveInitialAssistantMessageItemParam.status,
  "The completion status of this initial conversation message."
);
@@doc(
  OpenAI.LiveInitialDeveloperMessageItemParam.id,
  "An optional identifier for this message in the initial conversation history."
);
@@doc(
  OpenAI.LiveInitialDeveloperMessageItemParam.status,
  "The completion status of this initial conversation message."
);
@@doc(
  OpenAI.LiveInitialItem.role,
  "The author role of a message in the initial Live conversation history."
);
@@doc(
  OpenAI.LiveInitialUserMessageItemParam.id,
  "An optional identifier for this message in the initial conversation history."
);
@@doc(
  OpenAI.LiveInitialUserMessageItemParam.status,
  "The completion status of this initial conversation message."
);
@@doc(
  OpenAI.LiveLocalEnvironmentParam.skills,
  "The skills available in the local shell environment."
);
@@doc(
  OpenAI.LiveMCPToolChoiceParam.name,
  "The name of the tool to call on the specified MCP server."
);
@@doc(OpenAI.LiveMCPToolInputParam.type, "The tool type. Always `mcp`.");
@@doc(
  OpenAI.LiveNamespaceToolInputParam.type,
  "The tool type. Always `namespace`."
);
@@doc(
  OpenAI.LiveProgrammaticToolInputParam.type,
  "The tool type. Always `programmatic_tool_calling`."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.instructions,
  "Instructions for the Responses backend when it handles tasks delegated by the Live model."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.max_output_tokens,
  "The maximum number of output tokens generated by a delegated Responses request, including reasoning tokens."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.parallel_tool_calls,
  "Whether the delegated Responses model may issue multiple tool calls in parallel."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.reasoning,
  "Reasoning settings for the delegated Responses model."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.service_tier,
  "The service tier used to process delegated Responses requests."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsInputParam.text,
  "Text output settings for the delegated Responses model."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.instructions,
  "Instructions for subsequent delegated Responses requests. Omit to keep the current instructions."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.max_output_tokens,
  "The maximum number of output tokens for subsequent delegated Responses requests, including reasoning tokens. Omit to keep the current limit."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.parallel_tool_calls,
  "Whether subsequent delegated Responses requests may issue multiple tool calls in parallel. Omit to keep the current setting."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.reasoning,
  "Reasoning settings for subsequent delegated Responses requests. Omit to keep the current settings."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.service_tier,
  "The service tier for subsequent delegated Responses requests. Omit to keep the current tier."
);
@@doc(
  OpenAI.LiveResponsesDelegationSettingsUpdateInputParam.text,
  "Text output settings for subsequent delegated Responses requests. Omit to keep the current settings."
);
@@doc(
  OpenAI.LiveServerEvent.type,
  "The kind of Live event sent by the server."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.delegation_id,
  "The associated delegation ID, or null when the evaluation is not associated with a delegation."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.event,
  "The completed Decision evaluation, including its response and token usage."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.source_event_id,
  "The ID of the transcript event that triggered this evaluation, or null when no source event applies."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.source_event_type,
  "The transcript event type that triggered this evaluation, or null when no source event applies."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.trigger_id,
  "The ID of the trigger that initiated this evaluation, or null when no trigger applies."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionEvent.type,
  "The event type. Always `decision.event`."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionItemCreated.item,
  "The item added to the session's shared Decision context."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionItemCreated.type,
  "The event type. Always `decision.item.created`."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionItemDeleted.item_id,
  "The ID of the item removed from the session's shared Decision context."
);
@@doc(
  OpenAI.LiveServerEventLiveDecisionItemDeleted.type,
  "The event type. Always `decision.item.deleted`."
);
@@doc(
  OpenAI.LiveServerEventLiveOutputAudioFixturePlayed.type,
  "The event type. Always `session.output_audio.fixture.played`."
);
@@doc(
  OpenAI.LiveServerEventLiveOutputAudioFixturePlaying.type,
  "The event type. Always `session.output_audio.fixture.playing`."
);
@@doc(
  OpenAI.LiveServerEventLiveResponseEvent.delegation_id,
  "The ID of the delegation associated with the nested Responses event, when available."
);
@@doc(
  OpenAI.LiveServerEventLiveSessionClosed.session,
  "The final Live session snapshot. Its status remains active; the session.closed event indicates closure."
);
@@doc(
  OpenAI.LiveServerEventLiveSessionStarted.session,
  "The initial configuration and identifiers of the started Live session."
);
@@doc(
  OpenAI.LiveServerEventLiveSessionUpdated.session,
  "The current Live session snapshot after applying the update."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportAnswered.event_id,
  "The unique ID of this Live server event."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportAnswered.type,
  "The event type. Always `transport.answered`."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfReceived.event,
  "The DTMF digit or signal received from the remote participant."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfReceived.event_id,
  "The unique ID of this Live server event."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfReceived.type,
  "The event type. Always `transport.dtmf.received`."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfSent.event,
  "The DTMF digit or signal sent to the remote participant."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfSent.event_id,
  "The unique ID of this Live server event."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportDtmfSent.type,
  "The event type. Always `transport.dtmf.sent`."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportFailed.error,
  "Details of the failure that prevented the transport call from being established."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportFailed.event_id,
  "The unique ID of this Live server event."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportFailed.type,
  "The event type. Always `transport.failed`."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportRinging.event_id,
  "The unique ID of this Live server event."
);
@@doc(
  OpenAI.LiveServerEventLiveTransportRinging.type,
  "The event type. Always `transport.ringing`."
);
@@doc(
  OpenAI.LiveSessionCreateParams.delegation,
  "The owner and backend settings for tasks delegated by the Live model."
);
@@doc(
  OpenAI.LiveSessionCreateParams.instructions,
  "Instructions that guide the Live model's behavior during the session."
);
@@doc(
  OpenAI.LiveSessionCreateParams.`model`,
  "The Live model used to process audio and generate spoken responses."
);
@@doc(
  OpenAI.LiveSessionCreateParamsDelegation.type,
  "The backend that handles tasks delegated by the Live model."
);
@@doc(
  OpenAI.LiveSessionCreateParamsDelegationLiveDecisionsDelegationParam.decisions,
  "The model and questions used to evaluate tasks delegated to Decisions."
);
@@doc(
  OpenAI.LiveSessionCreateParamsDelegationLiveDecisionsDelegationParam.type,
  "The delegation type. Always `decisions`."
);
@@doc(
  OpenAI.LiveSessionStartEvent.event_id,
  "A client-generated ID used to correlate this command with server events."
);
@@doc(
  OpenAI.LiveSessionUpdateParams.delegation,
  "Sparse updates to the existing delegation settings. The delegation type cannot change; omitted settings retain their values."
);
@@doc(
  OpenAI.LiveSessionUpdateParamsDelegation.type,
  "The backend that handles tasks delegated by the Live model."
);
@@doc(
  OpenAI.LiveSkillReferenceParam.version,
  "The version of the referenced skill to make available."
);
@@doc(
  OpenAI.LiveToolSearchToolInputParam.type,
  "The tool type. Always `tool_search`."
);
@@doc(
  OpenAI.LiveTransportCallError.message,
  "A human-readable description of the transport call setup failure."
);
@@doc(
  OpenAI.LiveTransportCallError.type,
  "The error type. Always `call_error`."
);
@@doc(
  OpenAI.OutputTokensDetailsResource.reasoning_tokens,
  "The number of output tokens used for reasoning."
);
@@doc(
  OpenAI.RealtimeResponseInputAudio.type,
  "The item type. Always `input_audio`."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.arguments,
  "The arguments for the function call, encoded as a JSON string."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.call_id,
  "The function call ID used to associate the call with its output."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.id,
  "An optional identifier for this function-call input item."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.name,
  "The name of the function being called."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.status,
  "The completion status of the function-call input item."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCall.type,
  "The item type. Always `function_call`."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCallOutput.call_id,
  "The ID of the function call for which this item supplies output."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCallOutput.id,
  "An optional identifier for this function-call output item."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCallOutput.output,
  "The result returned by the function, encoded as a string."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCallOutput.status,
  "The completion status of the function-call output item."
);
@@doc(
  OpenAI.RealtimeResponseInputFunctionCallOutput.type,
  "The item type. Always `function_call_output`."
);
@@doc(
  OpenAI.RealtimeResponseInputImage.detail,
  "The level of image detail used when processing the image."
);
@@doc(
  OpenAI.RealtimeResponseInputImage.type,
  "The item type. Always `input_image`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessage.role,
  "The author role of the message supplied as Realtime response input."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageAssistant.content,
  "The assistant's text output included in the response input context."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageAssistant.role,
  "The message author role. Always `assistant`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageAssistant.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageAssistantContent.text,
  "The assistant text included in the response input context."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageAssistantContent.type,
  "The item type. Always `output_text`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageDeveloper.content,
  "Developer instructions included in the response input context."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageDeveloper.role,
  "The message author role. Always `developer`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageDeveloper.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageSystem.content,
  "System instructions included in the response input context."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageSystem.role,
  "The message author role. Always `system`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageSystem.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageUser.content,
  "The user's text, audio, or image content included in the response input context."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageUser.role,
  "The message author role. Always `user`."
);
@@doc(
  OpenAI.RealtimeResponseInputMessageUser.type,
  "The item type. Always `message`."
);
@@doc(
  OpenAI.RealtimeResponseInputText.text,
  "The text supplied as Realtime response input."
);
@@doc(
  OpenAI.RealtimeResponseInputText.type,
  "The item type. Always `input_text`."
);
@@doc(
  OpenAI.ResponseUsageResource.input_tokens,
  "The number of input tokens consumed by the Decision request."
);
@@doc(
  OpenAI.ResponseUsageResource.input_tokens_details,
  "A breakdown of input token usage, including prompt caching."
);
@@doc(
  OpenAI.ResponseUsageResource.output_tokens,
  "The number of output tokens generated for the Decision request."
);
@@doc(
  OpenAI.ResponseUsageResource.output_tokens_details,
  "A breakdown of output token usage, including reasoning."
);
@@doc(
  OpenAI.ResponseUsageResource.total_tokens,
  "The total number of input and output tokens used by the Decision request."
);
@@doc(OpenAI.ScoreProbabilityResource.label, "The label of the scoring level.");
@@doc(
  OpenAI.ScoreProbabilityResource.probability,
  "The predicted probability of this scoring level."
);
@@doc(
  OpenAI.ScoreProbabilityResource.value,
  "The numeric value of the scoring level."
);
@@doc(
  OpenAI.LiveSessionResourceParam.instructions,
  "Instructions that guide the Live model's behavior during the session."
);
@@doc(
  OpenAI.LiveSessionResourceParam.`model`,
  "The Live model used to process audio and generate spoken responses."
);
