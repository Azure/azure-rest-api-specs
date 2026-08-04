//
// This file is used for emitting the JavaScript client (package @azure/ai-voiceagents).
//
// It is a dedicated permutation of the Foundry API surface that consumes only the
// voice-first prompt agent routes authored under ../voice-agents (Azure/azure-rest-api-specs#43970),
// plus the shared default error. It does not modify any existing sdk-* folder.
//

import "../voice-agents/routes.tsp";
import "../toolboxes/models.tsp";
import "../sdk-common/error.default.tsp";

using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

// --------------------------------------------------------------------------------
// Root client
// --------------------------------------------------------------------------------
@@clientName(Azure.AI.Projects, "VoiceAgentsClient");

// --------------------------------------------------------------------------------
// JavaScript millisecond-duration naming
// --------------------------------------------------------------------------------
// Mirrors the `*InMs` convention used by the sibling VoiceLive JavaScript client so that
// duration/offset fields read naturally in camelCase instead of an ambiguous trailing "Ms".
@@clientName(
  VoiceAgentEndOfUtteranceDetection.timeout_ms,
  "timeoutInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerVadTurnDetection.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerVadTurnDetection.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerVadTurnDetection.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureSemanticVadTurnDetection.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureSemanticVadTurnDetection.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureSemanticVadTurnDetection.idle_timeout_ms,
  "idleTimeoutInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureSemanticVadTurnDetection.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureMultilingualSemanticVadTurnDetection.prefix_padding_ms,
  "prefixPaddingInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureMultilingualSemanticVadTurnDetection.silence_duration_ms,
  "silenceDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureMultilingualSemanticVadTurnDetection.idle_timeout_ms,
  "idleTimeoutInMs",
  "javascript"
);
@@clientName(
  VoiceAgentAzureMultilingualSemanticVadTurnDetection.speech_duration_ms,
  "speechDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentInterimResponseConfig.latency_threshold_ms,
  "latencyThresholdInMs",
  "javascript"
);
@@clientName(
  VoiceAgentHandoffEdgeConfig.delay_ms,
  "delayInMs",
  "javascript"
);
@@clientName(
  VoiceAgentTranscriptionWord.offset_milliseconds,
  "offsetInMs",
  "javascript"
);
@@clientName(
  VoiceAgentTranscriptionWord.duration_milliseconds,
  "durationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentTranscriptionPhrase.offset_milliseconds,
  "offsetInMs",
  "javascript"
);
@@clientName(
  VoiceAgentTranscriptionPhrase.duration_milliseconds,
  "durationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerEventSessionHandoffCompleted.prepare_duration_ms,
  "prepareDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerEventSessionHandoffCompleted.duration_ms,
  "durationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerEventResponseAudioTimestampDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerEventResponseAudioTimestampDelta.audio_duration_ms,
  "audioDurationInMs",
  "javascript"
);
@@clientName(
  VoiceAgentServerEventResponseAnimationVisemeDelta.audio_offset_ms,
  "audioOffsetInMs",
  "javascript"
);
