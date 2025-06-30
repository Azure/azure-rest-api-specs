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
  "{endpoint}",
  "Azure Monitor Logs Query Service",
  {
    /** The Log Analytics service endpoint. */
    endpoint: url,
  }
)
namespace MonitorQueryLogs;

/** Service API versions */
enum Versions {
  /** The 2022-10-27 API version. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_10_27: "2022-10-27",
}
