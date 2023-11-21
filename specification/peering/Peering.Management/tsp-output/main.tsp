import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "PeeringManagementClient",
  version: "2022-10-01",
})
@server(
  "{$host}",
  "Peering Client",
  {
    $host: string,
  }
)
@doc("Peering Client")
namespace PeeringManagementClient;
