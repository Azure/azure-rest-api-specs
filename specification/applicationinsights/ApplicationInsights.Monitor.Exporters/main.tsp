import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * OpenTelemetry Exporter for Azure Monitor
 */
@useAuth(
  NoAuth | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://monitor.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Monitor Exporters" })
@versioned(Versions)
@server(
  "{endpoint}/{apiVersion}",
  "Azure Monitor Logs Query Service",
  {
    /** Application Insights' Breeze endpoint. */
    endpoint: url = "https://dc.services.visualstudio.com",

    /** The service API version. */
    apiVersion: Versions,
  }
)
namespace AzureMonitorExporters;

enum Versions {
  /** The V2.1 API version. */
  V2_1: "v2.1",
}
