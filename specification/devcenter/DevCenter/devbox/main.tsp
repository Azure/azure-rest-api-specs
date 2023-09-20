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
  "DevBox API.",
  {
    endpoint: string,
  }
)
@doc("DevBox API.")
namespace DevCenter;
