import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details that are wrapped into
// appropriately merged public surface.
@@internal(Azure.OpenAI.beginAzureBatchImageGeneration);
@@internal(Azure.OpenAI.getAzureBatchImageGenerationOperationStatus);

// Models related to the top-level details of these LROs should also be internal.
@@internal(Azure.OpenAI.BatchImageGenerationOperationResponse);

// Some models from client-internal LROs are still desired for custom public surface.
@@include(Azure.OpenAI.ImageGenerationOptions);
@@include(Azure.OpenAI.ImageLocation);
@@include(Azure.OpenAI.ImageGenerations);
