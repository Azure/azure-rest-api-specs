import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/identity.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Identity;

@route("/identity")
@doc("Identity of current user.")
@get
op GetIdentity(): ApiResponse<IdentityResult>;
