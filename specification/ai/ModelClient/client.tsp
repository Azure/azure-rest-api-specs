import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(ModelClient.Versions.v2024_04_01_Preview)
namespace Customizations; // The actual name here doesn't matter and is here for organization purposes only

// The "Update" models are used by the hand-written operation method that supports streaming.
// We need to declare their usage and public access, otherwise they won't be emited in the generated code.
@@access(ModelClient.ChatCompletionsUpdate, Access.public);
@@usage(ModelClient.ChatCompletionsUpdate, Usage.output);
@@access(ModelClient.ChatChoiceUpdate, Access.public);
@@usage(ModelClient.ChatChoiceUpdate, Usage.output);

@client({
  name: "ChatClient",
  service: ModelClient,
})
interface Client1 {
  getChatCompletions is ModelClient.getChatCompletions;
  getModelInfo is ModelClient.getModelInfo;
}

@client({
  name: "EmbeddingsClient",
  service: ModelClient,
})
interface Client2 {
  getEmbeddings is ModelClient.getEmbeddings;
  getModelInfo is ModelClient.getModelInfo;
}

@client({
  name: "ImageGenerationClient",
  service: ModelClient,
})
interface Client3 {
  generateImages is ModelClient.generateImages;
  getModelInfo is ModelClient.getModelInfo;
}
