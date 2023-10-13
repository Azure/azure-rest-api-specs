import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
@doc("placeholder")
@service({
  title: "Azure ML Chat",
})
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "api-key">)
@server(
  "{endpoint}",
  "Azure ML Chat APIs",
  {
    endpoint: string,
  }
)
@versioned(APIVersion)
namespace Azure.AI.ChatProtocol;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum APIVersion {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v20231001Preview: "2023-10-01-preview",
}
