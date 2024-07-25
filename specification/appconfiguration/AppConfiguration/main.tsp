import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" "Custom http auth scheme"
@service({
  title: "Azure App Configuration",
})
@versioned(Versions)
@useAuth(
  SasTokenAuth | ApiKeyAuth<
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
  v2024_09_01: "2024-09-01-preview",
}

@doc("Azure App Configuration Shared Access Signature token auth")
model SasTokenAuth
  is ApiKeyAuth<ApiKeyLocation.header, "Shared Access Signature Token">;
