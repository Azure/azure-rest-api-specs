import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

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
@service({
  title: "AI Model Inference",
})
@versioned(ModelInference.Versions)
namespace ModelInference;

@doc("The AI.Model service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-01-preview version of the AI.Model service.")
  v2024_05_01_Preview: "2024-05-01-preview",
}
