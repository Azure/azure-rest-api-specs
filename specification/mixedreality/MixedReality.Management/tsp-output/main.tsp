import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "MixedRealityClient",
  version: "2021-03-01-preview",
})
@server(
  "{$host}",
  "Mixed Reality Client",
  {
    $host: string,
  }
)
@doc("Mixed Reality Client")
namespace MixedRealityClient;
