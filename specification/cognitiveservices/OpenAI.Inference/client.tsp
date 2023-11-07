import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details that are wrapped into
// appropriately merged public surface.
@@internal(Azure.OpenAI.beginAzureBatchImageGeneration);
@@internal(Azure.OpenAI.getAzureBatchImageGenerationOperationStatus);

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@internal(Azure.OpenAI.getChatCompletionsWithAzureExtensions);

// Remap "model" nomenclature to "DeploymentName" in appropriate containers; comments should clarify the dual use
@@projectedName(Azure.OpenAI.ImageGenerationOptions.`model`,
  "csharp",
  "DeploymentName"
);
