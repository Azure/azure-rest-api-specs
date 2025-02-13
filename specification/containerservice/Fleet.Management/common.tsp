import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@added(Versions.v2025_03_01)
@doc("Represents label object.")
model Label {
  @doc("Key for a label.")
  key: string;

  @doc("Value for a label.")
  value: string;
}