import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "PaloAltoNetworks.Cloudngfw",
  version: "2023-09-01",
})
@server(
  "{$host}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    $host: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace PaloAltoNetworks.Cloudngfw;
