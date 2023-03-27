import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAuthorizedAPI.Routes.ApiVersionSets;

@route("/users/{userId}/apiVersionSets")
@doc("List a collection of API version sets.")
@get
op ListApiVersionSets(
  ...UserParams,
  ...ListParams
): ApiResponse<Collection<ApiVersionSet>>;

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
): ApiResponse<Collection<Api>>;

model CommonParams {
  @path versionSetId: string;
}
