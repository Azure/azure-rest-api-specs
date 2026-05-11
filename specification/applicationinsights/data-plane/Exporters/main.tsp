import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * OpenTelemetry Exporter for Azure Monitor
 */
#suppress "@azure-tools/typespec-autorest/unsupported-auth" "NoAuth used by clients, but not supported by openapi3 emitter"
@useAuth(NoAuth | AadOauth2Auth<["https://monitor.azure.com/.default"]>)
@service(#{ title: "Azure Monitor Exporter" })
@versioned(Versions)
@server(
  "{host}/{apiVersion}",
  "Azure Monitor OpenTelemetry Exporter Service",
  {
    /** Application Insights' Breeze host. */
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
