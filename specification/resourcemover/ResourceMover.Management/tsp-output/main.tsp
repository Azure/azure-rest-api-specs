import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Resource Mover Service API",
  version: "2023-08-01",
})
@server(
  "{$host}",
  "A first party Azure service orchestrating the move of Azure resources from one Azure region to another or between zones within a region.",
  {
    $host: string,
  }
)
@doc("""
A first party Azure service orchestrating the move of Azure resources from one
Azure region to another or between zones within a region.
""")
namespace ResourceMoverServiceAPI;
