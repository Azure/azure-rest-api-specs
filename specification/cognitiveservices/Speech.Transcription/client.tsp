import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Ensure request content type does not end with "Request" in generated SDKs (AZC0030)
@@clientName(TranscriptionTranscribeContent, "TranscribeContent", "csharp");
@@clientName(transcribe::parameters, "TranscribeContent", "csharp");

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
