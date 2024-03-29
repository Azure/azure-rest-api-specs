import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Resources
import "./models/models.tsp";
import "./resources/api.tsp";
import "./resources/apiDefinition.tsp";
import "./resources/deployment.tsp";
import "./resources/environment.tsp";
import "./resources/apiVersion.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://azure-apicenter.net/user_impersonation"]>)
@service({
  title: "Azure API Center Data API",
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