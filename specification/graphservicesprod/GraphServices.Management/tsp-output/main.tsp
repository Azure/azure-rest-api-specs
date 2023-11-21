import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "GraphServices",
  version: "2023-04-13",
})
@server(
  "{$host}",
  "Self service experience for Microsoft Graph metered services",
  {
    $host: string,
  }
)
@doc("Self service experience for Microsoft Graph metered services")
namespace GraphServices;
