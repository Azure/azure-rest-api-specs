import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure Traffic Collector",
  version: "2022-11-01",
})
@server(
  "{$host}",
  "Azure Traffic Collector service",
  {
    $host: string,
  }
)
@doc("Azure Traffic Collector service")
namespace AzureTrafficCollector;
