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
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://discovery.azure.com/.default"],
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
