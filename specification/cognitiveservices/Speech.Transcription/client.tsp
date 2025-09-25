import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Prevent automatic request class generation and use our model directly
@@usage(TranscriptionTranscribeRequestContent, Usage.input);
@@access(TranscriptionTranscribeRequestContent, Access.public);
@@clientName(TranscriptionTranscribeRequestContent,
  "TranscriptionTranscribeRequestContent",
  "csharp"
);

// Ensure operation doesn't generate conflicting request class
@@clientName(transcribe, "Transcribe", "csharp");

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
