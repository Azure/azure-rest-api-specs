import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ChaosManagementClient",
  version: "2023-04-15-preview",
})
@server(
  "{$host}",
  "Chaos Management Client",
  {
    $host: string,
  }
)
@doc("Chaos Management Client")
namespace ChaosManagementClient;
