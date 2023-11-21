import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "AttestationManagementClient",
  version: "2020-10-01",
})
@server(
  "{$host}",
  "Various APIs for managing resources in attestation service. This primarily encompasses per-provider management.",
  {
    $host: string,
  }
)
@doc("""
Various APIs for managing resources in attestation service. This primarily
encompasses per-provider management.
""")
namespace AttestationManagementClient;
