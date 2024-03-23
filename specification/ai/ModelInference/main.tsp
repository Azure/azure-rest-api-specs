import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./routes/completions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.contoso.com/common/oauth2/v2.0/authorize",
      scopes: ["https://widget.contoso.com/.default"],
    }
  ]>
)
@service({
  title: "Azure.AI.Inference service",
})
@versioned(Azure.AI.Inference.Versions)
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCase"
namespace Azure.AI.Inference;

@doc("The Azure.AI.Inference service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-04-01-preview version of the Azure.AI.Inference service.")
  v2024_04_01_Preview: "2024-04-01-preview",
}

