import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "iotDpsClient",
  version: "2022-02-05",
})
@server(
  "{$host}",
  "API for using the Azure IoT Hub Device Provisioning Service features.",
  {
    $host: string,
  }
)
@doc("API for using the Azure IoT Hub Device Provisioning Service features.")
namespace iotDpsClient;
