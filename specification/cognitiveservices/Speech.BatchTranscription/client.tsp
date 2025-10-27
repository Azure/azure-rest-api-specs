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
