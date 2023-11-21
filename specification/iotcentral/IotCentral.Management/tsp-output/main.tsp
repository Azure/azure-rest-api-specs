import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "IotCentralClient",
  version: "2021-11-01-preview",
})
@server(
  "{$host}",
  "Use this API to manage IoT Central Applications in your Azure subscription.",
  {
    $host: string,
  }
)
@doc("Use this API to manage IoT Central Applications in your Azure subscription.")
namespace IotCentralClient;
