import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Workload Monitor API",
  version: "2020-01-13-preview",
})
@server(
  "{$host}",
  "Workload Monitor API",
  {
    $host: string,
  }
)
@doc("Workload Monitor API")
namespace WorkloadMonitorAPI;
