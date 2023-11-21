import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "DeviceUpdate",
  version: "2022-10-01",
})
@server(
  "{$host}",
  "Microsoft Device Update resource provider.",
  {
    $host: string,
  }
)
@doc("Microsoft Device Update resource provider.")
namespace DeviceUpdate;
