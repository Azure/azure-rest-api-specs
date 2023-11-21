import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Marketplace RP Service",
  version: "2023-01-01",
})
@server(
  "{$host}",
  "REST APIs for Private Marketplace",
  {
    $host: string,
  }
)
@doc("REST APIs for Private Marketplace")
namespace MarketplaceRPService;
