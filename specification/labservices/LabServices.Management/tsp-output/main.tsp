import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "LabServicesClient",
  version: "2022-08-01",
})
@server(
  "{$host}",
  "REST API for managing Azure Lab Services images.",
  {
    $host: string,
  }
)
@doc("REST API for managing Azure Lab Services images.")
namespace LabServicesClient;
