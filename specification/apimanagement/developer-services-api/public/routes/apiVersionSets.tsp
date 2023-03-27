import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/apiVersionSet.tsp";
import "../../models/api.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.ApiVersionSets;

@route("/apiVersionSets")
@doc("List a collection of API version sets.")
@get
op ListApiVersionSets(...ListParams): ApiResponse<Collection<ApiVersionSet>>;

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
): ApiResponse<Collection<Api>>;

model CommonParams {
  @path versionSetId: string;
}
