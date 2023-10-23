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

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@include(Azure.OpenAI.ImageGenerationOptions);
@@include(Azure.OpenAI.ImageLocation);
@@include(Azure.OpenAI.ImageGenerations);
