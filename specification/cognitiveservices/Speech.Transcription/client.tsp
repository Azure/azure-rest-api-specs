import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Override the namespace for C# to use proper capitalization (AI instead of Ai)
@@clientNamespace(Azure.Ai.Speech.Transcription, "Azure.AI.Speech.Transcription", "csharp");

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
