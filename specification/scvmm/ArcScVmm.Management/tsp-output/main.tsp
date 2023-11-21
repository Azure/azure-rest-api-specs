import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "SCVMM",
  version: "2020-06-05-preview",
})
@server(
  "{$host}",
  "The Microsoft.ScVmm Rest API spec.",
  {
    $host: string,
  }
)
@doc("The Microsoft.ScVmm Rest API spec.")
namespace SCVMM;
