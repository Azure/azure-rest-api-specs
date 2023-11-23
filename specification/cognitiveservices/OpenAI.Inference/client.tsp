import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.useDependency(Azure.OpenAI.ServiceApiVersions.v2023_12_01_Preview)
namespace Client;

// Azure-specific Chat Completions with extensions should be handled by clients as a conditional selection within the
// shared Chat Completions route, with the selection gated by the presence or non-presence of additional child
// configuration options on the request payload options model.
@@access(Azure.OpenAI.getChatCompletionsWithAzureExtensions, Access.internal);

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@access(Azure.OpenAI.ImageGenerationOptions, Access.public);
@@usage(Azure.OpenAI.ImageGenerationOptions, Usage.input | Usage.output);
@@access(Azure.OpenAI.ImageSize, Access.public);
@@usage(Azure.OpenAI.ImageGenerations, Usage.input | Usage.output);

// Java will need to have those models expose in public surface.
@@access(Azure.OpenAI.AudioTranscription, Access.public, "java");
@@access(Azure.OpenAI.AudioTranscriptionOptions, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslation, Access.public, "java");
@@access(Azure.OpenAI.AudioTranslationOptions, Access.public, "java");

@@access(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchQueryType, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchQueryType, Usage.input);

@@access(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration, Access.public);
@@usage(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration, Usage.input);

// Remap "model" nomenclature to "DeploymentName" in appropriate containers; comments should clarify the dual use
@@projectedName(Azure.OpenAI.ImageGenerationOptions.`model`, "csharp", "DeploymentName");

@@projectedName(Azure.OpenAI.ChatResponseMessage.context,
  "csharp",
  "AzureExtensionsContext"
);

@client({
  name: "OpenAIClient",
  service: Azure.OpenAI
})
interface OpenAIClient {
  getAudioTranscriptionAsPlainText is Azure.OpenAI.getAudioTranscriptionAsPlainText;
  getAudioTranscriptionAsResponseObject is Azure.OpenAI.getAudioTranscriptionAsResponseObject;

  getAudioTranslationAsPlainText is Azure.OpenAI.getAudioTranslationAsPlainText;
  getAudioTranslationAsResponseObject is Azure.OpenAI.getAudioTranslationAsResponseObject;

  getImageGenerations is Azure.OpenAI.getImageGenerations;

  getEmbeddings is Azure.OpenAI.getEmbeddings;

  getCompletions is Azure.OpenAI.getCompletions;
  getChatCompletions is Azure.OpenAI.getChatCompletions;
  getChatCompletionsWithAzureExtensions is Azure.OpenAI.getChatCompletionsWithAzureExtensions;
}
