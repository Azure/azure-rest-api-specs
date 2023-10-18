import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Resources
import "./resources/apis.tsp";
import "./resources/definitions.tsp";
import "./resources/deployments.tsp";
import "./resources/environments.tsp";
import "./resources/versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Authorization">)
@service({
  title: "Data API"
})
@server(
  "https://{serviceName}.data.azure-apicenter.net",
  "Data API service endpoint",
  {
    @doc("Region-unique API Center service name")
    serviceName: string,
  }
)
@versioned(ApiCenter.DataApi.Versions)
@doc("Data API introduces endpoints to manage your API Center resources.")
namespace ApiCenter.DataApi;

@doc("API versions")
enum Versions {
  @doc("GA release version 2024-03-01")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_03_01: "2024-03-01",
}