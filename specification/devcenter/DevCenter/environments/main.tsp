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
  "Deployment Environments API.",
  {
    endpoint: string,
  }
)
@doc("Deployment Environments API.")
namespace DevCenter;
