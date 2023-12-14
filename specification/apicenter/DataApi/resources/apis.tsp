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

// Models /////////////////////////////////////////////////////////////////////

@doc("API resource model.")
@resource("apis")
model ApiResource extends Api {
  @doc("API identifier.")
  @key("apiName")
  @visibility("query")
  apiName: string;
}

interface Apis {
  @doc("List a collection of APIs.")
  listApis is Operations.ResourceList<
    ApiResource,
    ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>
  >;

  @doc("Get an API.")
  getApi is Operations.ResourceRead<ApiResource>;
}
