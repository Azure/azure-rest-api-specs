import "@typespec/rest";
import "../models/common.tsp";
import "../models/user.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesAPI.Resources.Users;

//Routes

@route("/users")
@doc("Create a new user.")
@post
op ListTags(@body userCreate: UserCreate): CreatedApiResponse<User>;
