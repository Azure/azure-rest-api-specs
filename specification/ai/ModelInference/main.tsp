import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | BearerAuth | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ml.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "AI Model Inference" })
@server(
  "https://{resource}.services.ai.azure.com/api/models",
  "AI Model Inference",
  {
    @doc("The Azure AI Services resource name, for example 'my-resource'")
    resource: string,
  }
)
@versioned(ModelInference.Versions)
namespace ModelInference;

@doc("The AI.Model service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-01-preview version of the AI.Model service.")
  v2024_05_01_Preview: "2024-05-01-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-04-01 version of the AI.Model service.")
  v2025_04_01: "2025-04-01",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-05-01 version of the AI.Model service.")
  v2025_05_01: "2025-05-01",
}
