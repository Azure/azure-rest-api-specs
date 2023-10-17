import "@typespec/rest";
import "../models/api.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using DataApi.Models;

namespace DataApi.Resources.Apis;

// Models /////////////////////////////////////////////////////////////////////

@doc("API resource model.")
@resource("apis")
model ApiResource extends Api {
  @doc("API identifier.")
  @key("apiId")
  @visibility("query")
  apiId: string;
}

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Apis {
  @doc("List a collection of APIs.")
  listApis is Operations.ResourceList<ApiResource, ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>>;

  @doc("Get an API.")
  getApi is Operations.ResourceRead<ApiResource>;
}