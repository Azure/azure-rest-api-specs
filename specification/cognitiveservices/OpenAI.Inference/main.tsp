import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> |
    OAuth2Auth<[{
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://cognitiveservices.azure.com/.default"]
    }]>)
@service(
  {
    title: "Azure OpenAI API"
  })
@server(
  "{endpoint}/openai",
  "Azure OpenAI APIs for completions and search",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://westus.api.cognitive.microsoft.com).
""")
    endpoint: string,
  }
)
@versioned(ServiceApiVersions)
@versionedDependency(
  [
    [
      ServiceApiVersions.v2022_12_01,
      Azure.Core.Versions.v1_0_Preview_1
    ]
  ]
)
@doc("Azure OpenAI APIs for completions and search")
namespace Azure.OpenAI;

enum ServiceApiVersions {
  v2022_12_01: "2022-12-01",
}


@doc("A specific deployment")
@TypeSpec.Rest.resource("deployments")
model Deployment {
  @visibility("read")
  @doc("deployment id of the deployed model")
  @key
  deploymentId: string;
}
