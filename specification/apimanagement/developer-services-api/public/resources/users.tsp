import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Resources.Users;

interface Users {
  //TODO: find a workaround
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
