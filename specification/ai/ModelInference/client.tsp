import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(ModelInference.Versions.v2024_04_01_Preview)
namespace Client;

@client({
  name: "ModelClient",
  service: ModelInference,
})

interface ModelClient {
  getChatCompletions is ModelInference.getChatCompletions;
}
