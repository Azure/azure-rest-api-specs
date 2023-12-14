import "@typespec/rest";
import "../models/environment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi.Models;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

// Models /////////////////////////////////////////////////////////////////////

@doc("Environment resource model.")
@resource("environments")
model EnvironmentResource extends Environment {
  @doc("Environment identifier.")
  @key("environmentName")
  @visibility("query")
  environmentName: string;
}

// Operations //////////////////////////////////////////////////////////////////

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Environments {
  @doc("List a collection of environments.")
  listEnvironments is Operations.ResourceList<
    EnvironmentResource,
    ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>
  >;

  @doc("Get an environment.")
  getEnvironment is Operations.ResourceRead<EnvironmentResource>;
}
