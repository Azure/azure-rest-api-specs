import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.BatchTranscription;

@@clientName(TranscriptionProperties.destinationContainerUrl,
  "destinationContainer",
  "csharp, java"
);
@@clientName(FileLinks.contentUrl, "content", "csharp, java");
@@clientName(TranscriptionJob.contentUrls, "contents", "csharp, java");

@@clientName(TranscriptionProperties.languageIdentification,
  "languageIdentificationProperties"
);
