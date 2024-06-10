import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(ModelClient.Versions.v2024_05_01_Preview)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// These models are used by the hand-written operator methods.
// We need to declare their usage and public access, otherwise they won't be emited in the generated code.
@@usage(ModelClient.StreamingChatChoiceUpdate, Usage.output);
@@usage(ModelClient.ChatCompletions, Usage.output);
@@usage(ModelClient.StreamingChatCompletionsUpdate, Usage.output);
@@usage(ModelClient.ModelInfo, Usage.output);

// Since we made all operator methods internal, we need to expliclty say we still want the models they use
// to be public.
@@access(ModelClient.ChatChoice, Access.public);
@@access(ModelClient.ChatCompletions, Access.public);
@@access(ModelClient.ChatCompletionsFunctionToolCall, Access.public);
@@access(ModelClient.ChatCompletionsFunctionToolDefinition, Access.public);
@@access(ModelClient.ChatCompletionsNamedToolSelection, Access.public);
@@access(ModelClient.ChatCompletionsNamedFunctionToolSelection, Access.public);
@@access(ModelClient.ChatCompletionsFunctionToolSelection, Access.public);
@@access(ModelClient.ChatCompletionsResponseFormat, Access.public);
@@access(ModelClient.ChatCompletionsToolCall, Access.public);
@@access(ModelClient.ChatCompletionsToolDefinition, Access.public);
@@access(ModelClient.ChatCompletionsToolSelectionPreset, Access.public);
@@access(ModelClient.ChatRequestAssistantMessage, Access.public);
@@access(ModelClient.ChatRequestMessage, Access.public);
@@access(ModelClient.ChatRequestSystemMessage, Access.public);
@@access(ModelClient.ChatRequestToolMessage, Access.public);
@@access(ModelClient.ChatRequestUserMessage, Access.public);
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
@@access(ModelClient.StreamingChatChoiceUpdate, Access.public, "python");
@@access(ModelClient.StreamingChatCompletionsUpdate, Access.public, "python");
@@access(ModelClient.ChatMessageContentItem, Access.public);
@@access(ModelClient.ChatMessageTextContentItem, Access.public);
@@access(ModelClient.ChatMessageImageContentItem, Access.public);
@@access(ModelClient.ChatMessageImageUrl, Access.public);
@@access(ModelClient.ChatMessageImageDetailLevel, Access.public);

// The operators need to be hidden, since we hand-write the public versions of those to
// 1. Add chat completions streaming (to getChatCompletions operator)
// 2. Add hyper-params (to getChatCompletions/Embeddings/ImageEmbeddings, all clients)
// 3. Cache model info (to getModelInfo, all clients)
@@access(ModelClient.getChatCompletions, Access.internal, "python");
@@access(ModelClient.getEmbeddings, Access.internal, "python");
@@access(ModelClient.getImageEmbeddings, Access.internal, "python");
@@access(ModelClient.getModelInfo, Access.internal, "python");

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
  embed is ModelClient.getEmbeddings;
  getModelInfo is ModelClient.getModelInfo;
}

@client({
  name: "ImageEmbeddingsClient",
  service: ModelClient,
})
interface Client3 {
  embed is ModelClient.getImageEmbeddings;
  getModelInfo is ModelClient.getModelInfo;
}
