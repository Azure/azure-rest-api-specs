import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Open Energy Platform Management Service APIs",
  version: "2022-04-04-preview",
})
@server(
  "{$host}",
  "Open Energy Platform Management Service APIs",
  {
    $host: string,
  }
)
@doc("Open Energy Platform Management Service APIs")
namespace OpenEnergyPlatformManagementServiceAPIs;
