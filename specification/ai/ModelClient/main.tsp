import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  BearerAuth | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "AI Model Inference" })
@versioned(Azure.AI.Inference.Versions)
namespace Azure.AI.Inference;

@doc("The Azure.AI.Inference service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-01-preview version of the Azure.AI.Inference service.")
  v2024_05_01_Preview: "2024-05-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-05-01 version of the Azure.AI.Inference service.")
  v2025_05_01: "2025-05-01",
}
