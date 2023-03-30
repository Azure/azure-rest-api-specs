import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Users;

@route("/users")
@doc("Create a new user.")
@post
op CreateUser(
  ...ApiVersionParameter,

  @doc("The user to create.")
  @body
  userCreate: UserCreate
): CreatedApiResponse<User>;
