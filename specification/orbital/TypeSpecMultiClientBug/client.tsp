import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Versions.v2025_01_01)
namespace Customizations;

using TypeSpecMultiClientBug;

@client(
  {
    service: TypeSpecMultiClientBug,
    name: "DogClient",
  },
  "python"
)
interface DogClient {
  getDog is Dogs.get;
}

@client(
  {
    service: TypeSpecMultiClientBug,
    name: "CatClient",
  },
  "python"
)
interface CatClient {
  getCat is Cats.get;
}
