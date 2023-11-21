import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ConnectedKubernetesClient",
  version: "2021-10-01",
})
@server(
  "{$host}",
  "Azure Connected Cluster Resource Provider API for adopting any Kubernetes Cluster",
  {
    $host: string,
  }
)
@doc("""
Azure Connected Cluster Resource Provider API for adopting any Kubernetes
Cluster
""")
namespace ConnectedKubernetesClient;
