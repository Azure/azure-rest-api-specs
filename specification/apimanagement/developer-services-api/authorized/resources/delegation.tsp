import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/delegation.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Resources.Delegation;

@route("/delegation/urls/users/{userId}/{action}")
@doc("User specific delegation urls (CloseAccount, ChangePassword, ChangeProfile, Subscribe, Unsubscribe, Renew, Signout).")
@post
op CreateUserDelegationUrl(
  ...ApiVersionParameter,

  @doc("User identifier.")
  @path
  userId: string,

  @doc("The action to perform.")
  @path
  action: string,

  @doc("The URL to redirect to after the user has signed in.")
  @body
  userDelegationOperationRequest: UserDelegationOperationRequest
): ApiResponse<UserDelegationOperationResponse>;
