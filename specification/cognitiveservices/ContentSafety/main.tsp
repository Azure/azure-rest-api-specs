import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "ContentSafety Service test",
})
@versioned(ContentSafety.Versions)
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      refreshUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}/contentsafety",
  "Analyze harmful content",
  {
    @doc("""
      Supported Cognitive Services endpoints (protocol and hostname, for example:
      https://<resource-name>.cognitiveservices.azure.com).
      """)
    endpoint: string,
  }
)
@doc("Analyze harmful content")
namespace ContentSafety;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_10_01: "2023-10-01",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_09_01: "2024-09-01",
}
