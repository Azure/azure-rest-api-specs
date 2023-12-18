import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Resources
import "./resources/apis.tsp";
import "./resources/apiDefinitions.tsp";
import "./resources/deployments.tsp";
import "./resources/environments.tsp";
import "./resources/apiVersions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://azure-apicenter.net/user_impersonation"]>)
@service({
  title: "Data API",
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
  @doc("Preview release version 2024-02-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_02_01_preview: "2024-02-01-preview",
}
