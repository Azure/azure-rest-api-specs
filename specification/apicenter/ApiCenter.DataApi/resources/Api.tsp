import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "../models/api.tsp";
import "../models/models.tsp";

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
  list is Operations.ResourceList<
    Api,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("List a collection of APIs in a workspace.")
  listByWorkspace is Operations.ResourceList<
    ApiInWorkspace,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API.")
  get is Operations.ResourceRead<ApiInWorkspace>;
}
