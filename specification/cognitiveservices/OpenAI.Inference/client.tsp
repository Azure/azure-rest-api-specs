import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
namespace Azure.OpenAI;

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@access(getChatCompletionsWithAzureExtensions, Access.internal);

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@access(ImageGenerationOptions, Access.public);
@@usage(ImageGenerationOptions, Usage.input | Usage.output);
@@access(ImageSize, Access.public);
@@usage(ImageGenerations, Usage.input | Usage.output);

// Java will need to have those models expose in public surface.
@@access(AudioTranscription, Access.public, "java");
@@access(AudioTranscriptionOptions, Access.public, "java");
@@access(AudioTranslation, Access.public, "java");
@@access(AudioTranslationOptions, Access.public, "java");
@@access(AzureOpenAIOperationState, Access.public, "java");

@@access(AzureCognitiveSearchIndexFieldMappingOptions, Access.public);
@@usage(AzureCognitiveSearchIndexFieldMappingOptions, Usage.input);

@@access(AzureCognitiveSearchQueryType, Access.public);
@@usage(AzureCognitiveSearchQueryType, Usage.input);

@@access(AzureCognitiveSearchChatExtensionConfiguration, Access.public);
@@usage(AzureCognitiveSearchChatExtensionConfiguration, Usage.input);

// Remap "model" nomenclature to "DeploymentName" in appropriate containers; comments should clarify the dual use
@@projectedName(ImageGenerationOptions.`model`, "csharp", "DeploymentName");

@@projectedName(ChatResponseMessage.context,
  "csharp",
  "AzureExtensionsContext"
);
