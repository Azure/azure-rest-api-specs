import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure VMware Solution API",
  version: "2022-05-01",
})
@server(
  "{$host}",
  "Azure VMware Solution API",
  {
    $host: string,
  }
)
@doc("Azure VMware Solution API")
namespace AzureVMwareSolutionAPI;
