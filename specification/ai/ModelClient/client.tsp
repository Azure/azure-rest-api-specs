import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AI.Model.Versions.v2024_08_01_Preview)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// Since we made all operator methods internal, we need to expliclty
// say we still want the models they use to be public.
@@access(AI.Model.ChatChoice, Access.public);
@@access(AI.Model.ChatCompletions, Access.public);
@@access(AI.Model.ChatCompletionsToolCall, Access.public);
@@access(AI.Model.ChatCompletionsToolDefinition, Access.public);
@@access(AI.Model.ChatCompletionsNamedToolChoice, Access.public);
@@access(AI.Model.ChatCompletionsNamedToolChoiceFunction, Access.public);
@@access(AI.Model.ChatCompletionsResponseFormat, Access.public);
@@access(AI.Model.ChatCompletionsResponseFormatJsonObject, Access.public);
@@access(AI.Model.ChatCompletionsResponseFormatJsonSchema, Access.public);
@@access(AI.Model.ChatCompletionsResponseFormatJsonSchemaDefinition, Access.public);
@@access(AI.Model.ChatCompletionsResponseFormatText, Access.public);
@@access(AI.Model.ChatCompletionsToolCall, Access.public);
@@access(AI.Model.ChatCompletionsToolDefinition, Access.public);
@@access(AI.Model.ChatCompletionsToolChoicePreset, Access.public);
@@access(AI.Model.ChatRequestAssistantMessage, Access.public);
@@access(AI.Model.ChatRequestMessage, Access.public);
@@access(AI.Model.ChatRequestSystemMessage, Access.public);
@@access(AI.Model.ChatRequestToolMessage, Access.public);
@@access(AI.Model.ChatRequestUserMessage, Access.public);
@@access(AI.Model.ChatResponseMessage, Access.public);
@@access(AI.Model.ChatRole, Access.public);
@@access(AI.Model.CompletionsFinishReason, Access.public);
@@access(AI.Model.CompletionsUsage, Access.public);
@@access(AI.Model.EmbeddingEncodingFormat, Access.public);
@@access(AI.Model.EmbeddingInputType, Access.public);
@@access(AI.Model.EmbeddingItem, Access.public);
@@access(AI.Model.EmbeddingsResult, Access.public);
@@access(AI.Model.EmbeddingsUsage, Access.public);
@@access(AI.Model.ExtraParameters, Access.public, "java");
@@access(AI.Model.ImageEmbeddingInput, Access.public);
@@access(AI.Model.FunctionCall, Access.public);
@@access(AI.Model.FunctionDefinition, Access.public);
@@access(AI.Model.ModelInfo, Access.public);
@@access(AI.Model.ModelType, Access.public);
@@access(AI.Model.ChatMessageContentItem, Access.public);
@@access(AI.Model.ChatMessageTextContentItem, Access.public);
@@access(AI.Model.ChatMessageImageContentItem, Access.public);
@@access(AI.Model.ChatMessageImageUrl, Access.public);
@@access(AI.Model.ChatMessageImageDetailLevel, Access.public);
@@access(AI.Model.StreamingChatCompletionsUpdate, Access.public);
@@access(AI.Model.StreamingChatChoiceUpdate, Access.public);
@@access(AI.Model.StreamingChatResponseMessageUpdate, Access.public);
@@access(AI.Model.StreamingChatResponseToolCallUpdate, Access.public);
@@access(AI.Model.ChatRequestDeveloperMessage,
  Access.public,
  "csharp,java,javascript"
);

// The operators need to be hidden, since we hand-write the public versions of those to
// 1. Add chat completions streaming (to getChatCompletions operator)
// 2. Add hyper-params (to getChatCompletions/Embeddings/ImageEmbeddings, all clients)
// 3. Cache model info (to getModelInfo, all clients, Python only)
@@access(AI.Model.getChatCompletions, Access.internal);
@@access(AI.Model.getEmbeddings, Access.internal);
@@access(AI.Model.getImageEmbeddings, Access.internal);
@@access(AI.Model.getModelInfo, Access.internal);

// We use shorter names in the Python client library
@@clientName(AI.Model.ChatRequestSystemMessage, "SystemMessage", "python");
@@clientName(AI.Model.ChatRequestUserMessage, "UserMessage", "python");
@@clientName(AI.Model.ChatRequestAssistantMessage,
  "AssistantMessage",
  "python"
);
@@clientName(AI.Model.ChatRequestToolMessage, "ToolMessage", "python");
@@clientName(AI.Model.ChatMessageContentItem, "ContentItem", "python");
@@clientName(AI.Model.ChatMessageTextContentItem, "TextContentItem", "python");
@@clientName(AI.Model.ChatMessageImageContentItem,
  "ImageContentItem",
  "python"
);
@@clientName(AI.Model.ChatMessageImageUrl, "ImageUrl", "python");
@@clientName(AI.Model.ChatMessageImageDetailLevel,
  "ImageDetailLevel",
  "python"
);

@client({
  name: "ChatCompletionsClient",
  service: AI.Model,
})
interface Client1 {
  complete is AI.Model.getChatCompletions;
  getModelInfo is AI.Model.getModelInfo;
}

@client({
  name: "EmbeddingsClient",
  service: AI.Model,
})
interface Client2 {
  embed is AI.Model.getEmbeddings;
  getModelInfo is AI.Model.getModelInfo;
}

@client({
  name: "ImageEmbeddingsClient",
  service: AI.Model,
})
interface Client3 {
  embed is AI.Model.getImageEmbeddings;
  getModelInfo is AI.Model.getModelInfo;
}
