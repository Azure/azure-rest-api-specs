import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.ApiVersionSets;

interface ApiVersionSets {
  @doc("List a collection of API version sets.")
  listApiVersionSets is ResourceList<
    ApiVersionSetResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get API version set specified by its identifier.")
  getApiVersionSet is ResourceRead<ApiVersionSetResource>;

  @doc("List a collection of API version set APIs.")
  listApiVersionSetApis is ResourceList<
    ApiVersionSetApiResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;
}

@doc("API version set resource model.")
@resource("apiVersionSets")
@parentResource(UserResource)
model ApiVersionSetResource extends ApiVersionSet {
  @doc("API version set identifier.")
  @key("versionSetId")
  @visibility("query")
  versionSetId: string;
}

@doc("API version set' API resource model.")
@resource("apis")
@parentResource(ApiVersionSetResource)
model ApiVersionSetApiResource extends Api {
  @doc("API identifier.")
  @key("apiId")
  @visibility("query")
  apiId: string;
}
