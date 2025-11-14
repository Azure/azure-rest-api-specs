import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * OpenTelemetry Exporter for Azure Monitor
 */
#suppress "@azure-tools/typespec-autorest/unsupported-auth" "NoAuth is supported"
@useAuth(NoAuth)
@service(#{ title: "Azure Monitor Exporter" })
@versioned(Versions)
@server(
  "{host}/{apiVersion}",
  "Azure Monitor Logs Query Service",
  {
    /** Application Insights' Breeze endpoint. */
    host: url = "https://dc.services.visualstudio.com",

    /** The service API version. */
    apiVersion: Versions,
  }
)
namespace AzureMonitorExporter;

enum Versions {
  /** The V2.1 API version. */
  V2_1: "v2.1",
}
