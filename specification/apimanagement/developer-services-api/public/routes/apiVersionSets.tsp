import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.ApiVersionSets;

@route("/apiVersionSets")
@doc("List a collection of API version sets.")
@get
op ListApiVersionSets(...ListParams): ApiResponse<Page<ApiVersionSet>>;

@route("/apiVersionSets/{versionSetId}")
@doc("Get API version set specified by its identifier.")
@get
op GetApiVersionSet(...CommonParams): ApiResponse<ApiVersionSet>;

@route("/apiVersionSets/{versionSetId}/apis")
@doc("List a collection of API version set APIs specified by its identifier.")
@get
op ListApiVersionSetApis(
  ...ListParams,
  ...CommonParams
): ApiResponse<Page<Api>>;

@doc("Common parameters.")
model CommonParams {
  @doc("API version set identifier.")
  @path
  versionSetId: string;
}
