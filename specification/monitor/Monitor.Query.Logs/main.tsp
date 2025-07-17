import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://api.loganalytics.io/.default"],
    }
  ]>
)
@service(#{ title: "Monitor Query Logs" })
@versioned(Versions)
@server(
  "{endpoint}/{apiVersion}",
  "Azure Monitor Logs Query Service",
  {
    /** The Log Analytics service endpoint. */
    endpoint: url = "https://api.loganalytics.io",

    /** The service API version. */
    apiVersion: Versions,
  }
)
namespace MonitorQueryLogs;

/** Service API versions */
enum Versions {
  /** The V1 API version. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  V1: "v1",
}
