import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "EventHubManagementClient",
  version: "2022-10-01-preview",
})
@server(
  "{$host}",
  "Azure Event Hubs client for managing Event Hubs Cluster, IPFilter Rules and VirtualNetworkRules resources.",
  {
    $host: string,
  }
)
@doc("""
Azure Event Hubs client for managing Event Hubs Cluster, IPFilter Rules and
VirtualNetworkRules resources.
""")
namespace EventHubManagementClient;
