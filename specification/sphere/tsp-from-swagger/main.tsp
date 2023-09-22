import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "AzureSphereManagementClient",
  version: "2022-09-01-preview",
})
@server(
  "{$host}",
  "Azure Sphere resource management API.",
  {
    $host: string,
  }
)
@doc("Azure Sphere resource management API.")
namespace AzureSphereManagementClient;
