import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "TrafficController",
  version: "2023-11-01",
})
@server(
  "{$host}",
  "Traffic Controller Provider management API.",
  {
    $host: string,
  }
)
@doc("Traffic Controller Provider management API.")
namespace TrafficController;
