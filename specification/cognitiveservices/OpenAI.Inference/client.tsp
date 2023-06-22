import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details
@@internal(Azure.OpenAI.startGenerateImage);

// Some models from client-internal LROs are still desired for custom public surface
@@include(Azure.OpenAI.ImageGenerationOptions);
