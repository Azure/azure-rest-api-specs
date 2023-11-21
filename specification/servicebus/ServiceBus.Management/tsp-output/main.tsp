import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ServiceBusManagementClient",
  version: "2022-10-01-preview",
})
@server(
  "{$host}",
  "Azure Service Bus client for managing Namespace",
  {
    $host: string,
  }
)
@doc("Azure Service Bus client for managing Namespace")
namespace ServiceBusManagementClient;
