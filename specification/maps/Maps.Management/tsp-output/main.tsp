import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "AzureMapsManagementClient",
  version: "2021-12-01-preview",
})
@server(
  "{$host}",
  "Azure Maps",
  {
    $host: string,
  }
)
@doc("Azure Maps")
namespace AzureMapsManagementClient;
