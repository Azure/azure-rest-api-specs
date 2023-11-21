import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "DnsManagementClient",
  version: "2018-05-01",
})
@server(
  "{$host}",
  "The DNS Management Client.",
  {
    $host: string,
  }
)
@doc("The DNS Management Client.")
namespace DnsManagementClient;
