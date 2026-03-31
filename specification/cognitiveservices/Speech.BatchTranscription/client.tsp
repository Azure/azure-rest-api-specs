import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.BatchTranscription;

// TypeScript uses PascalCase for service names to match namespace conventions
@@clientNamespace(Azure.Ai.Speech.BatchTranscription,
  "Azure.AI.Speech.BatchTranscription",
  "javascript"
);

// Client customizations for property names

@@clientName(TranscriptionJob.contentUrls, "contents", "csharp/java");
@@clientName(TranscriptionJob.contentContainerUrl,
  "sourceContainer",
  "csharp/java"
);
@@clientName(TranscriptionJob.createdDateTime, "created");
@@clientName(TranscriptionProperties.destinationContainerUrl,
  "destinationContainer",
  "csharp/java"
);
@@clientName(TranscriptionProperties.languageIdentification,
  "languageIdentificationProperties"
);
@@clientName(TranscriptionFile.createdDateTime, "created");
@@clientName(FileLinks.contentUrl, "content", "csharp/java");
