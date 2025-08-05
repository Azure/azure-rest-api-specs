import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Azure Monitor data collection client.
 */
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://monitor.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Monitor Ingestion" })
@versioned(Versions)
@server(
  "{endpoint}",
  "Azure Monitor Logs Ingestion API",
  {
    /** The Data Collection Endpoint for the Data Collection Rule. For example, https://dce-name.eastus-2.ingest.monitor.azure.com */
    endpoint: url,
  }
)
namespace LogsIngestion;

@doc("Service API versions")
enum Versions {
  /**
   * The 2023-01-01 API version.
   */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_01_01: "2023-01-01",
}
