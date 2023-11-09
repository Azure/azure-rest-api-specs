import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details that are wrapped into
// appropriately merged public surface.
@@access(Azure.OpenAI.beginAzureBatchImageGeneration, Access.internal);
@@access(Azure.OpenAI.getAzureBatchImageGenerationOperationStatus,
  Access.internal
);

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@access(Azure.OpenAI.getChatCompletionsWithAzureExtensions, Access.internal);

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@usage(Azure.OpenAI.ImageGenerationOptions, Usage.input | Usage.output);
@@usage(Azure.OpenAI.ImageLocation, Usage.input | Usage.output);
@@usage(Azure.OpenAI.ImageGenerations, Usage.input | Usage.output);

// New additions: we don't seem to need routes for them to be exposed
// These models will be added under implementation.models
@@access(Azure.OpenAI.ChatCompletionsStream, Access.internal);
@@usage(Azure.OpenAI.ChatCompletionsStream, Usage.output);

@@access(Azure.OpenAI.CompletionsStreamDelta, Access.internal);
@@usage(Azure.OpenAI.CompletionsStreamDelta, Usage.output);
