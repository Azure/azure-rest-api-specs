import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./shared.tsp";
import "./_knowledgeBase.tsp";
import "./_knowledgeBase_version.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.discovery.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://bookshelf.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft.Bookshelf service" })
@versioned(Microsoft.Discovery.Bookshelf.Versions)
@server(
  "{endpoint}",
  "Discovery Bookshelf API",
  {
    @doc("""
      Supported Microsoft Bookshelf Services endpoints (protocol and hostname, for example: https://{bookshelfName}.discovery.azure.com).
      """)
    endpoint: url,
  }
)
namespace Microsoft.Discovery.Bookshelf;
