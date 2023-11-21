import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "RedisEnterpriseManagementClient",
  version: "2023-03-01-preview",
})
@server(
  "{$host}",
  "REST API for managing Redis Enterprise resources in Azure.",
  {
    $host: string,
  }
)
@doc("REST API for managing Redis Enterprise resources in Azure.")
namespace RedisEnterpriseManagementClient;
