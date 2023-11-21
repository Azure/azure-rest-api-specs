import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "SignalRManagementClient",
  version: "2022-02-01",
})
@server(
  "{$host}",
  "REST API for Azure SignalR Service",
  {
    $host: string,
  }
)
@doc("REST API for Azure SignalR Service")
namespace SignalRManagementClient;
