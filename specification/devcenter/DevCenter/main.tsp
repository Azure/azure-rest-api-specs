import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./DevBox/routes.tsp";
import "./DevCenter/routes.tsp";
import "./Environments/routes.tsp";

using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://devcenter.azure.com/.default"],
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
    @doc("The DevCenter-specific URI to operate on.")
    endpoint: url,
  }
)
@doc("DevCenter service")
@versioned(APIVersions)
namespace DevCenterService;

@doc("DevCenter API versions")
enum APIVersions {
  @doc("The 2023-04-01 service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  @doc("The 2024-02-01 service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2024_02_01: "2024-02-01",

  @doc("The 2024-05-01-preview service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2024_05_01_preview: "2024-05-01-preview",

  @doc("The 2024-08-01-preview service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2024_08_01_preview: "2024-08-01-preview",

  @doc("The 2024-09-01-preview service API version")
  @useDependency(Versions.v1_0_Preview_2)
  v2024_09_01_preview: "2024-09-01-preview",
}
