import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Microsoft.SecurityDevOps",
  version: "2022-09-01-preview",
})
@server(
  "{$host}",
  "REST APIs for Defender for DevOps",
  {
    $host: string,
  }
)
@doc("REST APIs for Defender for DevOps")
namespace Microsoft.SecurityDevOps;
