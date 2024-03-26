import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure App Configuration",
})
@versioned(Versions)
@server(
  "{endpoint}",
  "App Configuration service endpoint",
  {
    endpoint: string,
  }
)
@doc("Azure App Configuration REST API")
namespace AzureAppConfiguration;

@doc("Service API versions")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2023-11-01 API version")
  v2023_11_01: "2023-11-01",
}
