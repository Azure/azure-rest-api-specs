import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["user_impersonation"],
    }
  ]>
)
@service({
  title: "DevCenter",
})
@server(
  "{endpoint}",
  "DevCenter service",
  {
    endpoint: string,
  }
)
@doc("DevCenter service")
@versioned(APIVersions)
namespace DevCenter;

@doc("DevCenter API versions")
enum APIVersions {
  @doc("The 2023-04-01 service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",
}