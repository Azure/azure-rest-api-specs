import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "NotificationHubsManagementClient",
  version: "2017-04-01",
})
@server(
  "{$host}",
  "Azure NotificationHub client",
  {
    $host: string,
  }
)
@doc("Azure NotificationHub client")
namespace NotificationHubsManagementClient;
