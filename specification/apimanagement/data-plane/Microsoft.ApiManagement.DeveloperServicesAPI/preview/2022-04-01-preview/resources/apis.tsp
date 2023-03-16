import "@typespec/rest";
import "../models/common.tsp";
import "../models/api.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAPI.Resources.Apis;

model CommonParams {
  @path apiId: string;
}

@route("/apis")
@doc("Lists a collection of APIs.")
@get
op ListApis(...ListParams): ApiResponse<Collection<Api>>;

@route("/apis/{apiId}")
@doc("Gets the details of the API specified by its identifier.")
@get
op GetApi(...CommonParams): ApiResponse<Api>;
