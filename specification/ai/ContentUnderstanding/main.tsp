import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./models.tsp";
import "./documentContent.tsp";
import "./audioVisualContent.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@doc("The Content Understanding service extracts content and fields from multimodal input.")
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Content Understanding" })
@server(
  "{endpoint}/contentunderstanding",
  "The Content Understanding service extracts content and fields from multimodal input.",
  {
    @doc("Content Understanding service endpoint.")
    endpoint: url,
  }
)
@versioned(ContentUnderstanding.Versions)
namespace ContentUnderstanding;

@doc("Service API versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-12-01-preview version of the Content Understanding service.")
  v2024_12_01_preview: "2024-12-01-preview",
}
