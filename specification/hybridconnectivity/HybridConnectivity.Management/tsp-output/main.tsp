import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Hybrid Connectivity Management API",
  version: "2021-10-06-preview",
})
@server(
  "{$host}",
  "REST API for Hybrid Connectivity",
  {
    $host: string,
  }
)
@doc("REST API for Hybrid Connectivity")
namespace HybridConnectivityManagementAPI;
