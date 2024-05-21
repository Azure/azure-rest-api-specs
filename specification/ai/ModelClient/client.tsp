import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(ModelClient.Versions.v2024_05_01_Preview)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// TODO: Can we trim this list???

// The "Update" models are used by the hand-written operation method that supports streaming.
// We need to declare their usage and public access, otherwise they won't be emited in the generated code.
@@usage(ModelClient.ChatChoiceUpdate, Usage.output);
@@usage(ModelClient.ChatCompletions, Usage.output);
@@usage(ModelClient.ChatCompletionsUpdate, Usage.output);
@@usage(ModelClient.ModelInfo, Usage.output);

@@access(ModelClient.AssistantMessage, Access.public);
@@access(ModelClient.CapacityType, Access.public);
@@access(ModelClient.ChatChoice, Access.public);
@@access(ModelClient.ChatChoiceUpdate, Access.public);
@@access(ModelClient.ChatCompletions, Access.public);
@@access(ModelClient.ChatCompletionsFunctionToolCall, Access.public);
@@access(ModelClient.ChatCompletionsFunctionToolDefinition, Access.public);
@@access(ModelClient.ChatCompletionsNamedToolSelection, Access.public);
@@access(ModelClient.ChatCompletionsResponseFormat, Access.public);
@@access(ModelClient.ChatCompletionsToolCall, Access.public);
@@access(ModelClient.ChatCompletionsToolDefinition, Access.public);
@@access(ModelClient.ChatCompletionsToolSelectionPreset, Access.public);
@@access(ModelClient.ChatCompletionsUpdate, Access.public);
@@access(ModelClient.ChatRequestMessage, Access.public);
@@access(ModelClient.ChatResponseMessage, Access.public);
@@access(ModelClient.ChatRole, Access.public);
@@access(ModelClient.CompletionsFinishReason, Access.public);
@@access(ModelClient.CompletionsUsage, Access.public);
@@access(ModelClient.EmbeddingEncodingFormat, Access.public);
@@access(ModelClient.EmbeddingInput, Access.public);
@@access(ModelClient.EmbeddingInputType, Access.public);
@@access(ModelClient.EmbeddingItem, Access.public);
@@access(ModelClient.EmbeddingsResult, Access.public);
@@access(ModelClient.EmbeddingsUsage, Access.public);
@@access(ModelClient.FunctionCall, Access.public);
@@access(ModelClient.FunctionDefinition, Access.public);
@@access(ModelClient.ModelInfo, Access.public);
@@access(ModelClient.SystemMessage, Access.public);
@@access(ModelClient.ToolMessage, Access.public);
@@access(ModelClient.UserMessage, Access.public);

// The operators need to be hidden, since we hand-write the public versions of those to
// 1. Add chat completions streaming (`getChatCompletions` operator only)
// 2. Add hyper-params (all operators, all clients)
// 3. Cache model info (all clients)
@@access(ModelClient.getChatCompletions, Access.internal);
@@access(ModelClient.getEmbeddings, Access.internal);
@@access(ModelClient.getImageEmbeddings, Access.internal);
@@access(ModelClient.getModelInfo, Access.internal);

@client({
  name: "ChatCompletionsClient",
  service: ModelClient,
})
interface Client1 {
  complete is ModelClient.getChatCompletions;
  getModelInfo is ModelClient.getModelInfo;
}

@client({
  name: "EmbeddingsClient",
  service: ModelClient,
})
interface Client2 {
  embedding is ModelClient.getEmbeddings;
  getModelInfo is ModelClient.getModelInfo;
}

@client({
  name: "ImageEmbeddingsClient",
  service: ModelClient,
})
interface Client3 {
  embedding is ModelClient.getImageEmbeddings;
  getModelInfo is ModelClient.getModelInfo;
}
