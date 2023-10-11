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

// Many fields have their names customized on a per-language basis to follow idiomatic rules.
@@projectedName(Azure.OpenAI.AudioTranscription.task,
  "csharp",
  "InternalAudioTaskLabel"
);
@@projectedName(Azure.OpenAI.AudioTranscriptionOptions.`model`,
  "csharp",
  "InternalNonAzureModelName"
);
@@projectedName(Azure.OpenAI.AudioTranscriptionOptions.file,
  "csharp",
  "AudioData"
);
@@projectedName(Azure.OpenAI.AudioTranscriptionSegment.avgLogprob,
  "csharp",
  "AverageLogProbability"
);
@@projectedName(Azure.OpenAI.AudioTranscriptionSegment.noSpeechProb,
  "csharp",
  "NoSpeechProbability"
);
@@projectedName(Azure.OpenAI.AudioTranslation.task,
  "csharp",
  "InternalAudioTaskLabel"
);
@@projectedName(Azure.OpenAI.AudioTranslationOptions.`model`,
  "csharp",
  "InternalNonAzureModelName"
);
@@projectedName(Azure.OpenAI.AudioTranslationOptions.file,
  "csharp",
  "AudioData"
);
@@projectedName(Azure.OpenAI.AudioTranslationSegment.avgLogprob,
  "csharp",
  "AverageLogProbability"
);
@@projectedName(Azure.OpenAI.AudioTranslationSegment.noSpeechProb,
  "csharp",
  "NoSpeechProbability"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration.endpoint,
  "csharp",
  "SearchEndpoint"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration.fieldsMapping,
  "csharp",
  "FieldMappingOptions"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration.inScope,
  "csharp",
  "ShouldRestrictResultScope"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration.key,
  "csharp",
  "SearchKey"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchChatExtensionConfiguration.topNDocuments,
  "csharp",
  "DocumentCount"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions.filepathField,
  "csharp",
  "FilepathFieldName"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions.titleField,
  "csharp",
  "TitleFieldName"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions.urlField,
  "csharp",
  "UrlFieldName"
);
@@projectedName(Azure.OpenAI.AzureCognitiveSearchIndexFieldMappingOptions.vectorFields,
  "csharp",
  "VectorFieldNames"
);
@@projectedName(Azure.OpenAI.BatchImageGenerationOperationResponse.created,
  "java",
  "createdAt"
);
@@projectedName(Azure.OpenAI.ChatChoice.delta,
  "csharp",
  "InternalStreamingDeltaMessage"
);
@@projectedName(Azure.OpenAI.ChatCompletions.created, "java", "createdAt");
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.`model`,
  "csharp",
  "InternalNonAzureModelName"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.dataSources,
  "csharp",
  "InternalAzureExtensionsDataSources"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.logitBias,
  "csharp",
  "InternalStringKeyedTokenSelectionBiases"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.n, "csharp", "ChoiceCount");
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.stop,
  "csharp",
  "StopSequences"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.stream,
  "csharp",
  "InternalShouldStreamResponse"
);
@@projectedName(Azure.OpenAI.ChatCompletionsOptions.topP,
  "csharp",
  "NucleusSamplingFactor"
);
@@projectedName(Azure.OpenAI.ChatMessage.context,
  "csharp",
  "AzureExtensionsContext"
);
@@projectedName(Azure.OpenAI.Choice.logprobs, "csharp", "LogProbabilityModel");
@@projectedName(Azure.OpenAI.Completions.created, "java", "createdAt");
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.textOffset,
  "csharp",
  "TextOffsets"
);
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.textOffset,
  "java",
  "textOffsets"
);
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.tokenLogprobs,
  "csharp",
  "TokenLogProbabilities"
);
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.tokenLogprobs,
  "java",
  "tokenLogProbabilities"
);
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.topLogprobs,
  "csharp",
  "TopLogProbabilities"
);
@@projectedName(Azure.OpenAI.CompletionsLogProbabilityModel.topLogprobs,
  "java",
  "topLogProbabilities"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.`model`,
  "csharp",
  "InternalNonAzureModelName"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.bestOf,
  "csharp",
  "GenerationSampleCount"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.logitBias,
  "csharp",
  "InternalStringKeyedTokenSelectionBiases"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.logprobs,
  "csharp",
  "LogProbabilityCount"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.n,
  "csharp",
  "ChoicesPerPrompt"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.prompt, "csharp", "Prompts");
@@projectedName(Azure.OpenAI.CompletionsOptions.stop,
  "csharp",
  "StopSequences"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.stream,
  "csharp",
  "InternalShouldStreamResponse"
);
@@projectedName(Azure.OpenAI.CompletionsOptions.topP,
  "csharp",
  "NucleusSamplingFactor"
);
@@projectedName(Azure.OpenAI.Deployment.deploymentId,
  "java",
  "deploymentOrModelName"
);
@@projectedName(Azure.OpenAI.EmbeddingItem, "java", "promptIndex");
@@projectedName(Azure.OpenAI.EmbeddingsOptions.`model`,
  "csharp",
  "InternalNonAzureModelName"
);
@@projectedName(Azure.OpenAI.ImageGenerationOptions.n, "csharp", "ImageCount");
@@projectedName(Azure.OpenAI.ImageGenerations.created, "java", "createdAt");
