import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "SearchManagementClient",
  version: "2023-11-01",
})
@server(
  "{$host}",
  "Client that can be used to manage Azure Cognitive Search services and API keys.",
  {
    $host: string,
  }
)
@doc("Client that can be used to manage Azure Cognitive Search services and API keys.")
namespace SearchManagementClient;
