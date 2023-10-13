import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Azure-specific long-running operations should be treated as implementation details that are wrapped into
// appropriately merged public surface.
@@access(Azure.OpenAI.beginAzureBatchImageGeneration, Access.internal);
@@access(Azure.OpenAI.getAzureBatchImageGenerationOperationStatus, Access.internal);

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@access(Azure.OpenAI.getChatCompletionsWithAzureExtensions, Access.internal);

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@access(Azure.OpenAI.ImageGenerationOptions, Access.public);
@@access(Azure.OpenAI.ImageLocation, Access.public, "csharp");
@@access(Azure.OpenAI.ImageLocation, Access.public, "python");
@@access(Azure.OpenAI.ImageLocation, Access.public, "javascript");
@@access(Azure.OpenAI.ImageGenerations, Access.public, "csharp");
@@access(Azure.OpenAI.ImageGenerations, Access.public, "python");
@@access(Azure.OpenAI.ImageGenerations, Access.public, "javascript");
@@access(Azure.OpenAI.ImageSize, Access.public);

@@access(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchQueryType, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchQueryType, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration, Usage.input);

// Java
@@access(Azure.OpenAI.AzureChatExtensionConfiguration, Access.public, "java");
@@access(Azure.OpenAI.AzureChatExtensionsMessageContext, Access.public, "java");
@@access(Azure.OpenAI.AzureOpenAIOperationState, Access.public, "java");
@@access(Azure.OpenAI.ChatCompletions, Access.public, "java");
@@access(Azure.OpenAI.FunctionDefinition, Access.public, "java");
@@access(Azure.OpenAI.FunctionName, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscriptionOptions, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslationOptions, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscription, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslation, Access.public, "java");
