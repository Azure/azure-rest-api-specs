import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "NginxManagementClient",
  version: "2022-08-01",
})
@server(
  "{$host}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    $host: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace NginxManagementClient;
