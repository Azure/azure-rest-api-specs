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

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Environments {
  @doc("List a collection of environments.")
  listEnvironments is Operations.ResourceList<
    Environment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an environment.")
  getEnvironment is Operations.ResourceRead<Environment>;
}
