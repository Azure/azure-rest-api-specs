import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Resources
import "./models/models.tsp";
import "./resources/Api.tsp";
import "./resources/ApiDefinition.tsp";
import "./resources/Deployment.tsp";
import "./resources/Environment.tsp";
import "./resources/ApiVersion.tsp";
import "./resources/Workspace.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://azure-apicenter.net/user_impersonation"]>)
@service({
  title: "Azure API Center Data API test",
})
@server(
  "https://{serviceName}.data.{region}.azure-apicenter.ms",
  "Data API service endpoint",
  {
    @doc("Region-unique API Center service name")
    serviceName: string,

    @doc("Region name")
    region: string,
  }
)
@versioned(ApiCenter.DataApi.Versions)
@doc("Data API introduces endpoints to manage your API Center resources.")
namespace ApiCenter.DataApi;
