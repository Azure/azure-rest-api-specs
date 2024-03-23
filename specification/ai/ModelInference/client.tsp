import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(
  Azure.AI.Inference.Versions.v2024_04_01_Preview
)
namespace Client;

@client({
  name: "ModelClient",
  service: Azure.AI.Inference,
})
interface ModelClient {
  getChatCompletions is Azure.AI.Inference.getChatCompletions;
}
