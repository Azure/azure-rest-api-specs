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
  @doc("Create a user by its identifier.")
  createUser is ResourceCreateWithServiceProvidedName<UserCreateResouce>;
}

@doc("The user resource.")
@resource("users")
model UserCreateResouce extends UserCreate {
  @doc("User id.")
  @key("userId")
  @visibility("read")
  userId: string;
}
