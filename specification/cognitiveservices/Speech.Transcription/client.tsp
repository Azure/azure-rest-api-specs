import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

@@clientName(TranscriptionTranscribeRequestContent,
  "TranscriptionTranscribeRequestContent",
  "csharp"
);
@@clientName(submitTranscriptionContent,
  "SubmitTranscriptionContent",
  "csharp"
);

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
