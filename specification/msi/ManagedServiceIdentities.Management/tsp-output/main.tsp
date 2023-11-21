import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "ManagedServiceIdentityClient",
  version: "2023-01-31",
})
@server(
  "{$host}",
  "The Managed Service Identity Client.",
  {
    $host: string,
  }
)
@doc("The Managed Service Identity Client.")
namespace ManagedServiceIdentityClient;
