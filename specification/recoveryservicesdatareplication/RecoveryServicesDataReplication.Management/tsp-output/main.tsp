import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure Site Recovery Management Service API",
  version: "2021-02-16-preview",
})
@server(
  "{$host}",
  "A first party Azure service enabling the data replication.",
  {
    $host: string,
  }
)
@doc("A first party Azure service enabling the data replication.")
namespace AzureSiteRecoveryManagementServiceAPI;
