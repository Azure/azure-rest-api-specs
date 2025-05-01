import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// Are these needed?
@@usage(Azure.AI.Inference.ChatCompletions, Usage.output);
@@usage(Azure.AI.Inference.ModelInfo, Usage.output);
@@usage(Azure.AI.Inference.StreamingChatCompletionsUpdate, Usage.output);
@@usage(Azure.AI.Inference.StreamingChatChoiceUpdate, Usage.output);
@@usage(Azure.AI.Inference.StreamingChatResponseMessageUpdate, Usage.output);
@@usage(Azure.AI.Inference.StreamingChatResponseToolCallUpdate, Usage.output);

// Necessary for autogenerating options objects while the clients specify spread parameters. Necessary for the languages that want the options class.
@@usage(Azure.AI.Inference.ChatCompletionsOptions, Usage.input, "csharp");
@@usage(Azure.AI.Inference.EmbeddingsOptions, Usage.input, "csharp");
@@usage(Azure.AI.Inference.ImageEmbeddingsOptions, Usage.input, "csharp");

// Necessary due to how we're forcing this abstraction
@@usage(Azure.AI.Inference.ChatMessageAudioDataContentItem, Usage.input);
@@usage(Azure.AI.Inference.ChatMessageAudioUrlContentItem, Usage.input);

// The operators need to be hidden, since we hand-write the public versions of those
@@access(Azure.AI.Inference.getChatCompletions, Access.internal);
@@access(Azure.AI.Inference.getEmbeddings, Access.internal);
@@access(Azure.AI.Inference.getImageEmbeddings, Access.internal);
@@access(Azure.AI.Inference.getModelInfo, Access.internal, "python");

