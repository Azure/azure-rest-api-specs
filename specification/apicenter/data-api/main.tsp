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
  title: "Data API",
  version: "2024-03-01",
})
@server(
  "https://{serviceName}.data.azure-apicenter.net",
  "Data API service endpoint",
  {
    @doc("Region-unique API Center service name")
    serviceName: string,
  }
)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@doc("Data API introduces endpoints to manage your API Center resources.")
namespace DataApi;