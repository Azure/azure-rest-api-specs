import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "HybridNetworkManagementClient",
  version: "2023-09-01",
})
@server(
  "{$host}",
  "The definitions in this swagger specification will be used to manage the Hybrid Network resources.",
  {
    $host: string,
  }
)
@doc("""
The definitions in this swagger specification will be used to manage the Hybrid
Network resources.
""")
namespace HybridNetworkManagementClient;
