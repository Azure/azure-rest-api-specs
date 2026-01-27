import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

@@clientNamespace(Azure.Ai.Speech.Transcription,
  "Azure.AI.Speech.Transcription",
  "csharp"
);

// TypeScript uses PascalCase for service names to match namespace conventions
@@clientNamespace(Azure.Ai.Speech.Transcription,
  "Azure.AI.Speech.Transcription",
  "javascript"
);

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
@@clientName(TranscriptionOptions.models, "localeModelMapping", "java");
@@clientName(TranscriptionOptions.phraseList, "phraseListOptions", "java");
@@clientName(TranscriptionOptions.enhancedMode, "enhancedModeOptions", "java");
@@clientName(EnhancedModeProperties, "EnhancedModeOptions", "java");
@@clientName(EnhancedModeProperties.prompt, "prompts", "java");
@@clientName(PhraseListProperties, "PhraseListOptions", "java");
@@clientName(TranscriptionResult.durationMilliseconds, "duration", "java");
@@clientName(TranscribedPhrase.offsetMilliseconds, "offset", "java");
@@clientName(TranscribedPhrase.durationMilliseconds, "duration", "java");
@@clientName(TranscribedWord.offsetMilliseconds, "offset", "java");
@@clientName(TranscribedWord.durationMilliseconds, "duration", "java");
@@access(transcribe, Access.internal, "csharp");
@@access(TranscriptionContent, Access.internal, "java");
@@access(TranscriptionContent, Access.internal, "csharp");
@@clientName(TranscriptionContent.definition, "options", "java");
@@clientName(TranscriptionContent.definition, "options", "csharp");
