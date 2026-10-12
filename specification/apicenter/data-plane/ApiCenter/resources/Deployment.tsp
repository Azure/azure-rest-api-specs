import "@typespec/rest";
import "../models/models.tsp";
import "../models/deployment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

interface ApiDeployments {
  @doc("List a collection of API deployments.")
  listDeployments is Operations.ResourceList<
    ApiDeployment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API deployment.")
  getDeployment is Operations.ResourceRead<ApiDeployment>;
}
