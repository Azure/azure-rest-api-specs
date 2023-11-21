import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "PrivateDnsManagementClient",
  version: "2020-06-01",
})
@server(
  "{$host}",
  "The Private DNS Management Client.",
  {
    $host: string,
  }
)
@doc("The Private DNS Management Client.")
namespace PrivateDnsManagementClient;
