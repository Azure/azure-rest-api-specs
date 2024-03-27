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

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Environments {
  @doc("List a collection of all environments.")
  listAll is Operations.ResourceList<
    Environment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("List a collection of environments in a workspace.")
  list is Operations.ResourceList<
    EnvironmentWithWorkspace,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an environment.")
  get is Operations.ResourceRead<EnvironmentWithWorkspace>;
}
