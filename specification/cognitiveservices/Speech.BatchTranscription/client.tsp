import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.BatchTranscription;

@@clientNamespace(Azure.Ai.Speech.BatchTranscription,
  "Azure.AI.Speech.BatchTranscription",
  "csharp"
);

// TypeScript uses PascalCase for service names to match namespace conventions
@@clientNamespace(Azure.Ai.Speech.BatchTranscription,
  "Azure.AI.Speech.BatchTranscription",
  "javascript"
);

@@clientName(TranscriptionProperties.destinationContainerUrl,
  "destinationContainer",
  "csharp, java"
);
@@clientName(FileLinks.contentUrl, "content", "csharp, java");
@@clientName(TranscriptionJob.contentUrls, "contents", "csharp, java");

@@clientName(TranscriptionProperties.languageIdentification,
  "languageIdentificationProperties"
);
@@clientName(TranscriptionJob.contentContainerUrl,
  "sourceContainer",
  "csharp, java"
);
@@clientName(TranscriptionJob.createdDateTime, "created");
@@clientName(TranscriptionFile.createdDateTime, "created");
