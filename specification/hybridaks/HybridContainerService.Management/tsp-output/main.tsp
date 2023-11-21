import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "HybridContainerService",
  version: "2022-09-01-preview",
})
@server(
  "{$host}",
  "The Microsoft.HybridContainerService Rest API spec.",
  {
    $host: string,
  }
)
@doc("The Microsoft.HybridContainerService Rest API spec.")
namespace HybridContainerService;
