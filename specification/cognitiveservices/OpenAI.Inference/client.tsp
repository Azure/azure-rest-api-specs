import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details that are wrapped into
// appropriately merged public surface.
@@internal(Azure.OpenAI.beginAzureBatchImageGeneration);

// Some models from client-internal LROs are still desired for custom public surface
@@include(Azure.OpenAI.BatchImageGenerationOperationResponse)
@@include(Azure.OpenAI.ImageGenerationOptions);
@@include(Azure.OpenAI.ImageLocationResult)
