import "@typespec/rest";
import "../models/deployment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using DataApi.Models;
using DataApi.Resources.Apis;

namespace DataApi.Resources.Deployments;

// Models /////////////////////////////////////////////////////////////////////

@doc("API Deployment resource model.")
@resource("deployments")
@parentResource(ApiResource)
model ApiDeploymentResource extends ApiDeployment {
  @doc("Deployment identifier.")
  @key("deploymentId")
  @visibility("query")
  deploymentId: string;
}

interface ApiDeployments {
  @doc("List a collection of API versions.")
  listDeployments is Operations.ResourceList<ApiDeploymentResource, ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>>;

  @doc("Get an API version.")
  getDeployment is Operations.ResourceRead<ApiDeploymentResource>;
}