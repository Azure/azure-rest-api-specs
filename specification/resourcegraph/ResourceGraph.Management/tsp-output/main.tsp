import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ResourceGraphClient",
  version: "2021-06-01-preview",
})
@server(
  "{$host}",
  "Azure Resource Graph API Reference",
  {
    $host: string,
  }
)
@doc("Azure Resource Graph API Reference")
namespace ResourceGraphClient;
