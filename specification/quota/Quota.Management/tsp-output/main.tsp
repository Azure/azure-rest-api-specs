import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure Quota Extension API",
  version: "2023-02-01",
})
@server(
  "{$host}",
  "Microsoft Azure Quota Resource Provider",
  {
    $host: string,
  }
)
@doc("Microsoft Azure Quota Resource Provider")
namespace AzureQuotaExtensionAPI;
