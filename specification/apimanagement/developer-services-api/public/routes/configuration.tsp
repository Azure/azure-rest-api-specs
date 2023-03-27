import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/configuration.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Configuration;

@route("/configuration/content")
@doc("Get content settings.")
@get
op GetContentSettings(): ApiResponse<ContentSettings>;

@route("/configuration/signup")
@doc("Get signup settings.")
@get
op GetSignupSettings(): ApiResponse<SignupConfiguration>;
