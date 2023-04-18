import "@typespec/rest";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "BatchServiceClient",
  version: "2022-10-01.16.0",
})
@server(
  "{endpoint}",
  "Batch Account endpoint",
  {
    @doc("""
    Supported Batch Service endpoints (protocol and hostname, for example:
    https://mybatchaccount.mybatchregion.batch.azure.com).
    """)
    endpoint: url,
  }
)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://batch.core.windows.net//.default"],
    }
  ]>
)
@versioned(BatchService.Versions)
@doc("A client for issuing REST requests to the Azure Batch service.")
namespace BatchService;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_10_01: "2022-10-01.16.0",
}