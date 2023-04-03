import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/user.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.Users;

interface Users {
  @route("/users/{userId}")
  @doc("Get a user profile by its identifier.")
  @get
  GetUser(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string
  ): ApiResponse<User>;

  @route("/users/{userId}")
  @doc("Create or updatea a user by its identifier.")
  @patch
  CreateOrUpdateUser(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string,
    @header @friendlyName("If-Match") ifMatch: string,
    @body userUpdate: UserUpdate
  ): ApiResponse<User>;

  @route("/users/{userId}")
  @doc("Delete a user by its identifier.")
  @delete
  DeleteUser(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string
  ): NoContentResponse | ErrorResponse;

  @route("/users/{userId}/token/revoke")
  @doc("Revoke the token of a user by its identifier.")
  @post
  RevokeToken(
    ...ApiVersionParameter,

    @doc("User identifier.")
    @path
    userId: string
  ): NoContentResponse | ErrorResponse;
}