// Since we made all operator methods internal, we need to explicity
// say we still want the models they use to be public, since they will be used by hand-written operator methods.
@@access(Azure.AI.Inference.ChatChoice, Access.public);
@@access(Azure.AI.Inference.ChatCompletions, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsToolCall, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsToolDefinition, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsNamedToolChoice, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsNamedToolChoiceFunction,
  Access.public
);
@@access(Azure.AI.Inference.ChatCompletionsToolCall, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsToolDefinition, Access.public);
@@access(Azure.AI.Inference.ChatCompletionsToolChoicePreset, Access.public);
@@access(Azure.AI.Inference.ChatRequestMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatRequestAssistantMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatRequestSystemMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatRequestToolMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatRequestUserMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatRequestDeveloperMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(Azure.AI.Inference.ChatResponseMessage, Access.public);
@@access(Azure.AI.Inference.ChatRole, Access.public);
@@access(Azure.AI.Inference.CompletionsFinishReason, Access.public);
@@access(Azure.AI.Inference.CompletionsUsage, Access.public);
@@access(Azure.AI.Inference.EmbeddingEncodingFormat, Access.public);
@@access(Azure.AI.Inference.ImageEmbeddingInput, Access.public);
@@access(Azure.AI.Inference.EmbeddingInputType, Access.public);
@@access(Azure.AI.Inference.EmbeddingItem, Access.public);
@@access(Azure.AI.Inference.EmbeddingsResult, Access.public);
@@access(Azure.AI.Inference.EmbeddingsUsage, Access.public);
@@access(Azure.AI.Inference.FunctionCall, Access.public);
@@access(Azure.AI.Inference.FunctionDefinition, Access.public);
@@access(Azure.AI.Inference.ModelInfo, Access.public);
@@access(Azure.AI.Inference.ModelType, Access.public);
@@access(Azure.AI.Inference.ChatMessageContentItem, Access.public);
@@access(Azure.AI.Inference.ChatMessageTextContentItem, Access.public);
@@access(Azure.AI.Inference.ChatMessageImageContentItem, Access.public);
@@access(Azure.AI.Inference.ChatMessageImageUrl, Access.public);
@@access(Azure.AI.Inference.ChatMessageImageDetailLevel, Access.public);
@@access(Azure.AI.Inference.StreamingChatCompletionsUpdate, Access.public);
@@access(Azure.AI.Inference.StreamingChatChoiceUpdate, Access.public);
@@access(Azure.AI.Inference.StreamingChatResponseMessageUpdate, Access.public);
@@access(Azure.AI.Inference.StreamingChatResponseToolCallUpdate, Access.public);

// Hide the JSON schema class in favor of a factory method on the ChatCompletionsResponseFormat class
@@access(Azure.AI.Inference.ChatCompletionsResponseFormatJsonSchema,
  Access.internal,
  "csharp"
);

@@access(Azure.AI.Inference.ChatCompletionsResponseFormatJsonSchemaDefinition,
  Access.public,
  "python"
);

// In Python we hand-write the 4 input message classes, so we make them internal here.
// The base class ChatRequestMessage has to have the same access as the derived classes,
// so we make it internal as well. However the Python code will make it public again without changes.
@@access(Azure.AI.Inference.ChatCompletionsOptions, Access.internal, "python");
@@access(Azure.AI.Inference.ChatRequestMessage, Access.internal, "python");
@@access(Azure.AI.Inference.ChatRequestAssistantMessage,
  Access.internal,
  "python"
);
@@access(Azure.AI.Inference.ChatRequestSystemMessage,
  Access.internal,
  "python"
);
@@access(Azure.AI.Inference.ChatRequestToolMessage, Access.internal, "python");
@@access(Azure.AI.Inference.ChatRequestUserMessage, Access.internal, "python");
@@access(Azure.AI.Inference.ChatRequestDeveloperMessage,
  Access.internal,
  "python"
);

// Make these internal, customize a third class for users to interact with
@@access(Azure.AI.Inference.ChatMessageAudioDataContentItem, Access.internal);
@@access(Azure.AI.Inference.ChatMessageAudioUrlContentItem, Access.internal);

@@clientName(Azure.AI.Inference.ChatCompletionsResponseFormatJsonObject,
  "ChatCompletionsResponseFormatJSON",
  "javascript"
);

// We use shorter names in the Python client library
@@clientName(Azure.AI.Inference.ChatMessageContentItem,
  "ContentItem",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageTextContentItem,
  "TextContentItem",
  "python"
);
@@clientName(Azure.AI.Inference.ChatCompletionsResponseFormatJsonSchemaDefinition,
  "JsonSchemaFormat",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageImageContentItem,
  "ImageContentItem",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageImageUrl, "ImageUrl", "python");
@@clientName(Azure.AI.Inference.ChatMessageImageDetailLevel,
  "ImageDetailLevel",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageAudioDataContentItem,
  "AudioDataContentItem",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageAudioUrlContentItem,
  "AudioUrlContentItem",
  "python"
);
@@clientName(Azure.AI.Inference.ChatMessageInputAudio, "InputAudio", "python");
@@clientName(Azure.AI.Inference.ChatMessageInputAudioUrl,
  "InputAudioUrl",
  "python"
);

@client({
  name: "ChatCompletionsClient",
  service: Azure.AI.Inference,
})
interface Client1 {
  complete is Azure.AI.Inference.getChatCompletions;
  getModelInfo is Azure.AI.Inference.getModelInfo;
}

@client({
  name: "EmbeddingsClient",
  service: Azure.AI.Inference,
})
interface Client2 {
  embed is Azure.AI.Inference.getEmbeddings;
  getModelInfo is Azure.AI.Inference.getModelInfo;
}

@client({
  name: "ImageEmbeddingsClient",
  service: Azure.AI.Inference,
})
interface Client3 {
  embed is Azure.AI.Inference.getImageEmbeddings;
  getModelInfo is Azure.AI.Inference.getModelInfo;
}

@doc("The Azure.AI.Inference service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.AI.Inference.Versions.v2024_05_01_Preview)
  @doc("The 2024-05-01-preview version of the Azure.AI.Inference service.")
  v2024_05_01_Preview: "2024-05-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.AI.Inference.Versions.v2025_05_01)
  @doc("The 2025-05-01 version of the Azure.AI.Inference service.")
  v2025_05_01: "2025-05-01",
}
