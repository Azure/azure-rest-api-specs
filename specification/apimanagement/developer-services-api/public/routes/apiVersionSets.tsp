import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.ApiVersionSets;

@doc("API version set resource model.")
@resource("apiVersionSets")
model ApiVersionSetResource extends Api {
  @doc("API version set identifier.")
  @key("versionSetId")
  @visibility("query")
  versionSetId: string;
}

interface ApiVersionSets {
  @doc("List a collection of API version sets.")
  listApiVersionSets is ResourceList<
    ApiVersionSetResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get API version set specified by its identifier.")
  getApiVersionSet is ResourceRead<ApiVersionSetResource>;
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

interface ApiVersionSetApis {
  @doc("List a collection of API version set APIs.")
  listApiVersionSetApis is ResourceList<
    ApiVersionSetApiResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;
}
