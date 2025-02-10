import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AI.Model.Versions.v2024_05_01_Preview)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// Are these needed?
@@usage(AI.Model.ChatCompletions, Usage.output);
@@usage(AI.Model.ModelInfo, Usage.output);
@@usage(AI.Model.StreamingChatCompletionsUpdate, Usage.output);
@@usage(AI.Model.StreamingChatChoiceUpdate, Usage.output);
@@usage(AI.Model.StreamingChatResponseMessageUpdate, Usage.output);
@@usage(AI.Model.StreamingChatResponseToolCallUpdate, Usage.output);

// Necessary for autogenerating options objects while the clients specify spread parameters. Necessary for the languages that want the options class.
@@usage(AI.Model.ChatCompletionsOptions, Usage.input, "csharp");
@@usage(AI.Model.EmbeddingsOptions, Usage.input, "csharp");
@@usage(AI.Model.ImageEmbeddingsOptions, Usage.input, "csharp");

// Necessary due to how we're forcing this abstraction
@@usage(AI.Model.ChatMessageAudioDataContentItem, Usage.input);
@@usage(AI.Model.ChatMessageAudioUrlContentItem, Usage.input);

// The operators need to be hidden, since we hand-write the public versions of those
@@access(AI.Model.getChatCompletions, Access.internal);
@@access(AI.Model.getEmbeddings, Access.internal);
@@access(AI.Model.getImageEmbeddings, Access.internal);
@@access(AI.Model.getModelInfo, Access.internal, "python");

// Since we made all operator methods internal, we need to explicity
// say we still want the models they use to be public, since they will be used by hand-written operator methods.
@@access(AI.Model.ChatChoice, Access.public);
@@access(AI.Model.ChatCompletions, Access.public);
@@access(AI.Model.ChatCompletionsToolCall, Access.public);
@@access(AI.Model.ChatCompletionsToolDefinition, Access.public);
@@access(AI.Model.ChatCompletionsNamedToolChoice, Access.public);
@@access(AI.Model.ChatCompletionsNamedToolChoiceFunction, Access.public);
@@access(AI.Model.ChatCompletionsToolCall, Access.public);
@@access(AI.Model.ChatCompletionsToolDefinition, Access.public);
@@access(AI.Model.ChatCompletionsToolChoicePreset, Access.public);
@@access(AI.Model.ChatRequestMessage, Access.public, "csharp,java,javascript");
@@access(AI.Model.ChatRequestAssistantMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(AI.Model.ChatRequestSystemMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(AI.Model.ChatRequestToolMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(AI.Model.ChatRequestUserMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(AI.Model.ChatRequestDeveloperMessage,
  Access.public,
  "csharp,java,javascript"
);
@@access(AI.Model.ChatResponseMessage, Access.public);
@@access(AI.Model.ChatRole, Access.public);
@@access(AI.Model.CompletionsFinishReason, Access.public);
@@access(AI.Model.CompletionsUsage, Access.public);
@@access(AI.Model.EmbeddingEncodingFormat, Access.public);
@@access(AI.Model.ImageEmbeddingInput, Access.public);
@@access(AI.Model.EmbeddingInputType, Access.public);
@@access(AI.Model.EmbeddingItem, Access.public);
@@access(AI.Model.EmbeddingsResult, Access.public);
@@access(AI.Model.EmbeddingsUsage, Access.public);
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

// Hide the JSON schema class in favor of a factory method on the ChatCompletionsResponseFormat class
@@access(AI.Model.ChatCompletionsResponseFormatJsonSchema,
  Access.internal,
  "csharp"
);

@@access(AI.Model.ChatCompletionsResponseFormatJsonSchemaDefinition,
  Access.public,
  "python"
);

// In Python we hand-write the 4 input message classes, so we make them internal here.
// The base class ChatRequestMessage has to have the same access as the derived classes,
// so we make it internal as well. However the Python code will make it public again without changes.
@@access(AI.Model.ChatCompletionsOptions, Access.internal, "python");
@@access(AI.Model.ChatRequestMessage, Access.internal, "python");
@@access(AI.Model.ChatRequestAssistantMessage, Access.internal, "python");
@@access(AI.Model.ChatRequestSystemMessage, Access.internal, "python");
@@access(AI.Model.ChatRequestToolMessage, Access.internal, "python");
@@access(AI.Model.ChatRequestUserMessage, Access.internal, "python");
@@access(AI.Model.ChatRequestDeveloperMessage, Access.internal, "python");

// Make these internal, customize a third class for users to interact with
@@access(AI.Model.ChatMessageAudioDataContentItem, Access.internal);
@@access(AI.Model.ChatMessageAudioUrlContentItem, Access.internal);

// We use shorter names in the Python client library
@@clientName(AI.Model.ChatMessageContentItem, "ContentItem", "python");
@@clientName(AI.Model.ChatMessageTextContentItem, "TextContentItem", "python");
@@clientName(AI.Model.ChatCompletionsResponseFormatJsonSchemaDefinition,
  "JsonSchemaFormat",
  "python"
);
@@clientName(AI.Model.ChatMessageImageContentItem,
  "ImageContentItem",
  "python"
);
@@clientName(AI.Model.ChatMessageImageUrl, "ImageUrl", "python");
@@clientName(AI.Model.ChatMessageImageDetailLevel,
  "ImageDetailLevel",
  "python"
);
@@clientName(AI.Model.ChatMessageAudioUrlContentItem,
  "AudioUrlContentItem",
  "python"
);
@@clientName(AI.Model.ChatMessageInputAudio, "InputAudio", "python");

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
