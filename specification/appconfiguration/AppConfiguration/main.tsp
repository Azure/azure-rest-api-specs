import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure App Configuration",
})
@versioned(Versions)
@useAuth(
  SasTokenAuth<"SAS", "authorization header"> | ApiKeyAuth<
    ApiKeyLocation.header,
    "Connection String"
  > | OAuth2Auth<[
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
@doc("Azure App Configuration REST API")
namespace AzureAppConfiguration;

@doc("Service API versions")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-09-01-preview API version")
  v2024_09_01_preview: "2024-09-01-preview",
}

model SasTokenAuth<TScheme extends string, TLocation extends string> {
  type: AuthType.apiKey;
  name: TScheme;
  in: TLocation;
}
