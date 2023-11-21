import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ServiceLinkerManagementClient",
  version: "2022-05-01",
})
@server(
  "{$host}",
  "Microsoft.ServiceLinker provider",
  {
    $host: string,
  }
)
@doc("Microsoft.ServiceLinker provider")
namespace ServiceLinkerManagementClient;
