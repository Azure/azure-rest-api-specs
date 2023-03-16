import "@typespec/rest";
import "../models/common.tsp";
import "../models/api.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAPI.Resources.Apis;

model CommonParams {
  @path apiId: string;
}

// @get op List<T>(...ListParams): T;

@route("/apis")
@doc("Lists a collection of APIs.")
op ListApis(...ListParams): Collection<Api> | ErrorResponse;

@get
@route("/apis/{apiId}")
@doc("Gets the details of the API specified by its identifier.")
op GetApi(...CommonParams): Api | ErrorResponse;
