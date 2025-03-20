import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

@@clientName(TranscriptionOptions.diarization, "diarizationProperties");
@@clientName(TranscriptionOptions.channels, "activeChannels");
