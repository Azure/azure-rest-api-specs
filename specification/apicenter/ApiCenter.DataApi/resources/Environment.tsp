import "@typespec/rest";
import "../models/models.tsp";
import "../models/environment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi.Models;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;


interface Environments {
  @doc("List a collection of all environments.")
  list is Operations.ResourceList<
    Environment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("List a collection of environments in a workspace.")
  listByWorkspace is Operations.ResourceList<
    EnvironmentInWorkspace,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an environment.")
  get is Operations.ResourceRead<EnvironmentInWorkspace>;
}
