import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

@@clientName(Phrase, "TranscribedPhrase");
@@clientName(Word, "TranscribedWord");
@@clientName(TranscribeDefinition, "TranscribeConfig");
@@clientName(TranscribeDefinition.diarization, "diarizationProperties");
@@clientName(TranscribeDefinition.channels, "activeChannels");
