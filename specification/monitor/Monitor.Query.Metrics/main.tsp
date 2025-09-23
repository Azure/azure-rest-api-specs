import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://metrics.monitor.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Monitor Query Metrics" })
@versioned(Versions)
@server(
  "{endpoint}",
  "Azure Monitor Metrics Query Service",
  {
    /**
     * The regional endpoint to use, for example https://eastus.metrics.monitor.azure.com. The region should match
     * the region of the requested resources. For global resources, the region should be 'global'.
     *
     */
    endpoint: url,
  }
)
namespace MonitorQueryMetrics;

/** Service API versions */
enum Versions {
  /** The 2024-02-01 API version. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_02_01: "2024-02-01",
}
