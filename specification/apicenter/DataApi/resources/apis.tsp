import "@typespec/rest";
import "../models/api.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi.Models;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

interface Apis {
  @doc("List a collection of all APIs.")
  listAll is Operations.ResourceList<
    Api,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("List a collection of APIs in a workspace.")
  list is Operations.ResourceList<
    ApiWithWorkspace,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API.")
  get is Operations.ResourceRead<ApiWithWorkspace>;
}
