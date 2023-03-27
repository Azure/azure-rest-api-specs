import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Users;

//Routes

@route("/users")
@doc("Create a new user.")
@post
op CreateUser(@body userCreate: UserCreate): CreatedApiResponse<User>;
