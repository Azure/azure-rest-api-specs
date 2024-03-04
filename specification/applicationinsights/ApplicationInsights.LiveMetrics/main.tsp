import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@doc("QuickPulse REST APIs.")
@versioned(Versions)
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "x-ms-qps-auth-api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["user_impersonation"],
    }
  ]>
)
@service({ title: "QuickPulse REST APIs for client SDKs." })
@server("https://rt.services.visualstudio.com", "Existing QuickPulse global endpoint.")
@server("https://live.monitor.azure.com", "Existing QuickPulse global endpoint.")
@server("https://live.applicationinsights.azure.com", "Existing QuickPulse global endpoint.")
@server(
  "https://{region}.diagnostics.monitor.azure.com",
  "Suggested QuickPulse regional endpoint.", 
  {
    @doc("The region of the server that hosts the client SDK.")
    region: "string"
  }
)
namespace LiveMetrics;

@doc("QuickPulse service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-04-01-preview version of the LiveMetrics service.")
  v2024_04_01_preview: "2024-04-01-preview",
}