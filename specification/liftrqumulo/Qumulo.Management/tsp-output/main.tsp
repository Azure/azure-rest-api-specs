import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Qumulo.Storage",
  version: "2022-10-12",
})
@server(
  "{$host}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    $host: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace Qumulo.Storage;
