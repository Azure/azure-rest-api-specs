import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Explicit C# client naming to ensure AZC0030 compliance
@@clientName(TranscriptionTranscribeRequestContent,
  "TranscriptionTranscribeRequestContent",
  "csharp"
);

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
