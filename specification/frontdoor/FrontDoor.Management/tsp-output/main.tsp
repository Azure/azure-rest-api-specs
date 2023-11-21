import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "FrontDoorManagementClient",
})
@server(
  "{$host}",
  "FrontDoor Client",
  {
    $host: string,
  }
)
@doc("FrontDoor Client")
namespace FrontDoorManagementClient;
