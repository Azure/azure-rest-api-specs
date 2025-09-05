import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./operations.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
namespace Azure.AI {

}

@doc("Azure APIs for the Azure Chat protocol.")
@service(#{ title: "Azure ML Chat" })
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: [],
    }
  ]>
)
@server(
  "{endpoint}",
  "Azure Chat Protocol APIs",
  {
    endpoint: string,
  }
)
@versioned(APIVersion)
namespace Azure.AI.ChatProtocol {
  enum APIVersion {
    v20231001Preview: "2023-10-01-preview",
  }
}
