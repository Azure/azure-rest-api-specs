import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./client.tsp";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@service(#{ title: "Azure App Configuration Feature Flag" })
@versioned(Versions)
@useAuth(

    | ApiKeyAuth<ApiKeyLocation.header, "Connection String">
    | OAuth2Auth<[
        {
          type: OAuth2FlowType.implicit,
          authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
          scopes: ["https://azconfig.io/.default"],
        }
      ]>
)
@server(
  "{endpoint}",
  "App Configuration service endpoint",
  {
    endpoint: url,
  }
)
@doc("Azure App Configuration Feature Flag REST API")
namespace AppConfigurationFeatureFlag;

@doc("Service API versions")
enum Versions {
  @Azure.Core.previewVersion
  @doc("The 2026-05-01-preview API version")
  v2026_05_01_preview: "2026-05-01-preview",
}
