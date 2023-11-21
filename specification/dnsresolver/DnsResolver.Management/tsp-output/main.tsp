import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "DnsResolverManagementClient",
  version: "2022-07-01",
})
@server(
  "{$host}",
  "The DNS Resolver Management Client.",
  {
    $host: string,
  }
)
@doc("The DNS Resolver Management Client.")
namespace DnsResolverManagementClient;
