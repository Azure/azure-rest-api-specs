import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "DevCenter",
  version: "2023-04-01",
})
@server(
  "{endpoint}",
  "// FIXME: (miissing-service-description) Add service description",
  {
    endpoint: string,
  }
)
@doc("// FIXME: (miissing-service-description) Add service description")
namespace DevCenter;
