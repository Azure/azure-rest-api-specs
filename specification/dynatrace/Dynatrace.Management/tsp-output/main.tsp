import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Dynatrace.Observability",
  version: "2021-09-01",
})
@server(
  "{$host}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    $host: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Dynatrace.Observability;
