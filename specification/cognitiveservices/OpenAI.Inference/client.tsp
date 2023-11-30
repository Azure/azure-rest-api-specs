import "@azure-tools/typespec-client-generator-core";

import "./client/custom_visibility.tsp";
import "./main.tsp";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@TypeSpec.Versioning.useDependency(
  Azure.OpenAI.ServiceApiVersions.v2023_12_01_Preview
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
  getChatCompletionsWithAzureExtensions is Azure.OpenAI.getChatCompletionsWithAzureExtensions;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
  beginImageGenerations is Azure.OpenAI.beginAzureBatchImageGeneration;
  #suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "MUST fix in next update"
  #suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Allowed because this is a non-standard status polling operation."
  getAzureBatchImageGenerationOperationStatus is Azure.OpenAI.getAzureBatchImageGenerationOperationStatus;
  getImageGenerations is Azure.OpenAI.getImageGenerations;

  getEmbeddings is Azure.OpenAI.getEmbeddings;
}

@@access(OpenAIClient.beginImageGenerations, Access.internal);
@@access(OpenAIClient.getAzureBatchImageGenerationOperationStatus,
  Access.internal
);
