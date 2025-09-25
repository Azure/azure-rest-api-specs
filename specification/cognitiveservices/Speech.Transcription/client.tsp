import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

// Prevent automatic request class generation and use our model directly
@@usage(TranscriptionContent, Usage.input);
@@access(TranscriptionContent, Access.public);

// Control operation generation - keep method name as Transcribe
@@clientName(transcribe, "Transcribe", "csharp");

// Ensure our model uses a compliant name that doesn't end with "Request"
@@clientName(TranscriptionContent, "TranscribeOptions", "csharp");

// Force protocol API only to avoid convenient API request class generation
@@protocolAPI(transcribe, true, "csharp");
@@convenientAPI(transcribe, false, "csharp");

@@clientName(TranscriptionOptions.diarization, "diarizationOptions");
@@clientName(TranscriptionOptions.channels, "activeChannels");
