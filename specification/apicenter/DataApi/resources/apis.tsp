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
  @doc("List a collection of APIs.")
  list is Operations.ResourceList<
    Api,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API.")
  get is Operations.ResourceRead<Api>;
}
