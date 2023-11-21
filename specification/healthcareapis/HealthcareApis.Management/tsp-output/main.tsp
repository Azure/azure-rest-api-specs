import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "HealthcareApisManagementClient",
  version: "2022-06-01",
})
@server(
  "{$host}",
  "Azure Healthcare APIs Client",
  {
    $host: string,
  }
)
@doc("Azure Healthcare APIs Client")
namespace HealthcareApisManagementClient;
