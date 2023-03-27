import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Users;

@route("/users")
@doc("Create a new user.")
@post
op CreateUser(
  @doc("The user to create.")
  @body
  userCreate: UserCreate
): CreatedApiResponse<User>;
