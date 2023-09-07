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

// The disparate possible formats for transcription and translation should be unified into a common surface by the
// client.
// We are alternatively emitting this in as custom types in a package that is private from the perspective of the user
@@internal(Azure.OpenAI.getAudioTranscriptionSimpleJson)
@@internal(Azure.OpenAI.getAudioTranscriptionVerboseJson)
@@internal(Azure.OpenAI.getAudioTranscriptionPlainText)
@@internal(Azure.OpenAI.getAudioTranscriptionSrt)
@@internal(Azure.OpenAI.getAudioTranscriptionVtt)
@@internal(Azure.OpenAI.getAudioTranslationSimpleJson)
@@internal(Azure.OpenAI.getAudioTranslationVerboseJson)
@@internal(Azure.OpenAI.getAudioTranslationPlainText)
@@internal(Azure.OpenAI.getAudioTranslationSrt)
@@internal(Azure.OpenAI.getAudioTranslationVtt)

// Some models from routes with suppressed visibility are still desired for custom public surface.
@@include(Azure.OpenAI.ImageGenerationOptions);
@@include(Azure.OpenAI.ImageLocation);
@@include(Azure.OpenAI.ImageGenerations);
