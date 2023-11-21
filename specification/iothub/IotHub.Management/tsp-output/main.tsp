import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "iotHubClient",
  version: "2023-06-30",
})
@server(
  "{$host}",
  "Use this API to manage the IoT hubs in your Azure subscription.",
  {
    $host: string,
  }
)
@doc("Use this API to manage the IoT hubs in your Azure subscription.")
namespace iotHubClient;
