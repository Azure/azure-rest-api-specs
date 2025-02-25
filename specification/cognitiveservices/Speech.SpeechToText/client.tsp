import "./main.tsp";
import "./models/batch.tsp";
import "./models/fast.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using SpeechToText.FastTranscriptionClient;
using SpeechToText.BatchTranscriptionClient;

namespace SpeechToText;

@@clientName(Phrase, "TranscribedPhrase");
@@clientName(Word, "TranscribedWord");
@@clientName(TranscribeDefinition, "TranscribeConfig");

@@clientName(TranscriptionProperties.destinationContainerUrl,
  "destinationContainer",
  "csharp, java"
);
@@clientName(FileLinks.contentUrl, "content", "csharp, java");
@@clientName(TranscriptionJob.contentUrls, "contents", "csharp, java");

@@clientName(TranscriptionProperties.languageIdentification,
  "languageIdentificationProperties"
);
@@clientName(TranscribeDefinition.diarization, "diarizationProperties");
@@clientName(TranscribeDefinition.channels, "activeChannels");
