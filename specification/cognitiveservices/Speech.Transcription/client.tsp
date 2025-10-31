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
@@access(transcribe, Access.internal, "csharp");
