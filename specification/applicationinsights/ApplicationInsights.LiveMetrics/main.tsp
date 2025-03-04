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

@doc("Live Metrics REST APIs.")
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://monitor.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Live Metrics REST APIs for client SDKs." })
@server(
  "{endpoint}",
  "Existing Live Metrics global endpoint.",
  {
    @doc("The endpoint of the Live Metrics service.")
    endpoint: string = "https://global.livediagnostics.monitor.azure.com",
  }
)
namespace Azure.Monitor.LiveMetrics;

@doc("Live Metrics service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-04-01-preview version of the Live Metrics service.")
  v2024_04_01_preview: "2024-04-01-preview",
}
