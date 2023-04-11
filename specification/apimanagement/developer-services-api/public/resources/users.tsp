import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Users;

interface Users {
  @route("/users")
  @doc("Create a new user.")
  @post
  CreateUser(
    ...ApiVersionParameter,

    @doc("The user to create.")
    @body
    userCreate: UserCreate
  ): CreatedApiResponse<User>;
}
