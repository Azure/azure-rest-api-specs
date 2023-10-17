import "@typespec/rest";
import "../models/version.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using DataApi.Models;
using DataApi.Resources.Apis;

namespace DataApi.Resources.ApiVersions;

// Models /////////////////////////////////////////////////////////////////////

@doc("API Version resource model.")
@resource("versions")
@parentResource(ApiResource)
model ApiVersionResource extends ApiVersion {
  @doc("Version identifier.")
  @key("versionId")
  @visibility("query")
  versionId: string;
}

interface ApiVersions {
  @doc("List a collection of API versions.")
  listVersions is Operations.ResourceList<ApiVersionResource, ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>>;

  @doc("Get an API version.")
  getVersion is Operations.ResourceRead<ApiVersionResource>;
}