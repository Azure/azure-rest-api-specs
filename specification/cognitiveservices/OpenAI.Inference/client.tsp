import "@azure-tools/typespec-client-generator-core";

import "./client/custom_visibility.tsp";
import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.useDependency(
  Azure.OpenAI.ServiceApiVersions.v2024_02_15_Preview
)
namespace Client;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@client({
  name: "OpenAIClient",
  service: Azure.OpenAI,
})
interface OpenAIClient {
  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
  getAudioTranscriptionAsPlainText is Azure.OpenAI.getAudioTranscriptionAsPlainText;

  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
  getAudioTranscriptionAsResponseObject is Azure.OpenAI.getAudioTranscriptionAsResponseObject;

  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
  getAudioTranslationAsPlainText is Azure.OpenAI.getAudioTranslationAsPlainText;

  #suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
  getAudioTranslationAsResponseObject is Azure.OpenAI.getAudioTranslationAsResponseObject;

  getCompletions is Azure.OpenAI.getCompletions;
  getChatCompletions is Azure.OpenAI.getChatCompletions;

  getImageGenerations is Azure.OpenAI.getImageGenerations;

  generateSpeechFromText is Azure.OpenAI.generateSpeechFromText;

  getEmbeddings is Azure.OpenAI.getEmbeddings;
}

@@clientName(Azure.OpenAI.GenerateSpeechFromTextBody.body,
  "speechGenerationOptions",
  "java"
);
@@clientName(Azure.OpenAI.GetAudioTranscriptionBody.body,
  "audioTranscriptionOptions",
  "java"
);
@@clientName(Azure.OpenAI.GetAudioTranslationBody.body,
  "audioTranslationOptions",
  "java"
);
@@clientName(Azure.OpenAI.GetChatCompletionsBody.body,
  "chatCompletionsOptions",
  "java"
);
@@clientName(Azure.OpenAI.GetCompletionsBody.body,
  "completionsOptions",
  "java"
);
@@clientName(Azure.OpenAI.GetEmbeddingsBody.body, "embeddingsOptions", "java");
@@clientName(Azure.OpenAI.GetImageGenerationsBody.body,
  "imageGenerationOptions",
  "java"
);
