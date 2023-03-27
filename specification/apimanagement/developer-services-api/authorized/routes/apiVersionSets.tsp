import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.ApiVersionSets;

@route("/users/{userId}/apiVersionSets")
@doc("List a collection of API version sets.")
@get
op ListApiVersionSets(
  ...UserParams,
  ...ListParams
): ApiResponse<Page<ApiVersionSet>>;

@route("/users/{userId}/apiVersionSets/{versionSetId}")
@doc("Get API version set specified by its identifier.")
@get
op GetApiVersionSet(...UserParams, ...CommonParams): ApiResponse<ApiVersionSet>;

@route("/users/{userId}/apiVersionSets/{versionSetId}/apis")
@doc("List a collection of API version set APIs specified by its identifier.")
@get
op ListApiVersionSetApis(
  ...UserParams,
  ...ListParams,
  ...CommonParams
): ApiResponse<Page<Api>>;

model CommonParams {
  @path versionSetId: string;
}
