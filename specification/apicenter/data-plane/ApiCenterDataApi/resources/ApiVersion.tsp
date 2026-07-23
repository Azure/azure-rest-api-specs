import "@typespec/rest";
import "../models/models.tsp";
import "../models/apiVersion.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

interface ApiVersions {
  @doc("List a collection of API versions.")
  listVersions is Operations.ResourceList<
    ApiVersion,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API version.")
  getVersion is Operations.ResourceRead<ApiVersion>;
}
