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
@@access(Azure.OpenAI.ImageGenerationOptions, Access.public);
@@usage(Azure.OpenAI.ImageGenerationOptions, Usage.input | Usage.output);
@@access(Azure.OpenAI.ImageLocation, Access.public);
@@usage(Azure.OpenAI.ImageLocation, Usage.input | Usage.output);
@@access(Azure.OpenAI.ImageSize, Access.public);
@@usage(Azure.OpenAI.ImageGenerations, Usage.input | Usage.output);

// Java will need to have those models expose in public surface.
@@access(Azure.OpenAI.AudioTaskLabel, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscription, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscriptionSegment, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslation, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslationSegment, Access.public, "java");
@@access(Azure.OpenAI.AzureChatExtensionConfiguration, Access.public, "java");
@@access(Azure.OpenAI.AzureChatExtensionType, Access.public, "java");
@@access(Azure.OpenAI.AzureOpenAIOperationState, Access.public, "java");
@@access(Azure.OpenAI.ChatChoice, Access.public, "java");
@@access(Azure.OpenAI.ChatCompletions, Access.public, "java");
// Error: Model 'ChatCompletionsOptions' cannot be set as access=public, as it refers Union 'FunctionCallPreset | FunctionName'
// @@access(Azure.OpenAI.ChatCompletionsOptions, Access.public, "java");
@@access(Azure.OpenAI.ChatMessage, Access.public, "java");
@@access(Azure.OpenAI.ChatRole, Access.public, "java");
@@access(Azure.OpenAI.FunctionCall, Access.public, "java");
@@access(Azure.OpenAI.FunctionDefinition, Access.public, "java");
@@access(Azure.OpenAI.FunctionName, Access.public, "java");

@@access(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions,
  Access.public
);
@@usage(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchQueryType, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchQueryType, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration,
  Access.public
);
@@usage(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration,
  Usage.input
);
