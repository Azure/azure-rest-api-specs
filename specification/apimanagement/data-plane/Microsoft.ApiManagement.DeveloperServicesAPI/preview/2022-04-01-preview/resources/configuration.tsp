import "@typespec/rest";
import "../models/common.tsp";
import "../models/configuration.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAPI.Resources.Configuration;

//Routes

@route("/configuration/content")
@doc("List a collection of API version sets.")
@get
op GetContentSettings(): ApiResponse<ContentSettings>;

@route("/configuration/signup")
@doc("Get API version set specified by its identifier.")
@get
op GetSignupSettings(): ApiResponse<SignupConfiguration>;
