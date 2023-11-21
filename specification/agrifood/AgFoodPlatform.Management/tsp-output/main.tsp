import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure AgFoodPlatform RP Service",
  version: "2021-09-01-preview",
})
@server(
  "{$host}",
  "APIs documentation for Azure AgFoodPlatform Resource Provider Service.",
  {
    $host: string,
  }
)
@doc("APIs documentation for Azure AgFoodPlatform Resource Provider Service.")
namespace AzureAgFoodPlatformRPService;
